<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Link_student_to_course_with_certain_instructor.aspx.cs" Inherits="Advising_Team.Admin1.Link_student_to_course_with_certain_instructor" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="Enter the course ID:"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;
        <asp:Label ID="Label2" runat="server" Text="Enter the  instructor ID:"></asp:Label>
        &nbsp;&nbsp;&nbsp;
        <asp:Label ID="Label3" runat="server" Text="Enter the  student ID:"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;
        </div>
        <asp:TextBox ID="t1" runat="server" Width="188px"></asp:TextBox>
        &nbsp;&nbsp; &nbsp;
        <asp:TextBox ID="t2" runat="server" Width="188px"></asp:TextBox>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;
        <asp:TextBox ID="t3" runat="server" Width="188px"></asp:TextBox>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />
        <br />
        <asp:Label ID="Label4" runat="server" Text="Enter the semester code:"></asp:Label>
        <br />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="t4" runat="server" Width="188px"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="button1" runat="server" Text="Link" OnClick="Button1_Click" Width="192px" />
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="button2" runat="server" Text="return back" Width="209px" style="margin-top: 5px" OnClick="Button2_Click" />
    </form>
</body>
</html>
