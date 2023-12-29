<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Admin2/AdminNav.Master" CodeBehind="AdminAddExam.aspx.cs" Inherits="Advising_Team.Admin2.AdminAddExam" %>


<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <h4>GUC Advising System - Add makeup exam</h4>
    <br />
    <br />

    <asp:Label runat="server" Text="Choose exam type"></asp:Label>

    <asp:DropDownList ID="examType" runat="server"></asp:DropDownList>
    <br />
    <br />

    <input id="examDatetime" runat="server" placeholder="Enter exam datetime" required/>
    <br />

    <input id="courseID" runat="server" placeholder="Enter exam course ID" required/>
    <br />
    <br />

    <asp:Button runat="server" CssClass="btn btn-outline-primary" OnClick="AddExam" Text="Enter"></asp:Button>
    <br />
    <br />

    <asp:Label ID="msg" CssClass="alert-danger" style="padding:10px; border-radius:5px; margin:10px" runat="server" Visible="false"></asp:Label>
</asp:Content>
