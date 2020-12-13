using System;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using XmlApplication.Util;

namespace XmlApplication.App.TISS
{
    public partial class ValidaTiss : Page
    {
        private int _count;
        private enum TipoMensagem
        {
            Sucesso,
            Alerta,
            Erro,
            Info
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void BtnValidaTiss_Click(object sender, EventArgs e)
        {
            LimparView();

            if (!FileUpload1.HasFile)
            {
                ExibirMensagem("Atenção", "Selecionar um arquivo.Favor verificar", TipoMensagem.Alerta);
                FileUpload1.Focus();
            }
            else if (string.IsNullOrWhiteSpace(FileUpload1.PostedFile.FileName))
            {
                ExibirMensagem("Atenção", "Selecionar um arquivo.Favor verificar", TipoMensagem.Alerta);
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
                    ExibirMensagem("Erro", "Arquivo no formato inválido. Favor verificar", TipoMensagem.Erro);
                }
                catch (OperationCanceledException)
                {
                    ExibirMensagem("Erro", "Operação cancelada pelo usuário", TipoMensagem.Erro);
                }
                catch (SchemaXmlException ex)
                {
                    TxtMsg.Value = ex.Message;
                    ExibirMensagem("Erro", "Arquivo com estrutura inválido. Favor verificar", TipoMensagem.Erro);
                }
                catch (Exception ex)
                {
                    TxtMsg.Value = ex.Message;
                    ExibirMensagem("Erro", "Arquivo inválido. Favor verificar", TipoMensagem.Erro);
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
            var tempoDecorrido = $"{ elapsedTime.Seconds }.{ elapsedTime.Milliseconds} segundos!";
            var mensagem = $"Processado em {tempoDecorrido}";

            TxtTempo.Text = mensagem;
        }

        private void ValidarArquivo()
        {
            string xml2txt = "";
            string hashInfo = "";

            using (Stream stream = FileUpload1.PostedFile.InputStream)
            {
                using (StreamReader reader = new StreamReader(stream))
                {
                    string fileContents = reader.ReadToEnd();

                    //ler a string em um objeto xmldocument
                    var xmlDoc = new XmlDocument();
                    xmlDoc.LoadXml(fileContents);
                    var nsmgr = new XmlNamespaceManager(xmlDoc.NameTable);
                    nsmgr.AddNamespace("", "http://www.ans.gov.br/padroes/tiss/schemas");

                    //pegar a versão do tiss
                    XmlNode versaoNode = xmlDoc.SelectSingleNode("//*[local-name()='padrao']", nsmgr);
                    if (versaoNode == null)
                    {
                        versaoNode = xmlDoc.SelectSingleNode("//*[local-name()='versaoPadrao']", nsmgr);
                    }

                    //validar o arquivo com os schemas
                    if (ValidarVersaoTiss(versaoNode.InnerText))
                    {
                        stream.Position = 0;
                        ValidadorSchema.Validar(stream, Server.MapPath(string.Format($"Schemas\\TISS_V{versaoNode.InnerText}\\tissV3_02_00.xsd")));
                    }

                    _count = 0;
                    XmlNode nodeList = xmlDoc.SelectSingleNode("//*[local-name()='cabecalho']/*", nsmgr)?.ParentNode?.ParentNode;
                    foreach (XmlNode root in nodeList)
                    {
                        switch (root.LocalName.ToString())
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
            var hashCalc = CalculateMD5Hash(xml2txt)?.ToUpper();
            TxtMD5.Value = hashCalc;

            //comparar o hash enviado com o calculado 
            if (hashInfo != hashCalc)
            {
                TxtMsg.Value += "HASH INVÁLIDO\r\nINFORMADO: " + hashInfo + "\r\nCALCULADO: " + hashCalc;
            }
            else
            {
                TxtMsg.Value += "HASH OK!!!";
            }
        }

        private bool ValidarVersaoTiss(string versao)
        {
            bool versaoValida = false;
            switch (versao)
            {
                case "3.02.00":
                    versaoValida = true; break;
                case "3.03.00":
                    versaoValida = true; break;
                case "3.04.00":
                    versaoValida = true; break;
                case "3.04.01":
                    versaoValida = true; break;
                default:
                    TxtMsg.Value = string.Format($"Versão {versao} inválida ou não configurada.\r\n");
                    break;
            }
            return versaoValida;
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
                if (ExisteCaracterEspecial(root.Value))
                {
                    _count++;
                    TxtMsg.Value += "ERRO - " + _count.ToString() + "\r\n" + root.Value + "\r\n" + "\r\n";
                }
            }
        }

        private bool ExisteCaracterEspecial(string texto)
        {
            var count = 0;
            UnicodeCategory[] allowedCategories = { UnicodeCategory.MathSymbol, UnicodeCategory.CurrencySymbol, UnicodeCategory.ModifierSymbol };
            foreach (char c in texto)
            {
                if (char.IsSymbol(c))
                {
                    if (!allowedCategories.Contains(CharUnicodeInfo.GetUnicodeCategory(c)))
                        count++;
                }
            }

            return count > 0;
        }

        public static string CalculateMD5Hash(string input)
        {
            System.Security.Cryptography.MD5CryptoServiceProvider md5Hasher = new System.Security.Cryptography.MD5CryptoServiceProvider();
            byte[] hash = md5Hasher.ComputeHash(Encoding.Default.GetBytes(input));

            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < hash.Length; i++)
            {
                sb.Append(hash[i].ToString("X2"));
            }
            return sb.ToString().ToLower();
        }

        private void ExibirMensagem(string cabecalho, string texto, TipoMensagem tipo)
        {
            string mensagem = $"javascript: $('#modal-title').html('{cabecalho}');";
            switch (tipo)
            {
                case TipoMensagem.Sucesso:
                    mensagem += "$('#modal-header').attr('class','modal-header bg-success text-light');";
                    mensagem += "$('#modal-message').attr('class','text-success');";
                    break;
                case TipoMensagem.Alerta:
                    mensagem += "$('#modal-header').attr('class','modal-header bg-warning text-light');";
                    mensagem += "$('#modal-message').attr('class','text-warning');";
                    break;
                case TipoMensagem.Erro:
                    mensagem += "$('#modal-header').attr('class','modal-header bg-danger text-light');";
                    mensagem += "$('#modal-message').attr('class','text-danger');";
                    break;
                case TipoMensagem.Info:
                    mensagem += "$('#modal-header').attr('class','modal-header bg-info text-light');";
                    mensagem += "$('#modal-message').attr('class','text-info');";
                    break;
                default:
                    break;
            }

            mensagem += $"$('#modal-message').html('{texto}');";
            mensagem += "$('#myModal').modal('show');";

            Page.ClientScript.RegisterStartupScript(GetType(), "", mensagem, true);
        }
    }
}
