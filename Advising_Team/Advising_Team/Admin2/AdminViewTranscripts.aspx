<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminViewTranscripts.aspx.cs" Inherits="Advising_Team.Admin2.AdminViewTranscripts" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Display Transcripts</title>
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
                    <asp:BoundField DataField="f_name" HeaderText="firstName" ReadOnly="True" SortExpression="firstName" />
                    <asp:BoundField DataField="l_name" HeaderText="lastName" ReadOnly="True" SortExpression="lastName" />
                    <asp:BoundField DataField="course_id" HeaderText="courseID" ReadOnly="True" SortExpression="courseID" />
                    <asp:BoundField DataField="name" HeaderText="courseName" ReadOnly="True" SortExpression="courseName" />
                    <asp:BoundField DataField="exam_type" HeaderText="examType" ReadOnly="True" SortExpression="examType" />
                    <asp:BoundField DataField="grade" HeaderText="grade" ReadOnly="True" SortExpression="grade" />
                    <asp:BoundField DataField="semester_code" HeaderText="semester_code" ReadOnly="True" SortExpression="semester_code" />
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
