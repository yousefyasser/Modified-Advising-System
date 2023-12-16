<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminViewActiveStudents.aspx.cs" Inherits="Advising_Team.Admin2.AdminViewActiveStudents" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Display Database Table Using Datagrid</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label Text="sort by" runat="server" />
            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
            <asp:Button ID="Button1" runat="server" Text="Sort by" OnClick="Sort" AutoPostBack="true"/>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="student_id" AllowSorting="true" OnSorting="GridView1_Sorting">
                <Columns>
                    <asp:BoundField DataField="student_id" HeaderText="studentID" ReadOnly="True" SortExpression="studentID" />
                    <asp:BoundField DataField="f_name" HeaderText="firstName" SortExpression="firstName" />
                    <asp:BoundField DataField="l_name" HeaderText="lastName" SortExpression="lastName" />
                    <asp:BoundField DataField="password" HeaderText="Password" SortExpression="Password" />
                    <asp:BoundField DataField="gpa" HeaderText="gpa" SortExpression="gpa" />
                    <asp:BoundField DataField="faculty" HeaderText="faculty" SortExpression="faculty" />
                    <asp:BoundField DataField="email" HeaderText="Email" SortExpression="Email" />
                    <asp:BoundField DataField="major" HeaderText="major" SortExpression="major" />
                    <asp:BoundField DataField="financial_status" HeaderText="financialStatus" SortExpression="financialStatus" />
                    <asp:BoundField DataField="semester" HeaderText="semester" SortExpression="semester" />
                    <asp:BoundField DataField="acquired_hours" HeaderText="acquiredHours" SortExpression="acquiredHours" />
                    <asp:BoundField DataField="assigned_hours" HeaderText="assignedHours" SortExpression="assignedHours" />
                    <asp:BoundField DataField="advisor_id" HeaderText="advisorID" SortExpression="advisorID" />
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>