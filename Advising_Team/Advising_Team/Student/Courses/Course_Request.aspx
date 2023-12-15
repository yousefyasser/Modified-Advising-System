<%@ Page Title="GUC Advising System - Course Request" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Course_Request.aspx.cs" Inherits="Advising_Team.Student.Courses.Course_Request" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <h4>GUC Advising System - Course Request</h4>

    <br />
    <input id="courseID" runat="server" placeholder="Course ID" required/>
    <br />
    <input id="comment" runat="server" placeholder="Comment"/>

    <br />
    <br />
    <asp:Button ID="submit" CssClass="btn btn-outline-primary" runat="server" OnClick="SendCourseRequest" Text="Submit" />
    <br />
    <br />
    <asp:Label ID="successMessage" CssClass="alert-success" style="padding:10px; border-radius:5px;" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="errorMessage" CssClass="alert-danger" style="padding:10px; border-radius:5px;" runat="server" Visible="false"></asp:Label>
</asp:Content>
            



