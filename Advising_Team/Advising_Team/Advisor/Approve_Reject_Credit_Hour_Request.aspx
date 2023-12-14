<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Approve_Reject_Credit_Hour_Request.aspx.cs" Inherits="Advising_Team.Advisor.Approve_Reject_Credit_Hour_Request" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Approve/Reject Credit Hour Request</title>
    <link href="/Css/mainStyle.css" rel="stylesheet" />
</head>
<body>
    <form id="form11" runat="server">
        <div>
            <h2>Approve/Reject Credit Hour Request</h2>

            <asp:TextBox ID="txtReqID1" runat="server" placeholder="Enter Request ID"></asp:TextBox>
            <br />

            <asp:TextBox ID="currSem1" runat="server" placeholder="Enter Current Semester"></asp:TextBox>
            <br />

            <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="option-btn" OnClick="btnSubmit_Click" />
                <asp:HyperLink ID="back12" href="Approve_Reject_Request.aspx" runat="server">Go Back</asp:HyperLink>
                 <br />

            <asp:Label ID="successMessage" runat="server" Visible="false"></asp:Label>
            <asp:Label ID="errorMessage" runat="server" Visible="false"></asp:Label>
        </div>
    </form>
</body>
</html>
