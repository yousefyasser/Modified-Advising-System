<%@ Page Title="GUC Advising System - Missing Courses" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Missing_Courses.aspx.cs" Inherits="Advising_Team.Student.Missing_Courses" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <h4>GUC Advising System - Missing Courses</h4>
    
    <br />
    <div class="table-responsive">
        <asp:Table ID="missingCourses" CssClass="table table-striped" runat="server">
            <asp:TableHeaderRow CssClass="thead-dark">
                <asp:TableHeaderCell>Course Id</asp:TableHeaderCell>
                <asp:TableHeaderCell>Course Name</asp:TableHeaderCell>
            </asp:TableHeaderRow>
        </asp:Table>
    </div>
    <br />
</asp:Content>
