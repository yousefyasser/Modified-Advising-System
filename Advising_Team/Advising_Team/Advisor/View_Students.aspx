<%@ Page Title="GUC Advising System - View All My Students" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="View_Students.aspx.cs" Inherits="Advising_Team.Advisor.View_Students" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <div class="custom-table-container">
        <h4>GUC Advising System - View All My Students</h4>
        <div class="table-responsive">
            <asp:Table ID="viewStudents" CssClass="table table-striped" runat="server">
                <asp:TableHeaderRow CssClass="thead-dark">
                    <asp:TableHeaderCell>Student Name</asp:TableHeaderCell>
                    <asp:TableHeaderCell>Student Id</asp:TableHeaderCell>
                </asp:TableHeaderRow>
            </asp:Table>
        </div>
        <br />
    </div>
    <asp:HyperLink ID="back7" href="View_Options.aspx" runat="server">Go Back</asp:HyperLink>
      <br />
</asp:Content>