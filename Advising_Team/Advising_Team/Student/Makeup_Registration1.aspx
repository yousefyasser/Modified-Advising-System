<%@ Page Title="GUC Advising System - First_Makeup Registration" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Makeup_Registration1.aspx.cs" Inherits="Advising_Team.Student.Makeup_Registration1" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <h4>GUC Advising System -  First Makeup Registration</h4>
    <br />
    <asp:TextBox ID="c_id" runat="server" placeholder="Course ID"></asp:TextBox>
    <br />
    <br />
     <asp:Button ID="Registering" runat="server" Text="Register" class="btn btn-outline-primary" OnClick="register" />
    <br />
    <br />
    <asp:Label ID="successMessage" CssClass="alert-success" style="padding: 10px; border-radius:5px;" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="errorMessage" CssClass="alert-danger" style="padding: 10px; border-radius: 5px;" runat="server" Visible="false"></asp:Label>
 
</asp:Content>