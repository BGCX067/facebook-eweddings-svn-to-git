<%@ Page Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="PantallaPrincipal.aspx.cs" Debug="true" Inherits="PantallaPrincipal" %>

<%@ Register Assembly="facebook.web" Namespace="facebook.web" TagPrefix="cc1" %>
<%@ MasterType VirtualPath="~/Site.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" runat="Server">
        
    <table cellspacing="0" cellpadding="0" border="0" width="100%">
        <tr>
            <td align=center>
                <asp:Label ID="lblTitle" runat="server" Text="Tus amigos con boda en eWeddings" CssClass=fbgreybox></asp:Label>
                <br /><br /><br /><br />
            </td>
        </tr>
        <tr>
            <td align =center>
                <table width = 50%>
                    <tr>
                        <td align = center>
                            <asp:GridView ID="gvAmigosConBoda" runat="server" AutoGenerateColumns="False" CellPadding="4"
                            DataKeyNames="uid" AllowPaging="True" AllowSorting="True"
                            Width="100%" BorderColor="White" BorderWidth="1px" 
                            ShowFooter="True" onrowcommand="gvAmigosConBoda_RowCommand" PageSize="50" CssClass="tit_verde" >
                            <FooterStyle Font-Bold="True" ForeColor="White" CssClass="tit_verde" />
                            <Columns>
                                <asp:TemplateField HeaderText="Foto">
                                    <ItemTemplate>
                                        <asp:Image ID="imgSmall" runat="server" ImageUrl='<%# Eval("pic_big") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Nombre">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lblNombre" runat= "server" ToolTip="Ver Regalos Disponibles" Text='<%# Eval("name") %>' CommandName="VerRegalos" CommandArgument='<%# Eval("uid") %>' CssClass="tit_verde"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <EditRowStyle BackColor="#2461BF" />
                            <SelectedRowStyle Font-Bold="True" ForeColor="#333333"/>
                            <PagerStyle ForeColor="White" HorizontalAlign="Center" />
                            <PagerSettings Mode="NextPrevious" NextPageImageUrl="~/Imag/flecha_der.gif" PreviousPageImageUrl="~/Imag/flecha_izq.gif" FirstPageText="Primera" LastPageText="Ultima" NextPageText="Siguiente" PreviousPageText="Anterior" />
                            <EmptyDataTemplate>
                                <table cellspacing="0" cellpadding="0" border="0" style="width: 100%">
                                    <tr>
                                        <td align="center">
                                            <asp:Label ID="lblNoRecordsFound" runat="server" Text="No tienes amigos con boda."
                                                ToolTip="No tienes ningún amigo de facebook con boda que esté asociado en eWeddings" ForeColor="red"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </EmptyDataTemplate>
                            
                        </asp:GridView>
                        </td>
                    </tr>
                </table>
                
            </td>
        </tr>
    </table>
    
    
    
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="Menu">
    <asp:LinkButton ID="lbAsociarCuenta" runat="server" 
        onclick="lbAsociarCuenta_Click" CssClass="fbtab" Width="183px">Asociar mi cuenta de eWeddings</asp:LinkButton>
</asp:Content>

<asp:Content ID="Content3" runat="server" contentplaceholderid="header">
    <style type="text/css">
        .style3
        {
            color: #FFFFFF;
        }
    </style>
</asp:Content>


