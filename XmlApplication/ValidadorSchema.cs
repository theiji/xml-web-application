using System;
using System.IO;
using System.Xml;
using System.Xml.Schema;

namespace XmlApplication
{
    public class ValidadorSchema
    {
        private static string ErroValidadorXML;

        public static void Validar(Stream arquivoXML, string schemaXML)
        {
            try
            {
                XmlReaderSettings xmlSettings = new XmlReaderSettings
                {
                    ValidationType = ValidationType.Schema
                };
                xmlSettings.Schemas.Add(null, schemaXML);
                xmlSettings.ValidationEventHandler += new ValidationEventHandler(XmlSettingsValidationEventHandler);

                XmlReader xml = XmlReader.Create(arquivoXML, xmlSettings);
                ErroValidadorXML = string.Empty;
                while (xml.Read()) { }
                xml.Close();

                if (!string.IsNullOrEmpty(ErroValidadorXML))
                    throw new SchemaXmlException(ErroValidadorXML);
            }
            catch (SchemaXmlException ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private static void XmlSettingsValidationEventHandler(object sender, ValidationEventArgs e)
        {
            if (e.Severity == XmlSeverityType.Warning)
                ErroValidadorXML += "Cuidado: \n" + e.Message + "\n";
            else if (e.Severity == XmlSeverityType.Error)
                ErroValidadorXML += "ERRO: \n" + e.Message + "\n";
            else
                ErroValidadorXML += "ERRO: \n" + e.Message + "\n";
        }
    }
}