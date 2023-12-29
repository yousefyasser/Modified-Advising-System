<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="AdminNav.Master" CodeBehind="AdminDeleteCourse.aspx.cs" Inherits="Advising_Team.Admin2.AdminDeleteCourse" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <h4>GUC Advising System - Remove course</h4>
    <br />
    <br />

    <input id="course_id" runat="server" placeholder="Enter course ID" required/>
    <br />
    <br />

    <asp:Button runat="server" CssClass="btn btn-outline-primary" OnClick="RemoveCourse" Text="Enter"></asp:Button>
    <br />
    <br />

    <asp:Label ID="msg" CssClass="alert-danger" style="padding:10px; border-radius:5px; margin:10px" runat="server" Visible="false"></asp:Label>
</asp:Content>

