using System;

namespace Advising_Team.Advisor
{
    public partial class Pick_Major : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // redirect if the session is closed
            if (Session["user"] == null)
            {
                Response.Redirect("Advisor_Login.aspx");
                return;
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            // Validate that the major is entered
            if (string.IsNullOrWhiteSpace(mAjor.Text))
            {
                ShowErrorMessage("Major field is required.");
                return;
            }

            // Store the entered major in Session
            Session["major"] = mAjor.Text;

            // Redirect to view assigned students related to major
            Response.Redirect("View_Students_Major.aspx"); 
        }

        private void ShowErrorMessage(string message)
        {
            errorMessage.Text = message;
            errorMessage.Visible = true;
            successMessage.Visible = false;
        }
    }
}
