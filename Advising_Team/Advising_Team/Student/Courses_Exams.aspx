<%@ Page Title="GUC Advising System - Courses with Exams" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Courses_Exams.aspx.cs" Inherits="Advising_Team.Student.Courses_Exams" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <h2>GUC Advising System -  Courses with Exams </h2>

    <asp:Table ID="courseExam" CssClass="table" runat="server">
        <asp:TableHeaderRow>
            <asp:TableCell> Course ID </asp:TableCell>
            <asp:TableCell> Course Name </asp:TableCell>            
            <asp:TableCell> Semester</asp:TableCell>
            <asp:TableCell> Exam Date </asp:TableCell>
            <asp:TableCell> Exam Type </asp:TableCell>
        </asp:TableHeaderRow>
    </asp:Table>
    <br />
</asp:Content>