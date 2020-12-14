using System;
using System.IO;
using System.Text;
using System.Web.UI;
using System.Xml;
using XmlApplication.Util;

namespace XmlApplication.App.SIB
{
    public partial class ValidaSib : Page
    {
        private int _count;

        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void BtnValidaSib_Click(object sender, EventArgs e)
        {
            LimparView();

            if (!FileUpload1.HasFile || string.IsNullOrWhiteSpace(FileUpload1.PostedFile.FileName))
            {
                Utils.ExibirMensagem("Atenção", "Selecionar um arquivo.Favor verificar", Util.Enum.TipoMensagem.Alerta, this);
                FileUpload1.Focus();
            }
            else
            {
                FileUpload1.Enabled = false;

                var inicio = DateTime.Now;

                try
                {
                    ValidarArquivo();

                    var fim = DateTime.Now;
                    AtualizarView(fim - inicio);
                }
                catch (XmlException)
                {
                    Utils.ExibirMensagem("Erro", "Arquivo no formato inválido. Favor verificar", Util.Enum.TipoMensagem.Erro, this);
                }
                catch (OperationCanceledException)
                {
                    Utils.ExibirMensagem("Erro", "Operação cancelada pelo usuário", Util.Enum.TipoMensagem.Erro, this);
                }
                catch (SchemaXmlException ex)
                {
                    TxtMsg.Value += ex.Message;
                    Utils.ExibirMensagem("Erro", "Arquivo com estrutura inválido. Favor verificar", Util.Enum.TipoMensagem.Erro, this);
                }
                catch (Exception ex)
                {
                    TxtMsg.Value += ex.Message;
                    Utils.ExibirMensagem("Erro", "Arquivo inválido. Favor verificar", Util.Enum.TipoMensagem.Erro, this);
                }
                finally
                {
                    FileUpload1.Enabled = true;
                }
            }
        }

        private void LimparView()
        {
            TxtMD5.Value = "";
            TxtMsg.Value = "";
            TxtTempo.Text = "";
        }

        private void AtualizarView(TimeSpan elapsedTime)
        {
            var tempoDecorrido = $"{elapsedTime.Seconds}.{elapsedTime.Milliseconds} segundos!";
            var mensagem = $"Processado em {tempoDecorrido}";

            TxtTempo.Text = mensagem;
        }

        private void ValidarArquivo()
        {
            string xml2txt = "";
            string hashInfo = "";

            using (Stream stream = FileUpload1.PostedFile.InputStream)
            {
                TxtMsg.Value += $"Arquivo: {FileUpload1.PostedFile.FileName}{Environment.NewLine}";

                using (StreamReader reader = new StreamReader(stream, Encoding.Default))
                {
                    string fileContents = reader.ReadToEnd();

                    //ler a string em um objeto xmldocument
                    var xmlDoc = new XmlDocument();
                    xmlDoc.LoadXml(fileContents);

                    //validar o arquivo com os schemas
                    stream.Position = 0;
                    ValidadorSchema.Validar(stream, Server.MapPath(string.Format($"Schemas\\sib.xsd")));

                    _count = 0;
                    var nodeList = xmlDoc.SelectNodes("//mensagemSIB/*");
                    foreach (XmlNode root in nodeList)
                    {
                        switch (root.Name.ToString())
                        {
                            case "cabecalho":
                                xml2txt += root.InnerText;
                                break;
                            case "epilogo":
                                hashInfo = root.InnerText?.ToUpper();
                                break;
                            case "hash":
                                hashInfo = root.InnerText?.ToUpper();
                                break;
                            default:
                                xml2txt += root.InnerText;

                                //validar se os valores dos textos contém caracteres especiais não válidos no xml
                                ReadXML(root);
                                break;
                        }
                    }
                }
            }

            //calcular o hash
            var hashCalc = Utils.CalculateMD5Hash(xml2txt)?.ToUpper();
            TxtMD5.Value = hashCalc;

            //comparar o hash enviado com o calculado 
            if (hashInfo != hashCalc)
            {
                TxtMsg.Value += $"HASH INVÁLIDO{Environment.NewLine}INFORMADO: {hashInfo}{Environment.NewLine}CALCULADO: {hashCalc}";
            }
            else
            {
                TxtMsg.Value += "HASH OK!!!";
            }
        }

        private void ReadXML(XmlNode root)
        {
            if (root is XmlElement)
            {
                if (root.HasChildNodes)
                    ReadXML(root.FirstChild);
                if (root.NextSibling != null)
                    ReadXML(root.NextSibling);
            }
            else if (root is XmlText)
            {
                if (Utils.ExisteCaracterEspecial(root.Value))
                {
                    _count++;
                    TxtMsg.Value += $"ERRO - {_count}{Environment.NewLine}{root.Value}{Environment.NewLine}{Environment.NewLine}";
                }
            }
        }
    }
}