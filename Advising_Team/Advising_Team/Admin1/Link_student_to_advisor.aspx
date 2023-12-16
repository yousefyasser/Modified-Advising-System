<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Link_student_to_advisor.aspx.cs" Inherits="Advising_Team.Admin1.Link_student_to_advisor" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="Enter the student id :"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="Label2" runat="server" Text="Enter the advisor id :"></asp:Label>
        </div>
        <asp:TextBox ID="t1" runat="server"></asp:TextBox>
        &nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="t2" runat="server"></asp:TextBox>
        <br />
        <br />
        <br />
        <asp:Button ID="button1" runat="server" Text="Link" Width="183px" OnClick="Button1_Click" />
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </form>
</body>
</html>
