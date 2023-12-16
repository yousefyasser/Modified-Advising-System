<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminUpdateStatus.aspx.cs" Inherits="Advising_Team.Admin2.AdminUpdateStatus" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="Enter student ID to update his/her status"></asp:Label>
        </div>
        <div>
            <asp:TextBox ID="studentID" runat="server"></asp:TextBox>
        </div>
        <div>
            <asp:Button ID="Button1" runat="server" Text="Enter" OnClick="btnUpdateStatus_Click" />
        </div>
        <div>
            <asp:Label ID="message" runat="server" Visible="false"></asp:Label>
        </div>
    </form>
</body>
</html>
