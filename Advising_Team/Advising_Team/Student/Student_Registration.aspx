<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Student_Registration.aspx.cs" Inherits="Advising_Team.Student_Registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>GUC Advising System - Student Registration</title>
    <link href="/Css/mainStyle.css" rel="stylesheet"/>
    <link href="/Css/bootstrap/bootstrap.min.css" rel="stylesheet" type="text/css" />

    <script>
        function changeImageOnHover(isHover) {
            var image = document.getElementById('<%= img.ClientID %>');
            if (isHover) {
                image.src = '<%= ResolveUrl("~/Assets/advisor.jpeg") %>';
            } else {
                image.src = '<%= ResolveUrl("~/Assets/advisor-blackandwhite.jpeg") %>';
            }
        }
    </script>
</head>
<body>
    <form id="form2" runat="server">
        <div>
            <h3>GUC Advising System - Student Registration</h3>

            <input id="f_name" runat="server" placeholder="First Name" />
            <br />

            <input id="l_name" runat="server" placeholder="Last Name"/>
            <br />

            <input id="password" type="password" runat="server" placeholder="Password"/>
            <br />

            <input id="faculty" runat="server" placeholder="Faculty" />
            <br />

            <input id="email" runat="server" placeholder="Email" />
            <br />

            <input id="major" runat="server" placeholder="Major" />
            <br />

            <input id="semester" runat="server" placeholder="Semester" />

            <br />
            <br />
            <asp:Button ID="Registration" runat="server" Text="Register" class="btn btn-outline-primary" OnClick="register" />
            <br />
            <br />
            Already have an account?
            <asp:HyperLink ID="login" CssClass="nav-link" style="color:royalblue" href="Student_Login.aspx" runat="server">login</asp:HyperLink>
            <br />
            <asp:ImageButton ID="img" runat="server" ImageUrl="~/Assets/advisor-blackandwhite.jpeg" CssClass="img" PostBackUrl="~/Advisor/Advisor_Registration.aspx" OnMouseOver="changeImageOnHover(true);" OnMouseOut="changeImageOnHover(false);" Height="117px" Width="184px" />

            <br />
            <asp:Label ID="successMessage" CssClass="alert-success" style="padding: 10px; border-radius:5px;" runat="server" Visible="false"></asp:Label>
            <asp:Label ID="errorMessage" CssClass="alert-danger" style="padding: 10px; border-radius: 5px;" runat="server" Visible="false"></asp:Label>
        </div>
    </form>
</body>
</html>
