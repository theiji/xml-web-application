<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="XmlApplication._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>Theiji</h1>
        <p class="lead"></p>
        <p>
            <a href="https://github.com/theiji" class="btn btn-primary btn-lg" target="_blank">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="22" fill="currentColor" class="bi bi-github" viewBox="0 2 18 16">
                    <path fill-rule="evenodd" d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27.68 0 1.36.09 2 .27 1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.012 8.012 0 0 0 16 8c0-4.42-3.58-8-8-8z" />
                </svg>
                Github &raquo;</a>
        </p>
    </div>

    <div class="container">
        <!-- Example row of columns -->
        <div class="row">
            <div class="col-md-6">
                <h2>TISS</h2>
                <p>A Troca de Informações na Saúde Suplementar - TISS foi estabelecida como um padrão obrigatório para as trocas eletrônicas de dados de atenção à saúde dos beneficiários de planos, entre os agentes da Saúde Suplementar. O objetivo é padronizar as ações administrativas, subsidiar as ações de avaliação e acompanhamento econômico, financeiro e assistencial das operadoras de planos privados de assistência à saúde e compor o Registro Eletrônico de Saúde.
O padrão TISS tem por diretriz a interoperabilidade entre os sistemas de informação em saúde preconizados pela Agência Nacional de Saúde Suplementar e pelo Ministério da Saúde, e, ainda, a redução da assimetria de informações para os beneficiários de planos privados de assistência à saúde.
                </p>
                <p><a class="btn btn-secondary" target="_blank" href="http://www.ans.gov.br/prestadores/tiss-troca-de-informacao-de-saude-suplementar">View details &raquo;</a></p>
            </div>
            <div class="col-md-6">
                <h2>SIB</h2>
                <p>É o sistema informatizado que contém os dados cadastrais dos beneficiários de planos privados de saúde no Brasil. É composto por três grupos de dados os quais devem ser atualizados pelas operadoras sempre que houver alguma alteração. São eles: Identificação pessoal do beneficiário / Identificação de endereço / Informações contratuais</p>
                <p><a class="btn btn-secondary" target="_blank" href="http://www.ans.gov.br/prestadores/tiss-troca-de-informacao-de-saude-suplementar">View details &raquo;</a></p>
            </div>
        </div>
    </div>

</asp:Content>
