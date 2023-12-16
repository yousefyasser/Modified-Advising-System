<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin_page.aspx.cs" Inherits="Advising_Team.Admin1.admin_page" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="view_button" runat="server" Text="All Advisors" Width="353px" OnClick="button1" Height="68px" />
        &nbsp;&nbsp;&nbsp;<br />
&nbsp;<asp:Button ID="Button00" runat="server" Text="Link student to course" Width="411px" OnClick="button2" Height="66px"  />
        </div>
        <p>
        <asp:Button ID="pending_button" runat="server" Text="the pendingrequests" Height="66px" OnClick="button3" Width="350px" />
        &nbsp;&nbsp;
        <p>
        &nbsp;<asp:Button ID="Button99" runat="server" Text="student to advisor" OnClick="button4" Width="405px" Height="77px" />
        <p>
            <asp:Button ID="Button9999" runat="server" Text="students with advisor" OnClick="button5" Width="349px" Height="57px" />
        &nbsp;&nbsp;&nbsp;
        </p>
        <p>
            &nbsp;<asp:Button ID="Button20" runat="server" Text="instructor to course" Width="400px" OnClick="Button6" Height="49px" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </p>
        <asp:Button ID="Button29399" runat="server" Text="Add New Semester" OnClick="button7" Width="351px" />
        &nbsp;&nbsp;&nbsp;&nbsp;<br />
&nbsp;<asp:Button ID="Button700" runat="server" Text="View instructors with their courses " Width="407px" OnClick="button8" Height="50px" />
&nbsp;<p>
            <asp:Button ID="Button399" runat="server" Text="Add New course" OnClick="button9" Width="351px" Height="54px" />
        &nbsp;&nbsp;</p>
        <p>
            &nbsp;
            <asp:Button ID="Button822" runat="server" Text="View all semesters and their courses" Width="407px" OnClick="Button10" Height="46px" />
        </p>
        <p>
            &nbsp;</p>
        <p>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="Button1241249" runat="server" Text="Log out" Width="230px" OnClick="logbutton" Height="115px" />
        </p>
        <p>
            &nbsp;</p>
    </form>
</body>
</html>
