<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminViewPayments.aspx.cs" Inherits="Advising_Team.Admin2.AdminViewPayments" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Display payments</title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        <asp:Button ID="Button1" runat="server" Text="Sort" OnClick="Button1_Click" />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="true">
        </asp:GridView>
    </form>
</body>

</html>