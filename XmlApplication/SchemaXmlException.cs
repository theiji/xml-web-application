using System;
using System.Runtime.Serialization;

namespace XmlApplication
{
    [Serializable]
    internal class SchemaXmlException : Exception
    {
        public SchemaXmlException()
        {
        }

        public SchemaXmlException(string message) : base(message)
        {
        }

        public SchemaXmlException(string message, Exception innerException) : base(message, innerException)
        {
        }

        protected SchemaXmlException(SerializationInfo info, StreamingContext context) : base(info, context)
        {
        }
    }
}