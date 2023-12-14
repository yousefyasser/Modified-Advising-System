<%@ Page Title="View All Requests" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="View_All_Requests.aspx.cs" Inherits="Advising_Team.Advisor.View_All_Requests" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <div class="custom-table-container">
        <h4>GUC Advising System - View All Requests</h4>
        <div class="table-responsive">
            <asp:Table ID="viewRequests" CssClass="table table-striped" runat="server">
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
        <asp:HyperLink ID="view_appRej_Req" href="Approve_Reject_Request.aspx" runat="server">Approve/Reject</asp:HyperLink>
      <br />
      <br />
    <asp:HyperLink ID="back6" href="View_Options.aspx" runat="server">Go Back</asp:HyperLink>
      <br />
</asp:Content>
