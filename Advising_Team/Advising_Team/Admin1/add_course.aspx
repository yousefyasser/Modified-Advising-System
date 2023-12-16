<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="add_course.aspx.cs" Inherits="Advising_Team.Admin1.add_course" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
        <asp:Label ID="Label1" runat="server" Text="Enter major"></asp:Label>
        :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="Label2" runat="server" Text="Enter semester"></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="Label3" runat="server" Text="Enter credit hours"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="Label4" runat="server" Text="enter name "></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;<p>
            <asp:TextBox ID="t1" runat="server"></asp:TextBox>
        &nbsp;
            <asp:TextBox ID="t2" runat="server"></asp:TextBox>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="t3" runat="server"></asp:TextBox>
        &nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="t4" runat="server" Height="16px" style="margin-top: 0px" Width="183px"></asp:TextBox>
        &nbsp;</p>
        <p>
            &nbsp;</p>
        <p>
        <asp:Label ID="Label5" runat="server" Text="enter isoffered"></asp:Label>
        </p>
        <p>
            <asp:TextBox ID="t5" runat="server" style="margin-left: 3px"></asp:TextBox>
        </p>
        <p>
            <asp:Button ID="add" runat="server" Text="add the course" OnClick="Button1_Click" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="return" runat="server" Text="return to admin page" Width="209px" style="margin-top: 5px" OnClick="Button2_Click" />
            </p>
        <p>
            &nbsp;</p>
        <br />
        <br />
        <br />
        <br />
        <br />
        <p>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </p>
    </form>
</body>
</html>
