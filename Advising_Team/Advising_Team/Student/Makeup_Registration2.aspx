<%@ Page Title="GUC Advising System - Second Makeup Registration" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Makeup_Registration2.aspx.cs" Inherits="Advising_Team.Student.Makeup_Registration2" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <h2>GUC Advising System - Second Makeup Registration</h2>
     Course ID
    <asp:TextBox ID="c_id" runat="server"></asp:TextBox>
    <br />
     <asp:Button ID="Registering" runat="server" Text="Register" OnClick="register" />
    <br />
     <asp:Label ID="successMessage" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="errorMessage" runat="server" Visible="false"></asp:Label>
 
</asp:Content>