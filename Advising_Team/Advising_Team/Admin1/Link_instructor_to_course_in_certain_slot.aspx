<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Admin2/AdminNav.Master" CodeBehind="Link_instructor_to_course_in_certain_slot.aspx.cs" Inherits="Advising_Team.Admin1.Link_instructor_to_course_in_certain_slot" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <h4>GUC Advising System - Link instructor to course in certain slot</h4>
    <br />
    <br />

    <input id="t1" runat="server" placeholder="Enter course ID" required/>
    <br />
    <input id="t2" runat="server" placeholder="Enter instructor ID" required/>
    <br />
    <input id="t3" runat="server" placeholder="Enter Slot ID" required/>
    <br />
    <br />

    <asp:Button runat="server" ID="add" CssClass="btn btn-outline-primary" OnClick="Button1_Click1" Text="Save"></asp:Button>
    <br />
    <br />

    <asp:Label ID="msg" CssClass="alert-danger" style="padding:10px; border-radius:5px; margin:10px" runat="server" Visible="false"></asp:Label>
</asp:Content>

