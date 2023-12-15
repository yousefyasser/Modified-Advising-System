<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Student_Login.aspx.cs" Inherits="Advising_Team.Student_Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>GUC Advising System - Student Login</title>
    <link href="/Css/mainStyle.css" rel="stylesheet"/>
    <link href="/Css/bootstrap/bootstrap.min.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h3>GUC Advising System - Student Login</h3>
        
            <input id="id" runat="server" placeholder="ID" required/>

            <br />
            <input id="pass" type="password" runat="server" placeholder="Password" required/>
            
            <br />
            <br />

            <asp:Button ID="login" runat="server" Text="Login" class="btn btn-outline-primary" OnClick="student_login" />
            
            <br />
            <br />

            Don&#39;t have an account? 
            <asp:HyperLink ID="register" CssClass="nav-link" style="color:royalblue" href="Student_Registration.aspx" runat="server">Register</asp:HyperLink>
            <br />
            <br />

            <asp:Label ID="successMessage" CssClass="alert-success" style="padding: 10px; border-radius:5px;" runat="server" Visible="false"></asp:Label>
            <asp:Label ID="errorMessage" CssClass="alert-danger" style="padding: 10px; border-radius: 5px;" runat="server" Visible="false"></asp:Label>
        </div>
    </form>
</body>
</html>
