<%@ Page Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="XFBML.aspx.cs" Inherits="XFBML" Title="Untitled Page" %>
<%@ MasterType VirtualPath="~/Site.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="header" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">
  <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="/default.aspx" Target="_top">Home Page</asp:HyperLink><br />
  <fb:name firstnameonly="true" linked="false" useyou="false" uid="<%=Master.API.uid%>"></fb:name><br />
  <fb:profile-pic uid="<%=Master.API.uid%>"></fb:profile-pic>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" Runat="Server">
  <script type="text/javascript">FB_RequireFeatures(["XFBML"], function(){ FB.Facebook.init('<%=ConfigurationSettings.AppSettings["APIKey"] %>', "xd_receiver.htm"); });</script>
</asp:Content>
