<%@ Page Title="Validar Arquivo TISS" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ValidaTiss.aspx.cs" Inherits="XmlApplication.App.TISS.ValidaTiss" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %>.</h2>

    <script lang="javascript" type="text/javascript">
        function CopiarTexto() {
            var copyText = document.getElementById("MainContent_TxtMD5");

            var copyFrom = document.createElement("textarea");

            copyFrom.textContent = copyText.value;

            document.body.appendChild(copyFrom);

            copyFrom.select();

            document.execCommand('copy');

            copyFrom.blur();

            document.body.removeChild(copyFrom);

            $("#modal-title").html("Texto copiado para a área de transferência:");
            $("#modal-header").attr("class", "modal-header bg-success");
            $("#modal-message").html(copyText.value);
            $("#modal-message").attr("class", "text-info");
            $('#myModal').modal("show");
            $('#modal-footer').focus();
        }
    </script>

    <div class="jumbotron">
        <div class="input-group mb-3">
            <div class="input-group-prepend">
                <span class="input-group-text">Arquivo</span>
            </div>
            <div class="custom-file">
                <asp:FileUpload ID="FileUpload1" runat="server" class="custom-file-input" aria-describedby="inputGroupFileAddon01" style="min-width:100%" />
                <label class="custom-file-label" for="FileUpload1">Escolha o arquivo</label>
            </div>
        </div>

        <div class="input-group sm-3">
            <button class="btn btn-success btn-lg btn-block" runat="server" onserverclick="BtnValidaTiss_Click"><i class="glyphicon glyphicon-cog"></i>&nbsp;Calcular Hash</button>
        </div>
    </div>

    <div class="card">
        <div class="card-header text-white bg-primary">
            <i class="bi bi-calculator-fill"></i>&nbsp;Resposta
        </div>
        <div class="card-body">

            <div class="input-group mb-3">
                <div class="input-group-prepend">
                    <span class="input-group-text" style="min-width:110px">MD5</span>
                </div>
                <input type="text" id="TxtMD5" class="form-control" runat="server" style="min-width:83.1%" readonly>
                <div class="input-group-append">
                    <button type="button" class="btn btn-info" onclick="CopiarTexto()" data-toggle="tooltip" data-placement="right" title="Copiar para a área de transferência">
                        <i class="glyphicon glyphicon-copy" aria-hidden="true"></i>&nbsp;Copiar</button>
                </div>
            </div>

            <div class="input-group mb-3">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="basic-addon1" style="min-width:110px">Mensagens</span>
                </div>
                <textarea class="form-control" name="TxtMsg" id="TxtMsg" runat="server" style="min-width: 90%" rows="5" readonly></textarea>
            </div>

            <div class="input-group mb-3">
                <div class="input-group-prepend">
                    <asp:Label ID="TxtTempo" runat="server" class="control-label"></asp:Label>
                </div>
            </div>

        </div>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="myModal" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modal-title"></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" id="modal-body">
                    <p id="modal-message"></p>
                </div>
                <div class="modal-footer">
                    <button type="button" id="modal-footer" class="btn btn-danger" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
