<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Insert_GradPlan.aspx.cs" Inherits="Advising_Team.Advisor.GradPlan.Insert_GradPlan" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Insert Graduation Plan</title>
    <link href="~/Css/mainStyle.css" rel="stylesheet" />
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"/>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>

<body>
    <form id="form1" runat="server">
        <div>
            <h2>Insert Graduation Plan</h2>

            <asp:TextBox ID="txtSemesterCode" runat="server" CssClass="form-control" placeholder="Enter Semester Code"></asp:TextBox>
            <br />

            <asp:Label ID="lblExpectedGradDate" runat="server" Text="Expected Graduation Date:"></asp:Label>
            <asp:TextBox ID="txtExpectedGradDate" runat="server" CssClass="form-control" type="date"></asp:TextBox>
            <br />

            <asp:TextBox ID="txtSemCreditHours" runat="server" CssClass="form-control" placeholder="Enter Semester Credit Hours"></asp:TextBox>
            <br />

            <asp:TextBox ID="txtAdvisorId" runat="server" CssClass="form-control" placeholder="Enter Advisor ID"></asp:TextBox>
            <br />

            <asp:TextBox ID="txtStudentId" runat="server" CssClass="form-control" placeholder="Enter Student ID"></asp:TextBox>
            <br />

            <asp:Button ID="btnInsert" runat="server" Text="Insert" CssClass="option-btn" OnClick="btnInsert_Click" />
            <asp:HyperLink ID="back2" href="../All_Options.aspx" runat="server">Go Back</asp:HyperLink>
            <br />
            <asp:Label ID="successMessage" runat="server" Visible="false"></asp:Label>
            <asp:Label ID="errorMessage" runat="server" Visible="false"></asp:Label>
        </div>
    </form>
</body>
</html>
