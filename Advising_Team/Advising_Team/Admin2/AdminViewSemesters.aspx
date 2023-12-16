<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminViewSemesters.aspx.cs" Inherits="Advising_Team.Admin2.AdminViewSemesters" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label Text="sort by" runat="server" />
            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
            <asp:Button ID="Button1" runat="server" Text="Sort by" OnClick="Sort" AutoPostBack="true"/>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="course_id" AllowSorting="true" OnSorting="GridView1_Sorting">
                <Columns>
                <asp:BoundField DataField="course_id" HeaderText="courseID" ReadOnly="True" SortExpression="courseID" />
                <asp:BoundField DataField="name" HeaderText="courseName" ReadOnly="True" SortExpression="courseName" />
                <asp:BoundField DataField="semester_code" HeaderText="semester_code" ReadOnly="True" SortExpression="semester_code" />
            </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
