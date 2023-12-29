<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="AdminNav.Master" CodeBehind="AdminUpdateStatus.aspx.cs" Inherits="Advising_Team.Admin2.AdminUpdateStatus" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <h4>GUC Advising System - Update Student Status</h4>
    <br />
    <br />

    <input id="studentID" runat="server" placeholder="Enter Student ID" required/>
    <br />
    <br />

    <asp:Button runat="server" CssClass="btn btn-outline-primary" OnClick="btnUpdateStatus_Click" Text="Enter"></asp:Button>
    <br />
    <br />

    <asp:Label ID="message" CssClass="alert-danger" style="padding:10px; border-radius:5px; margin:10px" runat="server" Visible="false"></asp:Label>
</asp:Content>



