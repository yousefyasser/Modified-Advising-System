<%@ Page Title="GUC Advising System - Optional Courses in current semester" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Optional_Courses.aspx.cs" Inherits="Advising_Team.Student.Courses.Optional_Courses" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <h4>GUC Advising System - Optional Courses in the current semester</h4>
    
    <br />
    <div class="table-responsive">
        <asp:Table ID="optionalCourses" CssClass="table table-striped" runat="server">
            <asp:TableHeaderRow CssClass="thead-dark">
                <asp:TableHeaderCell>Course Id</asp:TableHeaderCell>
                <asp:TableHeaderCell>Course Name</asp:TableHeaderCell>
            </asp:TableHeaderRow>
        </asp:Table>
    </div>
    <br />
</asp:Content>
