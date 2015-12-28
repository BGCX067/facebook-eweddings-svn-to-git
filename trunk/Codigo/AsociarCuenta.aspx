<%@ Page Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="AsociarCuenta.aspx.cs" Debug="true" Inherits="AsociarCuenta" %>

<%@ Register Assembly="facebook.web" Namespace="facebook.web" TagPrefix="cc1" %>
<%@ MasterType VirtualPath="~/Site.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" runat="Server">
        
    <table cellspacing="0" cellpadding="0" border="0" width="100%">
        <tr>
            <td align=center>
                <table cellspacing="0" cellpadding="0" border="0" width="70%">
                    <tr>
                        <td colspan=2>&nbsp</td>
                    </tr>
                    <tr>
                        <td align=center>
                            <asp:Label ID="lblNombreUsuario" runat="server" Text="Nombre de Usuario eWeddings"></asp:Label>
                        </td>
                        <td align=left>
                            <asp:TextBox ID="txtUser" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvUser" ControlToValidate="txtUser" runat="server" ErrorMessage="Debe ingresar un nombre de usuario" ValidationGroup="Confirmar"></asp:RequiredFieldValidator>
                        </td>
                        
                    </tr>
                    <tr>
                        <td colspan=2>&nbsp</td>
                    </tr>
                    <tr>
                        <td align=center>
                            <asp:Label ID="lblPass" runat="server" Text="Contraseña eWeddings"></asp:Label>
                        </td>
                        <td align=left>
                            <asp:TextBox ID="txtPass" runat="server" TextMode="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfbPass" ControlToValidate="txtPass" runat="server" ErrorMessage="Debe ingresar una contraseña" ValidationGroup="Confirmar"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td colspan=2>&nbsp</td>
                    </tr>
                    <tr>
                        <td >&nbsp</td>
                        <td  align=center>
                            <asp:Button ID="btnConfirmar" runat="server" Text="Confirmar" CssClass=fbbutton 
                                ValidationGroup="Confirmar" onclick="btnConfirmar_Click"/>&nbsp
                            <asp:Button ID="btnCancelar" runat="server" Text="Cancelar"  CssClass=fbbutton 
                                onclick="btnCancelar_Click"/>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="Menu">
</asp:Content>

<asp:Content ID="Content3" runat="server" contentplaceholderid="header">
    <style type="text/css">
        .style3
        {
            color: #FFFFFF;
        }
        .style4
        {
            width: 184px;
        }
    </style>
</asp:Content>


