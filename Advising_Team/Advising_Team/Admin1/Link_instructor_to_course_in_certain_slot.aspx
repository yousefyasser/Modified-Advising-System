<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Link_instructor_to_course_in_certain_slot.aspx.cs" Inherits="Advising_Team.Admin1.Link_instructor_to_course_in_certain_slot" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="Enter course ID :"></asp:Label>
        </div>
        <asp:TextBox ID="t1" runat="server"></asp:TextBox>
        <br />
            <asp:Label ID="Label2" runat="server" Text="Enter Instructor ID :"></asp:Label>
        <br />
        <asp:TextBox ID="t2" runat="server"></asp:TextBox>
        <br />
            <asp:Label ID="Label3" runat="server" Text="Enter Slot ID :"></asp:Label>
        <br />
        <asp:TextBox ID="t3" runat="server"></asp:TextBox>
        <p>
            <asp:Button ID="Button1" runat="server" Text="Execute" Width="181px" OnClick="Button1_Click1" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </p>
         </form>
    </body>
</html>
