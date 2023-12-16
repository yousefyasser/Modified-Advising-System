<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="add_semester.aspx.cs" Inherits="Advising_Team.Admin1.add_semester" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Label ID="Label1" runat="server" Text="Enter Semester code"></asp:Label>
        :&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="Label2" runat="server" Text="Enter Start date:"></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="Label3" runat="server" Text="Enter end date :"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <p>
            <asp:TextBox ID="t1" runat="server"></asp:TextBox>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="t2" runat="server"></asp:TextBox>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="t3" runat="server"></asp:TextBox>
        </p>
        <p>
            <asp:Button ID="add" runat="server" Text="Add" OnClick="Button1_Click" Width="190px" />
        &nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="return" runat="server" Text="Return" Width="209px" style="margin-top: 5px" OnClick="Button2_Click" />
            </p>
        <p>
            &nbsp;</p>
        <br />
        <p>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </p>
    </form>
</body>
</html>
