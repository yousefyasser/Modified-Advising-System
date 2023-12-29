<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="AdminNav.Master" CodeBehind="AdminDeleteSlots.aspx.cs" Inherits="Advising_Team.Admin2.AdminDeleteSlot" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <h4>GUC Advising System - Delete slots of unoffered courses</h4>
    <br />
    <br />

    <input id="semester_code" runat="server" placeholder="Enter current semester code" required/>
    <br />
    <br />

    <asp:Button runat="server" CssClass="btn btn-outline-primary" OnClick="RemoveSlots" Text="Enter"></asp:Button>
    <br />
    <br />

    <asp:Label ID="msg" CssClass="alert-danger" style="padding:10px; border-radius:5px; margin:10px" runat="server" Visible="false"></asp:Label>
</asp:Content>


