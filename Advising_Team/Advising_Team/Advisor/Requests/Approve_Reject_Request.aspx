<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Approve_Reject_Request.aspx.cs" Inherits="Advising_Team.Advisor.Requests.Approve_Reject_Request" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>GUC Advising System - Approve/Reject Request</title>
    <link rel="stylesheet" type="text/css" href="~/Css/mainStyle.css" />
</head>
<body>
    <form id="form2" runat="server">
        <div>
            <h2>Approve/Reject Request</h2>
                    <div class="container">
            <a href="Approve_Reject_Course_Request.aspx" class="option-btn">Course</a>
            <a href="Approve_Reject_Credit_Hour_Request.aspx" class="option-btn">Credit Hour</a>
                        <asp:HyperLink ID="view_reqs" href="../Views/View_All_Requests.aspx" runat="server">View Requests</asp:HyperLink>
                            <br />
                        <br />
                        <asp:HyperLink ID="back5" href="../All_Options.aspx" runat="server">Go Back</asp:HyperLink>
                           <br />
                    </div>
        </div>
    </form>
</body>
</html>
