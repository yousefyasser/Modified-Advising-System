<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminNav.aspx.cs" Inherits="Advising_Team.Admin2.AdminNav" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="Button1" runat="server" Text="Delete Course" OnClick="DeleteCourse"/>
            <asp:Button ID="Button2" runat="server" Text="Delete Slots" OnClick="DeleteSlots"/>
            <asp:Button ID="Button3" runat="server" Text="Add Exam" OnClick="AddExam"/>
            <asp:Button ID="Button4" runat="server" Text="View Payments" OnClick="ViewPayments"/>
            <asp:Button ID="Button5" runat="server" Text="Issue Installments" OnClick="IssueInstallments"/>
            <asp:Button ID="Button6" runat="server" Text="Update Status" OnClick="UpdateStatus"/>
            <asp:Button ID="Button7" runat="server" Text="View Active Students" OnClick="ViewActiveStudents"/>
            <asp:Button ID="Button8" runat="server" Text="View Graduation Plans" OnClick="ViewGradPlans"/>
            <asp:Button ID="Button9" runat="server" Text="ViewTranscripts" OnClick="ViewTranscripts"/>
            <asp:Button ID="Button10" runat="server" Text="View Semesters" OnClick="ViewSemesters"/>
        </div>
    </form>
</body>
</html>
