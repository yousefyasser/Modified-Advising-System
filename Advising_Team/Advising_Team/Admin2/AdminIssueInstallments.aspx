<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminIssueInstallments.aspx.cs" Inherits="Advising_Team.Admin2.AdminIssueInstallments" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Issue Installments</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label runat="server" Text="Enter payment ID to issue installments"></asp:Label>
        </div>
        <div>
            <asp:TextBox runat="server" ID="paymentID"></asp:TextBox>
        </div>
        <div>
            <asp:Button runat="server" Text="Enter" OnClick="IssueInstallments" />
        </div>
        <div>
            <asp:Label runat="server" ID="message" Visible="false"></asp:Label>
        </div>
    </form>
</body>
</html>
