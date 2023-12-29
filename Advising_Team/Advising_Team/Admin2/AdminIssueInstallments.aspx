<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="AdminNav.Master" CodeBehind="AdminIssueInstallments.aspx.cs" Inherits="Advising_Team.Admin2.AdminIssueInstallments" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <h4>GUC Advising System - Issue Installment</h4>
    <br />
    <br />

    <input id="paymentID" runat="server" placeholder="Enter payment ID" required/>
    <br />
    <br />

    <asp:Button runat="server" CssClass="btn btn-outline-primary" OnClick="IssueInstallments" Text="Enter"></asp:Button>
    <br />
    <br />

    <asp:Label ID="message" CssClass="alert-danger" style="padding:10px; border-radius:5px; margin:10px" runat="server" Visible="false"></asp:Label>
</asp:Content>


