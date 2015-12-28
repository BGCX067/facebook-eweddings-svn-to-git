<%@ Page Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ConfirmacionCompra.aspx.cs" Debug="true" Inherits="ConfirmacionCompra" %>

<%@ Register Assembly="facebook.web" Namespace="facebook.web" TagPrefix="cc1" %>
<%@ MasterType VirtualPath="~/Site.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" runat="Server">
        
    <table cellspacing="0" cellpadding="0" border="0" width="100%">
        <tr>
            <td align=center>
                <br />
                <asp:Label ID="lblTitle" runat="server" Text="Confirmación de los regalos para " CssClass=fbgreybox></asp:Label>
                <br /><br />
                
                <table>
                    <tr>
                        <td align =center>
                            <asp:LinkButton ID="lbVolver" runat="server" CssClass="fbtab" PostBackUrl="~/Regalos.aspx">Volver a Regalos</asp:LinkButton>
                        </td>
                    </tr>
                </table>
                
                <br /><br /><br />
                
                <asp:GridView ID="gvRegalosDisponibles" runat="server" AutoGenerateColumns="False" CellPadding="4"
                DataKeyNames="IdProdSer" AllowPaging="True" AllowSorting="True"
                Width="100%" BorderColor="White" BorderWidth="1px" OnRowDataBound="gvRegalosDisponibles_RowDataBound" 
                ShowFooter="True" onrowcommand="gvRegalosDisponibles_RowCommand" PageSize="50"  CssClass="tit_verde">
                <FooterStyle Font-Bold="True" ForeColor="White" />
                <Columns>
                    <asp:TemplateField HeaderText="Fotos">
                        <ItemTemplate>
                            <asp:Image ID="ImagenProducto" runat="server"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Descripcion">
                        <ItemTemplate>
                            <asp:Label ID="lbDescripcion" runat="server" Text='<%# Eval("Descripcion") %>'  CssClass="tit_verde"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Precio">
                        <ItemTemplate>
                            <asp:Label ID="lbPrecio" runat="server" Text='<%# Eval("Precio") %>'  CssClass="tit_verde"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Opciones">
                        <ItemTemplate>
                            <asp:LinkButton ID="lbBorrar" runat="server" ToolTip="Cancelar Regalo"  CommandName="Borrar" CommandArgument='<%# Eval("Id") %>'><asp:Image ID="imgBorrar" runat="server" ImageUrl="~/Imag/grid_Delete.ico"/></asp:LinkButton>
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
                                <asp:Label ID="lblNoRecordsFound" runat="server" Text="No realizaste ninguna selección de regalos para tu amigo"
                                    ToolTip="Todavía no has hecho ninguna selección de regalos" ForeColor="red"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </EmptyDataTemplate>
                
            </asp:GridView>
            
            <br /><br /><br />
        
            <table width=75%>
                <tr>
                    <td align =center class=fbgreybox>
                        <asp:Label ID="lblTotal" runat="server" Text="Total de la compra"></asp:Label>
                    </td>
                    <td align =center class=fbgreybox>
                        <asp:Label ID="lblValorTotal" runat="server" Text="$ 0,00"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan = 2 align = right>
                        <asp:Button ID="btnConfirmar" runat="server" Text="Confirmar Compra" 
                            onclick="btnConfirmar_Click"/>
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


