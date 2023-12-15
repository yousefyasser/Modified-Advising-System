<%@ Page Title="GUC Advising System - Required Courses in current semester" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Required_Courses.aspx.cs" Inherits="Advising_Team.Student.Courses.Required_Courses" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <h4>GUC Advising System - Required Courses in the current semester</h4>
    
    <br />
    <div class="table-responsive">
        <asp:Table ID="RequiredCourses" CssClass="table table-striped" runat="server">
            <asp:TableHeaderRow CssClass="thead-dark">
                <asp:TableHeaderCell>Course Id</asp:TableHeaderCell>
                <asp:TableHeaderCell>Course Name</asp:TableHeaderCell>
            </asp:TableHeaderRow>
        </asp:Table>
    </div>
    <br />
</asp:Content>
