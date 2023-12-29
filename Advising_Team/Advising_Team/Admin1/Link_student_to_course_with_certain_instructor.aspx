<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Admin2/AdminNav.Master" CodeBehind="Link_student_to_course_with_certain_instructor.aspx.cs" Inherits="Advising_Team.Admin1.Link_student_to_course_with_certain_instructor" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <h4>GUC Advising System - Link student to course with certain instructor</h4>
    <br />
    <br />

    <input id="t1" runat="server" placeholder="Enter course ID" required/>
    <br />
    <input id="t2" runat="server" placeholder="Enter instructor ID" required/>
    <br />
    <input id="t3" runat="server" placeholder="Enter student ID" required/>
    <br />
    <input id="t4" runat="server" placeholder="Enter semester code" required/>
    <br />
    <br />

    <asp:Button runat="server" ID="add" CssClass="btn btn-outline-primary" OnClick="Button1_Click" Text="Save"></asp:Button>
    <br />
    <br />

    <asp:Label ID="msg" CssClass="alert-danger" style="padding:10px; border-radius:5px; margin:10px" runat="server" Visible="false"></asp:Label>
</asp:Content>



