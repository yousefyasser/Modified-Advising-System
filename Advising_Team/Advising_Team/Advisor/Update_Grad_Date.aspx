<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Update_Grad_Date.aspx.cs" Inherits="Advising_Team.Advisor.Update_Grad_Date" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Update Graduation Date</title>
    <link href="/Css/mainStyle.css" rel="stylesheet" />
</head>

<body>
    <form id="form1" runat="server">
        <div>
            <h2>Update Graduation Date</h2>


            <asp:TextBox ID="txtStudentID" runat="server" CssClass="form-control" placeholder="Enter Student ID"></asp:TextBox>
            <br />

            <asp:Label ID="lblExpectedGradDate" runat="server" Text="New Expected Grad Date:"></asp:Label>
            <asp:TextBox ID="txtExpectedGradDate" runat="server" CssClass="form-control" type="date"></asp:TextBox>
            <br />

            <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="option-btn" OnClick="btnUpdate_Click" />
            <asp:HyperLink ID="back3" href="All_Options.aspx" runat="server">Go Back</asp:HyperLink>
            <br />

            <asp:Label ID="successMessage" runat="server" Visible="false"></asp:Label>
            <asp:Label ID="errorMessage" runat="server" Visible="false"></asp:Label>
        </div>
    </form>
</body>
</html>
