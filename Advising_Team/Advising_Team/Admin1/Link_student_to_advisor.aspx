<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Admin2/AdminNav.Master" CodeBehind="Link_student_to_advisor.aspx.cs" Inherits="Advising_Team.Admin1.Link_student_to_advisor" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <h4>GUC Advising System - Link student to advisor</h4>
    <br />
    <br />

    <input id="t1" runat="server" placeholder="Enter student ID" required/>
    <br />
    <input id="t2" runat="server" placeholder="Enter advisor ID" required/>
    <br />
    <br />

    <asp:Button runat="server" ID="add" CssClass="btn btn-outline-primary" OnClick="Button1_Click" Text="Save"></asp:Button>
    <br />
    <br />

    <asp:Label ID="msg" CssClass="alert-danger" style="padding:10px; border-radius:5px; margin:10px" runat="server" Visible="false"></asp:Label>
</asp:Content>


