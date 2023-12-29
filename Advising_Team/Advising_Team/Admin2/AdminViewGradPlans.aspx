<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminViewGradPlans.aspx.cs" Inherits="Advising_Team.Admin2.AdminViewGradPlan" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Display graduation plan along with their initiated advisors</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label Text="sort by" runat="server" />
            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
            <asp:Button ID="Button1" runat="server" Text="Sort by" OnClick="Sort" AutoPostBack="true"/>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="student_id" AllowSorting="true" OnSorting="GridView1_Sorting">
                <Columns>
                    <asp:BoundField DataField="plan_id" HeaderText="plan_id" SortExpression="plan_id" />
                    <asp:BoundField DataField="semester_code" HeaderText="semester_code" SortExpression="semester_code" />
                    <asp:BoundField DataField="semester_credit_hours" HeaderText="semester_credit_hours" SortExpression="semester_credit_hours" />
                    <asp:BoundField DataField="expected_grad_date" HeaderText="expected_grad_date" SortExpression="expected_grad_date" />
                    <asp:BoundField DataField="advisor_id" HeaderText="advisorID" SortExpression="advisorID" />
                    <asp:BoundField DataField="student_id" HeaderText="studentID" ReadOnly="True" SortExpression="studentID" />
                    <asp:BoundField DataField="name" HeaderText="advisor_name" SortExpression="advisor_name" />
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>