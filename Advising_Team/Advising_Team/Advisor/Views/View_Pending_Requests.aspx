<%@ Page Title="GUC Advising System - View Pending Requests" Language="C#" MasterPageFile="Site1.Master" AutoEventWireup="true" CodeBehind="View_Pending_Requests.aspx.cs" Inherits="Advising_Team.Advisor.Views.View_Pending_Requests" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <div class="custom-table-container">
        <h4>GUC Advising System - View Pending Requests</h4>
        <div class="table-responsive">
            <asp:Table ID="viewPendingRequests" CssClass="table table-striped" runat="server">
                <asp:TableHeaderRow CssClass="thead-dark">
                    <asp:TableHeaderCell>Request ID</asp:TableHeaderCell>
                    <asp:TableHeaderCell>Type</asp:TableHeaderCell>
                    <asp:TableHeaderCell>Comment</asp:TableHeaderCell>
                    <asp:TableHeaderCell>Status</asp:TableHeaderCell>
                    <asp:TableHeaderCell>Credit Hours</asp:TableHeaderCell>
                    <asp:TableHeaderCell>Course ID</asp:TableHeaderCell>
                    <asp:TableHeaderCell>Student ID</asp:TableHeaderCell>
                    <asp:TableHeaderCell>Advisor ID</asp:TableHeaderCell>
                </asp:TableHeaderRow>
            </asp:Table>
        </div>
        <br />
    </div>
        <asp:HyperLink ID="back9" href="View_Options.aspx" runat="server">Go Back</asp:HyperLink>
        <br />
</asp:Content>
