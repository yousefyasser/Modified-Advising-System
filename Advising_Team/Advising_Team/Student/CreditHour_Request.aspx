<%@ Page Title="GUC Advising System - Credit Hour Request" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CreditHour_Request.aspx.cs" Inherits="Advising_Team.Student.CreditHour_Request" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <h4>GUC Advising System - Credit Hour Request</h4>

    <br />
    <input id="creditHours" runat="server" placeholder="Credit Hours" required/>
    <br />
    <input id="comment" runat="server" placeholder="Comment"/>

    <br />
    <br />
    <asp:Button ID="submit" CssClass="btn btn-outline-primary" runat="server" OnClick="SendCreditHourRequest" Text="Submit" />
    <br />
    <br />
    <asp:Label ID="successMessage" CssClass="alert-success" style="padding:10px; border-radius:5px;" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="errorMessage" CssClass="alert-danger" style="padding:10px; border-radius:5px;" runat="server" Visible="false"></asp:Label>
</asp:Content>
            



