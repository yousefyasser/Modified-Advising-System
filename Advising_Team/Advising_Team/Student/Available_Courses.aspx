<%@ Page Title="GUC Advising System - Available Courses in current semester" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Available_Courses.aspx.cs" Inherits="Advising_Team.Student.Available_Courses" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <h2>GUC Advising System - Available Courses in current semester</h2>

    <asp:Table ID="AvailableCourses" CssClass="table" runat="server">
        <asp:TableHeaderRow>
            <asp:TableCell> Course Id </asp:TableCell>
            <asp:TableCell> Course Name </asp:TableCell>
        </asp:TableHeaderRow>
    </asp:Table>
    <br />
</asp:Content>