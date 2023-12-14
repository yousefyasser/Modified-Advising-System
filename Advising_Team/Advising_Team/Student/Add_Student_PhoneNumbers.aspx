<%@ Page Title="GUC Advising System - Add Phone Number(s)" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Add_Student_PhoneNumbers.aspx.cs" Inherits="Advising_Team.Student.Add_Student_PhoneNumbers" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">

    <h4>GUC Advising System - Add Phone Number(s)</h4><br />
    <input id="phones" runat="server" placeholder="Phone Number" required/>
    <br />
    <br />
    <asp:Button ID="add" CssClass="btn btn-outline-primary" runat="server" OnClick="add_phone" Text="Add" />
    <br />
    <br />
    <asp:Label ID="successMessage" CssClass="alert-success" style="padding:10px; border-radius:5px;" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="errorMessage" CssClass="alert-danger" style="padding:10px; border-radius:5px;" runat="server" Visible="false"></asp:Label>
</asp:Content>