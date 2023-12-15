<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Add_GradPlan_Course.aspx.cs" Inherits="Advising_Team.Advisor.GradPlan.Add_GradPlan_Course" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add Course to Graduation Plan</title>
    <link href="~/Css/mainStyle.css" rel="stylesheet" />
    <link href="~/Css/bootstrap/bootstrap.min.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>Add Course to Graduation Plan</h2>

            <asp:TextBox ID="txtStudentId" runat="server" CssClass="form-control" placeholder="Enter Student ID"></asp:TextBox>
            <br />

            <asp:TextBox ID="txtSemesterCode" runat="server" CssClass="form-control" placeholder="Enter Semester Code"></asp:TextBox>
            <br />

            <asp:TextBox ID="txtCourseName" runat="server" CssClass="form-control" placeholder="Enter Course Name"></asp:TextBox>
            <br />

            <asp:Button ID="btnAddCourse" runat="server" Text="Add Course" CssClass="option-btn" OnClick="btnAddCourse_Click" />
            <asp:HyperLink ID="back3" href="../All_Options.aspx" runat="server">Go Back</asp:HyperLink>
            <br />

            <asp:Label ID="successMessage" runat="server" Visible="false"></asp:Label>
            <asp:Label ID="errorMessage" runat="server" Visible="false"></asp:Label>
        </div>
    </form>
</body>
</html>
