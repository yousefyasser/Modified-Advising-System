<%@ Page Title="GUC Advising System - Courses with Prerequisites" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Course_Prerequisites.aspx.cs" Inherits="Advising_Team.Student.Course_Prerequisites" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <h4>GUC Advising System -  Courses with Prerequisites </h4>
    <br />
    <div class="table-responsive">
        <asp:Table ID="coursePrereq" CssClass="table table-striped" runat="server">
            <asp:TableHeaderRow CssClass="thead-dark">
                <asp:TableCell> Course ID </asp:TableCell>
                <asp:TableCell> Course Name </asp:TableCell>            
                <asp:TableCell> Prereq Course ID</asp:TableCell>
                <asp:TableCell> Prereq Course Name </asp:TableCell>
            </asp:TableHeaderRow>
        </asp:Table>
    </div>
    <br />
</asp:Content>