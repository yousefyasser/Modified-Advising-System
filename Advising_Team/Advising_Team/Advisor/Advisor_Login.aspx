<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Advisor_Login.aspx.cs" Inherits="Advising_Team.Advisor.Advisor_Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>GUC Advising System - Advisor Login</title>
    <link rel="stylesheet" type="text/css" href="../Css/mainStyle.css" />
    <link href="/Css/bootstrap/bootstrap.min.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>GUC Advising System - Advisor Login</h2>
            <asp:TextBox ID="id" runat="server" placeholder="ID"></asp:TextBox>
            <br />
            <asp:TextBox ID="password" runat="server" TextMode="Password" placeholder="Password"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="login" runat="server" class="btn btn-outline-primary" Text="Login" OnClick="advisor_login" />
            <br />
            <br />
            Don't have an account? 
            <asp:HyperLink ID="register"  CssClass="nav-link" style="color:royalblue" href="Advisor_Registration.aspx" runat="server">Register</asp:HyperLink>
            <br />
            <br />
            <asp:Label ID="successMessage" CssClass="alert-success" style="padding: 10px; border-radius:5px;" runat="server" Visible="false"></asp:Label>
<asp:Label ID="errorMessage" CssClass="alert-danger" style="padding: 10px; border-radius: 5px;" runat="server" Visible="false"></asp:Label>
        </div>
    </form>
</body>
</html>
