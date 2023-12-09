<%@ Page Title="GUC Advising System - Optional Courses in current semester" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Student_Optional_Courses.aspx.cs" Inherits="Advising_Team.Student.Student_Optional_Courses" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <h2>GUC Advising System - Optional Courses in current semester</h2>
    <asp:Table ID="optionalCourses" CssClass="table" runat="server">
        <asp:TableHeaderRow>
            <asp:TableCell> Course Id </asp:TableCell>
            <asp:TableCell> Course Name </asp:TableCell>
        </asp:TableHeaderRow>
    </asp:Table>
    <br />
</asp:Content>
            

