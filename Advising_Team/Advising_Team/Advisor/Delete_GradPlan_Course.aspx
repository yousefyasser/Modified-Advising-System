<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Delete_GradPlan_Course.aspx.cs" Inherits="Advising_Team.Advisor.Delete_GradPlan_Course" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Delete Graduation Plan Course</title>
    <link href="/Css/mainStyle.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>Delete Graduation Plan Course</h2>


            <asp:TextBox ID="txtStudentID" runat="server" CssClass="form-control" placeholder="Enter Student ID"></asp:TextBox>
            <br />


            <asp:TextBox ID="txtSemesterCode" runat="server" CssClass="form-control" placeholder="Enter Semester Code"></asp:TextBox>
            <br />


            <asp:TextBox ID="txtCourseID" runat="server" CssClass="form-control" placeholder="Enter Course ID"></asp:TextBox>
            <br />

            <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="option-btn" OnClick="btnDelete_Click" />
            <asp:HyperLink ID="back4" href="All_Options.aspx" runat="server">Go Back</asp:HyperLink>
            <br />

            <asp:Label ID="successMessage" runat="server" Visible="false"></asp:Label>
            <asp:Label ID="errorMessage" runat="server" Visible="false"></asp:Label>
        </div>
    </form>
</body>
</html>
