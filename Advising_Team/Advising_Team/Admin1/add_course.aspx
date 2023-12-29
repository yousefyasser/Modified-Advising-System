<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Admin2/AdminNav.Master" CodeBehind="add_course.aspx.cs" Inherits="Advising_Team.Admin1.add_course" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <h4>GUC Advising System - Add Course</h4>
    <br />
    <br />

    <input id="t1" runat="server" placeholder="Enter major" required/>
    <br />
    <input id="t2" runat="server" placeholder="Enter semester" required/>
    <br />
    <input id="t3" runat="server" placeholder="Enter credit hours" required/>
    <br />
    <input id="t4" runat="server" placeholder="Enter name" required/>
    <br />
    <input id="t5" runat="server" placeholder="Enter isOffered" required/>
    <br />

    <br />
    <br />

    <asp:Button runat="server" ID="add" CssClass="btn btn-outline-primary" OnClick="Button1_Click" Text="Add"></asp:Button>
    <br />
    <br />

    <asp:Label ID="msg" CssClass="alert-danger" style="padding:10px; border-radius:5px; margin:10px" runat="server" Visible="false"></asp:Label>
</asp:Content>

