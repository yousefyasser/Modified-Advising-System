<%@ Page Title="GUC Advising System - Courses with Exams" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Courses_Exams.aspx.cs" Inherits="Advising_Team.Student.Exams.Courses_Exams" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <h4>GUC Advising System -  Courses with Exams </h4>
    
    <br />
    <asp:Table ID="courseExam" CssClass="table table-striped" runat="server">
        <asp:TableHeaderRow CssClass="thead-dark">
            <asp:TableCell> Course ID </asp:TableCell>
            <asp:TableCell> Course Name </asp:TableCell>            
            <asp:TableCell> Semester</asp:TableCell>
            <asp:TableCell> Exam Date </asp:TableCell>
            <asp:TableCell> Exam Type </asp:TableCell>
        </asp:TableHeaderRow>
    </asp:Table>
    <br />
</asp:Content>