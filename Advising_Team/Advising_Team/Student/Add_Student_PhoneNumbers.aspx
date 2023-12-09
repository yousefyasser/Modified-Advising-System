<%@ Page Title="GUC Advising System - Add Phone Number(s)" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Add_Student_PhoneNumbers.aspx.cs" Inherits="Advising_Team.Student.Add_Student_PhoneNumbers" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">

    <h2>GUC Advising System - Add Phone Number(s)</h2><br />
    Phone Number<asp:TextBox ID="phones" runat="server"></asp:TextBox>
    <br />
    <br />
    <asp:Button ID="add" runat="server" OnClick="add_phone" Text="Add" />
    <br />
    <br />
    <asp:Label ID="successMessage" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="errorMessage" runat="server" Visible="false"></asp:Label>
</asp:Content>