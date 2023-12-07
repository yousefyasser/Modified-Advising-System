<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Student_Login.aspx.cs" Inherits="Advising_Team.Student_Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>University Advising System - Student Login</title>
    <link rel="stylesheet" type="text/css" href="../Css/mainStyle.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>University Advising System - Student Login</h2>
            Id <asp:TextBox ID="id" runat="server"></asp:TextBox>
            <br />
            Password
            <asp:TextBox ID="password" runat="server" TextMode="Password"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="login" runat="server" Text="Login" OnClick="student_login" />
            <br />
            <br />
            Don&#39;t have an account? 
            <asp:HyperLink ID="register" href="Student_Registration.aspx" runat="server">Register</asp:HyperLink>
            <br />
            <br />
            <asp:Label ID="successMessage" runat="server" CssClass="success-message" Visible="false"></asp:Label>
            <asp:Label ID="errorMessage" runat="server" CssClass="error-message" Visible="false"></asp:Label>
        </div>
    </form>
</body>
</html>
