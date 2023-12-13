<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Student_Registration.aspx.cs" Inherits="Advising_Team.Student_Registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>GUC Advising System - Student Registration</title>
    <link href="/Css/mainStyle.css" rel="stylesheet"/>
    <link href="/Css/bootstrap/bootstrap.min.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form2" runat="server">
        <div>
            <h3>GUC Advising System - Student Registration</h3>

            <input id="f_name" runat="server" placeholder="First Name" required/>
            <br />

            <input id="l_name" runat="server" placeholder="Last Name" required/>
            <br />

            <input id="password" type="password" runat="server" placeholder="Password" required/>
            <br />

            <input id="faculty" runat="server" placeholder="Faculty" required/>
            <br />

            <input id="email" runat="server" placeholder="Email" required/>
            <br />

            <input id="major" runat="server" placeholder="Major" required/>
            <br />

            <input id="semester" runat="server" placeholder="Semester" required/>

            <br />
            <br />
            <asp:Button ID="Registration" runat="server" Text="Register" class="btn btn-outline-primary" OnClick="register" />
            <br />
            <br />
            Already have an account?
            <asp:HyperLink ID="login" CssClass="nav-link" style="color:royalblue" href="Student_Login.aspx" runat="server">login</asp:HyperLink>
            <br />
            <br />
            <asp:Label ID="successMessage" CssClass="alert-success" style="padding: 10px; border-radius:5px;" runat="server" Visible="false"></asp:Label>
            <asp:Label ID="errorMessage" CssClass="alert-danger" style="padding: 10px; border-radius: 5px;" runat="server" Visible="false"></asp:Label>
        </div>
    </form>
</body>
</html>
