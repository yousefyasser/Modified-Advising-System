<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Add_Student_PhoneNumbers.aspx.cs" Inherits="Advising_Team.Student.Add_Student_PhoneNumbers" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>University Advising System - Add Phone Number(s)</title>
    <link rel="stylesheet" type="text/css" href="../Css/mainStyle.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>University Advising System - Add Phone Number(s)</h2><br />
            Phone Number<asp:TextBox ID="phones" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="add" runat="server" OnClick="add_phone" Text="Add" />
            <br />
            <br />
            <asp:Label ID="successMessage" runat="server" CssClass="success-message" Visible="false"></asp:Label>
            <asp:Label ID="errorMessage" runat="server" CssClass="error-message" Visible="false"></asp:Label>
        </div>
    </form>
</body>
</html>
