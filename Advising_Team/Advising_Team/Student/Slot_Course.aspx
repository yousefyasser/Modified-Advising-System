<%@ Page Title="GUC Advising System - Courses Slots" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Slot_Course.aspx.cs" Inherits="Advising_Team.Student.Slot_Course" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <h2>GUC Advising System -  Slots of Course </h2>
     Course ID
    <asp:TextBox ID="c_id" runat="server"></asp:TextBox>
    <br />

    Instructor ID
    <asp:TextBox ID="i_id" runat="server"></asp:TextBox>
    <br />
     <asp:Button ID="Searching" runat="server" Text="Search" OnClick="viewSlot" />
    <br />
    <asp:Table ID="slotCourse" CssClass="table" runat="server">
        <asp:TableHeaderRow>
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
    <asp:Label ID="successMessage" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="errorMessage" runat="server" Visible="false"></asp:Label>
 
</asp:Content>