<%@ Page Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="FQL.aspx.cs" Inherits="FQL" Title="Untitled Page" %>
<%@ MasterType VirtualPath="~/Site.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="header" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">
    <div class="fbinfobox">
    Illustrates using FQL with a sample query provided below. Also as a convience the uid's of all your
    friends are listed so you can query on them.
    </div>
    <h2>Your UserID is: <%=Master.API.uid %></h2>
    <table>
        <tr>
            <td>
                <h3>Your friends UserID's</h3>
                <asp:ListBox ID="ListBox1" runat="server" Rows="10"></asp:ListBox>
            </td>
            <td valign="top">
                <asp:TextBox ID="TextBox1" runat="server" Rows="8" Width="355px" 
                    TextMode="MultiLine"></asp:TextBox>
                <asp:Button ID="ExecFQLBtn" runat="server" OnClick="ExecFQLBtn_Click" Text="Execute FQL" />
                <asp:CheckBox ID="UseJson" runat="server" Text="Use JSON" />
            </td>
        </tr>
    </table>
    <div style="font-family: Courier">
        <asp:Literal ID="qresult" runat="server"></asp:Literal>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" Runat="Server">
</asp:Content>

