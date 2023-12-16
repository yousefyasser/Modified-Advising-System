<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminAddExam.aspx.cs" Inherits="Advising_Team.Admin2.AdminAddExam" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="removeCourseForm" runat="server">

        <div>
            <asp:Label runat="server" Text="Add makeup exam"></asp:Label>
        </div>

        <br />
        <br />

        <div>
            <asp:Label runat="server" Text="Choose exam type"></asp:Label>
        </div>

        <div>
            <asp:DropDownList ID="examType" runat="server"></asp:DropDownList>
        </div>

        <div>
           <asp:Label runat="server" Text="Enter exam datetime"></asp:Label>
        </div>

        <div>
            <asp:TextBox ID="examDatetime" runat="server"></asp:TextBox>
        </div>

        <div>
            <asp:Label runat="server" Text="Enter exam course ID"></asp:Label>
        </div>

        <div>
            <asp:TextBox ID="courseID" runat="server"></asp:TextBox>
        </div>

        <div>
            <asp:Button runat="server" OnClick="AddExam" Text="Enter"></asp:Button>
        </div>

        <div>
            <asp:Label runat="server" id= "msg" Visible="false"></asp:Label>
        </div>

    </form>
</body>
</html>
