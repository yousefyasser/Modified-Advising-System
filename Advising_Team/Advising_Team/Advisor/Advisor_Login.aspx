<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Advisor_Login.aspx.cs" Inherits="Advising_Team.Advisor.Advisor_Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>GUC Advising System - Advisor Login</title>
    <link rel="stylesheet" type="text/css" href="../Css/mainStyle.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
                        <h2>GUC Advising System - Advisor Login</h2>
            Id <asp:TextBox ID="id" runat="server"></asp:TextBox>
            <br />
            Password
            <asp:TextBox ID="password" runat="server" TextMode="Password"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="login" runat="server" Text="Login" OnClick="advisor_login" />
            <br />
            <br />
            Don't have an account? 
            <asp:HyperLink ID="register" href="Advisor_Registration.aspx" runat="server">Register</asp:HyperLink>
            <br />
            <br />
            <asp:Label ID="successMessage" runat="server" Visible="false"></asp:Label>
            <asp:Label ID="errorMessage" runat="server" Visible="false"></asp:Label>
        </div>
    </form>
</body>
</html>
