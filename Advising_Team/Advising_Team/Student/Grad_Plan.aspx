<%@ Page Title="GUC Advising System - Graduation Plan" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Grad_Plan.aspx.cs" Inherits="Advising_Team.Student.Grad_Plan" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <h4>GUC Advising System - Graduation Plan</h4>
    <br />

    <asp:Table ID="graduationPlan" CssClass="table table-striped" runat="server">
        <asp:TableHeaderRow CssClass="thead-dark">
            <asp:TableCell> Student Name </asp:TableCell>
            <asp:TableCell> Current Semester </asp:TableCell>
            <asp:TableCell> Semester Credit Hours </asp:TableCell>
            <asp:TableCell> Expected Grad Date </asp:TableCell>
            <asp:TableCell> Advisor ID </asp:TableCell>
        </asp:TableHeaderRow>
    </asp:Table>
    <br />
    <br />

     <asp:Table ID="gradCourses" CssClass="table table-striped" runat="server">
         <asp:TableHeaderRow CssClass="thead-dark">
             <asp:TableCell> Course ID </asp:TableCell>
             <asp:TableCell> Course Name </asp:TableCell>
         </asp:TableHeaderRow>
     </asp:Table>
    <br />
</asp:Content>