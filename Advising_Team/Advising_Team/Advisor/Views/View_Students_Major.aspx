<%@ Page Title="GUC Advising System - View Students by Major" Language="C#" MasterPageFile="Site1.Master" AutoEventWireup="true" CodeBehind="View_Students_Major.aspx.cs" Inherits="Advising_Team.Advisor.Views.View_Students_Major" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <div class="custom-table-container">
        <h4>GUC Advising System - View Students by Major</h4>
        <asp:HyperLink ID="pick_major" href="../Pick_Major.aspx" runat="server">Pick Another Major</asp:HyperLink>
        <div class="table-responsive">
            <asp:Table ID="viewStudentsMajor" CssClass="table table-striped" runat="server">
                <asp:TableHeaderRow CssClass="thead-dark">
                    <asp:TableHeaderCell>Student ID</asp:TableHeaderCell>
                    <asp:TableHeaderCell>Student Name</asp:TableHeaderCell>
                    <asp:TableHeaderCell>Major</asp:TableHeaderCell>
                    <asp:TableHeaderCell>Current Course</asp:TableHeaderCell>
                </asp:TableHeaderRow>
            </asp:Table>
        </div>
        <br />
    </div>
    <br />
    <br />
    <asp:Label ID="successMessage" CssClass="alert-success" style="padding: 10px; border-radius:5px;" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="errorMessage" CssClass="alert-danger" style="padding: 10px; border-radius: 5px;" runat="server" Visible="false"></asp:Label>
    <br />
    <br />
    <asp:HyperLink ID="back8" href="View_Options.aspx" runat="server">Go Back</asp:HyperLink>

      <br />
</asp:Content>
