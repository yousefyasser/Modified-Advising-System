<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Advisor_Registration.aspx.cs" Inherits="Advising_Team.Advisor_Registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>GUC Advising System - Advisor Registration</title>
    <link rel="stylesheet" type="text/css" href="../Css/mainStyle.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
                        <h2>GUC Advising System - Advisor Registration</h2>

            Name
            <asp:TextBox ID="name" runat="server"></asp:TextBox>
            <br />

            Password <asp:TextBox ID="password" runat="server"></asp:TextBox>
            <br />

            Email <asp:TextBox ID="email" runat="server"></asp:TextBox>
            <br />

            Office <asp:TextBox ID="office" runat="server"></asp:TextBox>
            <br />

            <br />
            <asp:Button ID="Registration" runat="server" Text="Register" OnClick="register" />
            <br />
            <br />
            Already have an account?
            <asp:HyperLink ID="login" href="Advisor_Login.aspx" runat="server">login</asp:HyperLink>
            <br />
            <br />
            <asp:Label ID="successMessage" runat="server" Visible="false"></asp:Label>
            <asp:Label ID="errorMessage" runat="server" Visible="false"></asp:Label>
        </div>
    </form>
</body>
</html>
