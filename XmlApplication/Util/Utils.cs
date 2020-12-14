using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;

namespace XmlApplication.Util
{
    public class Utils
    {
        public static bool ExisteCaracterEspecial(string texto)
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

        public static void ExibirMensagem(string cabecalho, string texto, Enum.TipoMensagem tipo, Page page)
        {
            string mensagem = $"javascript: $('#modal-title').html('{cabecalho}');";
            switch (tipo)
            {
                case Enum.TipoMensagem.Sucesso:
                    mensagem += "$('#modal-header').attr('class','modal-header bg-success text-light');";
                    mensagem += "$('#modal-message').attr('class','text-success');";
                    break;
                case Enum.TipoMensagem.Alerta:
                    mensagem += "$('#modal-header').attr('class','modal-header bg-warning text-light');";
                    mensagem += "$('#modal-message').attr('class','text-warning');";
                    break;
                case Enum.TipoMensagem.Erro:
                    mensagem += "$('#modal-header').attr('class','modal-header bg-danger text-light');";
                    mensagem += "$('#modal-message').attr('class','text-danger');";
                    break;
                case Enum.TipoMensagem.Info:
                    mensagem += "$('#modal-header').attr('class','modal-header bg-info text-light');";
                    mensagem += "$('#modal-message').attr('class','text-info');";
                    break;
                default:
                    break;
            }

            mensagem += $"$('#modal-message').html('{texto}');";
            mensagem += "$('#myModal').modal('show');";

            page.ClientScript.RegisterStartupScript(page.GetType(), "", mensagem, true);
        }

    }
}