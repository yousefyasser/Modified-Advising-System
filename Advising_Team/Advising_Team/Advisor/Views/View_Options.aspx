<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="View_Options.aspx.cs" Inherits="Advising_Team.Advisor.Views.View_Options" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>GUC Advising System - Advisor Options</title>
    <link rel="stylesheet" type="text/css" href="~/Css/mainStyle.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>View Options</h2>
                <div class="container">
                <a href="View_Students.aspx" class="option-btn">Students</a>
                    <a href="../Pick_Major.aspx" class="option-btn">Students + Major </a>
                    <a href="View_All_Requests.aspx" class="option-btn">Requests</a>
                    <a href="View_Pending_Requests.aspx" class="option-btn">Pending Requests</a>
                </div>
            <asp:HyperLink ID="back1" href="../All_Options.aspx" runat="server">Go Back</asp:HyperLink>
        </div>
    </form>
</body>
</html>