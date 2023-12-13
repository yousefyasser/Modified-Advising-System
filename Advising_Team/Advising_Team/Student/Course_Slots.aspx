<%@ Page Title="GUC Advising System - Courses Slots" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Course_Slots.aspx.cs" Inherits="Advising_Team.Student.Course_Slots" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <h4>GUC Advising System -  Courses with Slots </h4>
    
    <br />
    <asp:Table ID="courseSlots" CssClass="table table-striped" runat="server">
        <asp:TableHeaderRow CssClass="thead-dark">
            <asp:TableCell> Course ID </asp:TableCell>
            <asp:TableCell> Course Name </asp:TableCell>  
            <asp:TableCell> Slot ID </asp:TableCell>
            <asp:TableCell> Slot Day </asp:TableCell>
            <asp:TableCell> Slot Time </asp:TableCell>
            <asp:TableCell> Slot Location </asp:TableCell>
            <asp:TableCell> Instructor ID</asp:TableCell>
            <asp:TableCell> Instructor Name </asp:TableCell>
        </asp:TableHeaderRow>
    </asp:Table>
    <br />
</asp:Content>