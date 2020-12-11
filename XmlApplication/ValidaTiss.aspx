<%@ Page Title="Validar Arquivo TISS" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ValidaTiss.aspx.cs" Inherits="XmlApplication.ValidaTiss" %>

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
        }
    </script>

    <div class="row">
        <div class="col-md-12 jumbotron">
            <label class="col-md-1 control-label">Arquivo</label>
            <div class="col-md-11">
                <asp:FileUpload ID="FileUpload" runat="server" Width="100%" />
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            &nbsp;
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <asp:Button ID="BtnValidaTiss" runat="server" class="btn btn-success btn-lg btn-block" Text="Calcular Hash" OnClick="BtnValidaTiss_Click" />
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            &nbsp;
        </div>
    </div>

    <div class="panel panel-primary">
        <div class="panel-heading"><i class="glyphicon glyphicon-check" aria-hidden="true"></i>&nbsp;Resposta</div>
        <div class="panel-body">

            <div class="row">
                <label class="col-md-1 control-label">MD5</label>
                <div class="col-md-11">
                    <div class="input-group">
                        <input type="text" name="TxtMD5" id="TxtMD5" class="form-control" runat="server" style="min-width: 100%" disabled>
                        <div class="input-group-btn">
                            <button type="button" class="btn btn-info" onclick="CopiarTexto()" data-toggle="modal" data-target=".bs-example-modal-sm" title="Copiar para a área de transferência">
                                <i class="glyphicon glyphicon-copy" aria-hidden="true"></i>&nbsp;Copiar</button>
                        </div>
                    </div>
                </div>

            </div>

            <div class="row">
                <div class="col-md-12">
                    &nbsp;
                </div>
            </div>

            <div class="row">
                <label class="col-md-1 control-label">Mensagens</label>
                <div class="col-md-11">
                    <textarea class="form-control" name="TxtMsg" id="TxtMsg" runat="server" style="min-width: 100%" rows="5" disabled></textarea>
                </div>
            </div>

            <div class="row">
                <label class="col-md-1 control-label"></label>
                <div class="col-md-11">
                    <asp:Label ID="TxtTempo" runat="server" class="col-md-11 control-label"></asp:Label>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="myModal" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header" id="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title" id="modal-title"></h4>
                </div>
                <div class="modal-body" id="modal-body">
                    <p id="modal-message"></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>

        </div>
    </div>


</asp:Content>
