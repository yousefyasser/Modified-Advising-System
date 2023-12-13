<%@ Page Title="GUC Advising System - Courses Slots" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Slot_Course.aspx.cs" Inherits="Advising_Team.Student.Slot_Course" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <h4>GUC Advising System -  Slots of Course </h4>

    <br />
    <asp:TextBox ID="c_id" runat="server" placeholder="Course ID"></asp:TextBox>
    <br />

    <asp:TextBox ID="i_id" runat="server" placeholder="Instructor ID"></asp:TextBox>
    <br />
    <br />
     <asp:Button ID="Searching" runat="server" Text="Search" class="btn btn-outline-primary" OnClick="viewSlot" />
    <br />
    <br />
    <asp:Table ID="slotCourse" CssClass="table table-striped" runat="server">
        <asp:TableHeaderRow CssClass="thead-dark">
            <asp:TableCell> Course ID </asp:TableCell>
            <asp:TableCell> Course Name </asp:TableCell>  
            <asp:TableCell> Slot ID </asp:TableCell>
            <asp:TableCell> Slot Day </asp:TableCell>
            <asp:TableCell> Slot Time </asp:TableCell>
            <asp:TableCell> Slot Location </asp:TableCell>
            <asp:TableCell> Instructor ID</asp:TableCell>
            <asp:TableCell> Instructor Name </asp:TableCell>
        </asp:TableHeaderRow>
    </asp:Table>
    <br />
    <br />
    <asp:Label ID="successMessage" CssClass="alert-success" style="padding: 10px; border-radius:5px;" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="errorMessage" CssClass="alert-danger" style="padding: 10px; border-radius: 5px;" runat="server" Visible="false"></asp:Label>
 
</asp:Content>