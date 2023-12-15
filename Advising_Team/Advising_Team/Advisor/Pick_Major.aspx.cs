using System;
using System.Web.UI.WebControls;

namespace Advising_Team.Advisor
{
    public partial class Pick_Major : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // redirect if the session is closed
            if (Session["user"] == null)
            {
                Response.Redirect("../Advisor_Login.aspx");
                return;
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            // Validate that the major is entered
            if (string.IsNullOrWhiteSpace(mAjor.Text))
            {
                ShowErrorMessage("Major field is required.", errorMessage, successMessage);
                return;
            }

            // Store the entered major in Session
            Session["major"] = mAjor.Text;

            // Redirect to view assigned students related to major
            Response.Redirect("Views/View_Students_Major.aspx"); 
        }

        public static void ShowErrorMessage(string message, Label errorMessage,Label successMessage)
        {
            errorMessage.Text = message;
            errorMessage.Visible = true;
            successMessage.Visible = false;
        }
    }
}
