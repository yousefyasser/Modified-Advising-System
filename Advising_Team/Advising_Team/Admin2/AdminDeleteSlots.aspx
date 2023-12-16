<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDeleteSlots.aspx.cs" Inherits="Advising_Team.Admin2.AdminDeleteSlot" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="removeCourseForm" runat="server">

        <div>
            <asp:Label runat="server" Text="Delete slots of unoffered courses"></asp:Label>
        </div>

        <br />
        <br />

        <div>
            <asp:Label runat="server" Text="Enter current semester code"></asp:Label>
        </div>

        <div>
            <asp:TextBox ID="semester_code" runat="server"></asp:TextBox>
        </div>

        <div>
            <asp:Button runat="server" OnClick="RemoveSlots" Text="Enter"></asp:Button>
        </div>

        <div>
            <asp:Label runat="server" id= "msg" Visible="false"></asp:Label>
        </div>

    </form>
</body>
</html>
