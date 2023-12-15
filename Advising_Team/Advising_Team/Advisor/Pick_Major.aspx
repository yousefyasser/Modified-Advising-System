<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Pick_Major.aspx.cs" Inherits="Advising_Team.Advisor.Pick_Major" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Pick Major</title>
    <link href= "~/Css/mainStyle.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>Pick Major</h2>

            <asp:TextBox ID="mAjor" runat="server" CssClass="form-control" placeholder="Enter Major"></asp:TextBox>
            <br />

            <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="option-btn" OnClick="btnSubmit_Click" />
                <asp:HyperLink ID="back8" href="Views/View_Options.aspx" runat="server">Go Back</asp:HyperLink>
                <br />

            <asp:Label ID="successMessage" CssClass="alert-success" style="padding:10px; border-radius:5px;" runat="server" Visible="false"></asp:Label>
            <asp:Label ID="errorMessage" CssClass="alert-danger" style="padding:10px; border-radius:5px;" runat="server" Visible="false"></asp:Label>
        </div>
    </form>
</body>
</html>
