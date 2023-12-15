<%@ Page Title="GUC Advising System -  Choose Instructor for Course" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Instructor_Course.aspx.cs" Inherits="Advising_Team.Student.Courses.Instructor_Course" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <h4>GUC Advising System -  Choose Instructor for Course </h4>
    <br />

    <asp:TextBox ID="c_id" runat="server" placeholder="Course ID"></asp:TextBox>
    <br />
    <asp:TextBox ID="i_id" runat="server" placeholder="Instructor ID"></asp:TextBox>
    <br />
    <br />
    <asp:Button ID="choose" runat="server" Text="Choose" class="btn btn-outline-primary" OnClick="chooseInstructor" />
    <br />
    <br />
    <asp:Label ID="successMessage" CssClass="alert-success" style="padding: 10px; border-radius:5px;" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="errorMessage" CssClass="alert-danger" style="padding: 10px; border-radius: 5px;" runat="server" Visible="false"></asp:Label>
     
</asp:Content>
