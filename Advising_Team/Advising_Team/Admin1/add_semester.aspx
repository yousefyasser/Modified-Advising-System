<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Admin2/AdminNav.Master" CodeBehind="add_semester.aspx.cs" Inherits="Advising_Team.Admin1.add_semester" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <h4>GUC Advising System - Add Semester</h4>
    <br />
    <br />

    <input id="t1" runat="server" placeholder="Enter semester code" required/>
    <br />
    <input id="t2" runat="server" placeholder="Enter start date" required/>
    <br />
    <input id="t3" runat="server" placeholder="Enter end date" required/>
    <br />
    <br />

    <asp:Button runat="server" ID="Button1" CssClass="btn btn-outline-primary" OnClick="Button1_Click" Text="Add"></asp:Button>
    <br />
    <br />

    <asp:Label ID="msg" CssClass="alert-danger" style="padding:10px; border-radius:5px; margin:10px" runat="server" Visible="false"></asp:Label>
</asp:Content>


