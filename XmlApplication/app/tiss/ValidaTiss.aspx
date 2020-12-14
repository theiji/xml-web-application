    <%@ Page Title="Validar Arquivo TISS" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ValidaTiss.aspx.cs" Inherits="XmlApplication.app.tiss.ValidaTiss" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="../../Scripts/jquery-3.5.1.min.js"></script>
    <script src="../../Scripts/umd/popper.min.js"></script>
    <script src="../../Scripts/bootstrap.min.js"></script>

    <script lang="javascript" type="text/javascript">

        $(document).ready(function () {
            $('#MainContent_FileUpload1').on('change', function () {
                var fileName = $(this).val().split('\\').pop();
                $(this).next('.custom-file-label').html(fileName);
            })
        })

        $(function () {
            $('[data-toggle="tooltip"]').tooltip();
            $('[data-toggle="popover"]').popover();
        })

        function CopiarTexto() {
            var copyText = document.getElementById("MainContent_TxtMD5");

            var copyFrom = document.createElement("textarea");

            copyFrom.textContent = copyText.value;

            document.body.appendChild(copyFrom);

            copyFrom.select();

            document.execCommand('copy');

            copyFrom.blur();

            document.body.removeChild(copyFrom);
        }
    </script>

    <h2 class="pt-4"><%: Title %></h2>

    <div class="jumbotron">

        <div class="input-group mb-3">
            <div class="input-group-prepend">
                <span class="input-group-text">Arquivo</span>
            </div>
            <div class="custom-file">
                <asp:FileUpload ID="FileUpload1" runat="server" class="custom-file-input" aria-describedby="inputGroupFileAddon01" Style="min-width: 100%" />
                <label class="custom-file-label" for="FileUpload1">Escolha o arquivo</label>
            </div>
        </div>

        <div class="btn-group btn-block" role="group" aria-label="Actions">
            <button type="button" class="btn btn-lg btn-success" runat="server" onserverclick="BtnValidar_Click" style="min-width: 80%">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="22" fill="currentColor" class="bi bi-calculator" viewBox="0 2 18 16">
                    <path fill-rule="evenodd" d="M12 1H4a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h8a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1zM4 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H4z" />
                    <path d="M4 2.5a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-.5.5h-7a.5.5 0 0 1-.5-.5v-2zm0 4a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1zm0 3a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1zm0 3a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1zm3-6a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1zm0 3a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1zm0 3a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1zm3-6a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1zm0 3a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v4a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-4z" />
                </svg>
                Calcular Hash
           
            </button>
            <button type="button" class="btn btn-lg btn-secondary" runat="server" onserverclick="BtnCancelar_Click">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="22" fill="currentColor" class="bi bi-power" viewBox="0 2 18 16">
                    <path fill-rule="evenodd" d="M5.578 4.437a5 5 0 1 0 4.922.044l.5-.866a6 6 0 1 1-5.908-.053l.486.875z" />
                    <path fill-rule="evenodd" d="M7.5 8V1h1v7h-1z" />
                </svg>
                Cancelar
           
            </button>
        </div>

        <div class="progress">
            <div id="PgsProgresso" class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" runat="server"></div>
        </div>

    </div>

    <div class="card">
        <div class="card-header text-white bg-primary">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="22" fill="currentColor" class="bi bi-calendar2-check" viewBox="0 2 18 16">
                <path fill-rule="evenodd" d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM2 2a1 1 0 0 0-1 1v11a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V3a1 1 0 0 0-1-1H2z" />
                <path d="M2.5 4a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5H3a.5.5 0 0 1-.5-.5V4z" />
                <path fill-rule="evenodd" d="M10.854 8.146a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 0 1 .708-.708L7.5 10.793l2.646-2.647a.5.5 0 0 1 .708 0z" />
            </svg>
            Resposta
        </div>
        <div class="card-body">

            <div class="input-group mb-3">
                <div class="input-group-prepend">
                    <span class="input-group-text bg-dark text-light" style="min-width: 110px">MD5</span>
                </div>
                <input type="text" id="TxtMD5" class="form-control col-md-12" runat="server" readonly>
                <div class="input-group-append" data-toggle="tooltip" title="Copiar para a área de transferência">
                    <button type="button" id="btnCopiar" class="btn btn-info" onclick="CopiarTexto()" data-trigger="focus" data-toggle="popover" data-placement="right" data-content="Copiado">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="18" fill="currentColor" class="bi bi-clipboard" viewBox="0 2 18 16">
                            <path fill-rule="evenodd" d="M4 1.5H3a2 2 0 0 0-2 2V14a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V3.5a2 2 0 0 0-2-2h-1v1h1a1 1 0 0 1 1 1V14a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V3.5a1 1 0 0 1 1-1h1v-1z" />
                            <path fill-rule="evenodd" d="M9.5 1h-3a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm-3-1A1.5 1.5 0 0 0 5 1.5v1A1.5 1.5 0 0 0 6.5 4h3A1.5 1.5 0 0 0 11 2.5v-1A1.5 1.5 0 0 0 9.5 0h-3z" />
                        </svg>
                    </button>
                </div>
            </div>

            <div class="input-group mb-3">
                <div class="input-group-prepend">
                    <span class="input-group-text bg-dark text-light" style="min-width: 110px" id="basic-addon1">Mensagens</span>
                </div>
                <textarea class="form-control col-md-12" name="TxtMsg" id="TxtMsg" runat="server" rows="5" readonly></textarea>
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
                <div class="modal-header" id="modal-header">
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
