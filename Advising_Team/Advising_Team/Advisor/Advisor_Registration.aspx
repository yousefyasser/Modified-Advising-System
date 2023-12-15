<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Advisor_Registration.aspx.cs" Inherits="Advising_Team.Advisor_Registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>GUC Advising System - Advisor Registration</title>
    <link rel="stylesheet" type="text/css" href="../Css/mainStyle.css" />
    <link href="/Css/bootstrap/bootstrap.min.css" rel="stylesheet" type="text/css" />

    <script>
        function changeImageOnHover(isHover) {
            var image = document.getElementById('<%= img.ClientID %>');
            if (isHover) {
                image.src = '<%= ResolveUrl("~/Images/student.jpeg") %>';
            } else {
                image.src = '<%= ResolveUrl("~/Images/student-blackandwhite.jpeg") %>';
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>GUC Advising System - Advisor Registration</h2>

            <asp:TextBox ID="name" runat="server" placeholder="Name"></asp:TextBox>
            <br />

            <asp:TextBox ID="password" runat="server" TextMode="Password" placeholder="Password"></asp:TextBox>
            <br />

            <asp:TextBox ID="email" runat="server" placeholder="Email"></asp:TextBox>
            <br />

            <asp:TextBox ID="office" runat="server" placeholder="Office"></asp:TextBox>
            <br />

            <br />
            <asp:Button ID="Registration" runat="server" Text="Register" class="btn btn-outline-primary" OnClick="register" />
            <br />
            <br />
            Already have an account?
            <asp:HyperLink ID="login" CssClass="nav-link" style="color:royalblue" href="Advisor_Login.aspx" runat="server">login</asp:HyperLink>
            <br />
            <asp:ImageButton ID="img" runat="server" ImageUrl="~/Images/student-blackandwhite.jpeg" CssClass="img" PostBackUrl="~/Student/Student_Registration.aspx" OnMouseOver="changeImageOnHover(true);" OnMouseOut="changeImageOnHover(false);" Height="117px" Width="184px" />

            <br />
            <asp:Label ID="successMessage" CssClass="alert-success" style="padding: 10px; border-radius:5px;" runat="server" Visible="false"></asp:Label>
            <asp:Label ID="errorMessage" CssClass="alert-danger" style="padding: 10px; border-radius: 5px;" runat="server" Visible="false"></asp:Label>
        </div>
    </form>
        </body>
</html>
