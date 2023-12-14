<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Add_GradPlan_Course.aspx.cs" Inherits="Advising_Team.Advisor.Add_GradPlan_Course" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add Course to Graduation Plan</title>
    <link href="/Css/mainStyle.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>Add Course to Graduation Plan</h2>

            <asp:Label ID="lblStudentId" runat="server" Text="Student ID:" AssociatedControlID="txtStudentId"></asp:Label>
            <asp:TextBox ID="txtStudentId" runat="server" CssClass="form-control" placeholder="Enter Student ID"></asp:TextBox>
            <br />

            <asp:Label ID="lblSemesterCode" runat="server" Text="Semester Code:" AssociatedControlID="txtSemesterCode"></asp:Label>
            <asp:TextBox ID="txtSemesterCode" runat="server" CssClass="form-control" placeholder="Enter Semester Code"></asp:TextBox>
            <br />

            <asp:Label ID="lblCourseName" runat="server" Text="Course Name:" AssociatedControlID="txtCourseName"></asp:Label>
            <asp:TextBox ID="txtCourseName" runat="server" CssClass="form-control" placeholder="Enter Course Name"></asp:TextBox>
            <br />

            <asp:Button ID="btnAddCourse" runat="server" Text="Add Course" CssClass="option-btn" OnClick="btnAddCourse_Click" />
            <asp:HyperLink ID="back3" href="All_Options.aspx" runat="server">Go Back</asp:HyperLink>
            <br />

            <asp:Label ID="successMessage" runat="server" Visible="false"></asp:Label>
            <asp:Label ID="errorMessage" runat="server" Visible="false"></asp:Label>
        </div>
    </form>
</body>
</html>
