<%@ Page Title="GUC Advising System -  Choose Instructor for Course" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Instructor_Course.aspx.cs" Inherits="Advising_Team.Student.Instructor_Course" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <h2>GUC Advising System -  Choose Instructor for Course </h2>
     Course ID
    <asp:TextBox ID="c_id" runat="server"></asp:TextBox>
    <br />
     Instructor ID 
    <asp:TextBox ID="i_id" runat="server"></asp:TextBox>
    <br />
    <asp:Button ID="choose" runat="server" Text="Choose" OnClick="chooseInstructor" />
     <br />
    <asp:Label ID="successMessage" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="errorMessage" runat="server" Visible="false"></asp:Label>
     

</asp:Content>
