﻿<%@ Page Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Regalos.aspx.cs" Debug="true" Inherits="Regalos" %>

<%@ Register Assembly="facebook.web" Namespace="facebook.web" TagPrefix="cc1" %>
<%@ MasterType VirtualPath="~/Site.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" runat="Server">
        
    <table cellspacing="0" cellpadding="0" border="0" width="100%">
        <tr>
            <td align=center>
                <br />
                <asp:Label ID="lblTitle" runat="server" Text="Regalos disponibles para tu amigo/a " CssClass=fbgreybox></asp:Label>
                <br /><br />
                <br />
                <asp:Label ID="lblNotifCarrito" runat="server" Text="" CssClass="fbinfobox"></asp:Label>
                <br /><br />
                
                <table>
                    <tr>
                        <td align =center>
                            <asp:LinkButton ID="lbVolver" runat="server" CssClass="fbtab" PostBackUrl="~/PantallaPrincipal.aspx">Volver a Amigos con Boda</asp:LinkButton>
                        </td>
                        <td align =center>
                            <asp:LinkButton ID="lbFinCompra" runat="server" CssClass="fbtab"
                                onclick="lbFinCompra_Click">Ir al carrito de compras</asp:LinkButton>
                        </td>
                    </tr>
                </table>
                
                
                <br /><br /><br /><br />
                
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
                            <asp:LinkButton ID="lbAgregarCarrito" runat="server" ToolTip="Agregar al carrito"  CommandName="Agregar" CommandArgument='<%# Eval("Id") %>'><asp:Image ID="imgContratar" runat="server" ImageUrl="~/Imag/carrito_2.gif"/></asp:LinkButton>
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
                                <asp:Label ID="lblNoRecordsFound" runat="server" Text="Tu amigo no tiene regalos disponibles."
                                    ToolTip="Tu amigo todavía no ha elegido los regalos que quiere." ForeColor="red"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </EmptyDataTemplate>
                
            </asp:GridView>
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


