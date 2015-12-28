<%@ Page Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Debug="true" Inherits="FacebookApp._Default" Title="Untitled" %>

<%@ Register Assembly="facebook.web" Namespace="facebook.web" TagPrefix="cc1" %>
<%@ MasterType VirtualPath="~/Site.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" runat="Server">
    <h1>ASP.NET Starter Kit Application</h1> 
    <div class="fbinfobox">
    Features:
        <ul>
            <li><asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/XFBML.aspx">XFBML</asp:HyperLink> access on an IFrame based canvas page</li>
            <li><asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/FQL.aspx">FQL Page</asp:HyperLink></li>
            <li><asp:HyperLink ID="HyperLink4" runat="server" NavigateUrl="http://wiki.developers.facebook.com/index.php/Resizable_IFrame" Target="_top">Automatic IFrame resizing</asp:HyperLink>. Notice how this IFrame does not have a scrollbar (refer to Site.master for details)</li>
            <li><asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="http://wiki.developers.facebook.com/index.php/Cross_Domain_Communication_Channel" Target="_top">Cross Domain Communication Channel support</asp:HyperLink></li>
            <li>Navigating to application sub-pages using &ltasp:HyperLink ... Target="_top"&gt; attribute</li>
        </ul>        
    </div>
  <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
  <asp:Image ID="Image1" runat="server" />
  <br />
  <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
  </asp:DropDownList>
  <br />
  <asp:Image ID="Image2" runat="server" />
  <cc1:FriendList ID="FriendList1" runat="server" EnableViewState="False" />
</asp:Content>
