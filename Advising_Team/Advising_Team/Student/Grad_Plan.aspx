<%@ Page Title="GUC Advising System - Graduation Plan" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Grad_Plan.aspx.cs" Inherits="Advising_Team.Student.Grad_Plan" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <h2>GUC Advising System - Graduation Plan</h2>

    <asp:Table ID="graduationPlan" CssClass="table" runat="server">
        <asp:TableHeaderRow>
            <asp:TableCell> Student Name </asp:TableCell>
            <asp:TableCell> Current Semester </asp:TableCell>
            <asp:TableCell> Semester Credit Hours </asp:TableCell>
            <asp:TableCell> Expected Grad Date </asp:TableCell>
            <asp:TableCell> Advisor ID </asp:TableCell>
            <asp:TableCell> Course ID </asp:TableCell>
            <asp:TableCell> Course Name </asp:TableCell>
        </asp:TableHeaderRow>
    </asp:Table>
    <br />
</asp:Content>