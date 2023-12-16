<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDeleteCourse.aspx.cs" Inherits="Advising_Team.Admin2.AdminDeleteCourse" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="removeCourseForm" runat="server">

        <div>
            <asp:Label runat="server" Text="Remove course"></asp:Label>
        </div>

        <br />
        <br />

        <div>
            <asp:Label runat="server" Text="Enter course ID"></asp:Label>
        </div>

        <div>
            <asp:TextBox ID="course_id" runat="server"></asp:TextBox>
        </div>

        <div>
            <asp:Button runat="server" OnClick="RemoveCourse" Text="Enter"></asp:Button>
        </div>

        <div>
            <asp:Label runat="server" id= "msg" Visible="false"></asp:Label>
        </div>

    </form>
</body>

</html>
