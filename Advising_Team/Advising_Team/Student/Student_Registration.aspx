<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Student_Registration.aspx.cs" Inherits="Advising_Team.Student_Registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>University Advising System - Student Registration</title>
    <link rel="stylesheet" type="text/css" href="../Css/mainStyle.css" />
</head>
<body>
    <form id="form2" runat="server">
        <div>
            <h2>University Advising System - Student Registration</h2>

            First Name
            <asp:TextBox ID="f_name" runat="server"></asp:TextBox>
            <br />

            Last Name <asp:TextBox ID="l_name" runat="server"></asp:TextBox>
            <br />

            Password <asp:TextBox ID="password" runat="server"></asp:TextBox>
            <br />

            Faculty <asp:TextBox ID="faculty" runat="server"></asp:TextBox>
            <br />

            Email <asp:TextBox ID="email" runat="server"></asp:TextBox>
            <br />

            Major <asp:TextBox ID="major" runat="server"></asp:TextBox>
            <br />

            Semester <asp:TextBox ID="semester" runat="server"></asp:TextBox>

            <br />
            <br />
            <asp:Button ID="Registration" runat="server" Text="Register" OnClick="register" />
            <br />
            <br />
            Already have an account?
            <asp:HyperLink ID="login" href="Student_Login.aspx" runat="server">login</asp:HyperLink>
            <br />
            <br />
            <asp:Label ID="successMessage" runat="server" CssClass="success-message" Visible="false"></asp:Label>
            <asp:Label ID="errorMessage" runat="server" CssClass="error-message" Visible="false"></asp:Label>
        </div>
    </form>
</body>
</html>
