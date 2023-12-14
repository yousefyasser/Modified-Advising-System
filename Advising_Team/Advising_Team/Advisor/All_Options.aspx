<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="All_Options.aspx.cs" Inherits="Advising_Team.Advisor.All_Options" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>GUC Advising System - Advisor Options</title>
    <link rel="stylesheet" type="text/css" href="../Css/mainStyle.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>Choose An Option</h2>
                    <div class="container">
            <a href="View_Options.aspx" class="option-btn">View</a>
            <a href="Insert_GradPlan.aspx" class="option-btn">Insert GradPlan</a>
            <a href="Add_GradPlan_Course.aspx" class="option-btn">Add GradPlan Course</a>
            <a href="Update_Grad_Date.aspx" class="option-btn">Update Grad Date</a>
            <a href="Delete_GradPlan_Course.aspx" class="option-btn">Delete GradPlan Course</a>
            <a href="Approve_Reject_Request.aspx" class="option-btn">Approve/Reject Request</a>
                    </div>
        </div>
            <asp:HyperLink ID="signOut" href="Advisor_Login.aspx" runat="server">Sign-Out</asp:HyperLink>
      <br />
    </form>
</body>
</html>
