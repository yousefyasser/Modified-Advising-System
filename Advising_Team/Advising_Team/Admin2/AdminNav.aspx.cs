using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Advising_Team.Admin2
{
    public partial class AdminNav : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void DeleteCourse(object sender, EventArgs e)
        {
            Response.Redirect("AdminDeleteCourse.aspx");
        }

        protected void DeleteSlots(object sender, EventArgs e)
        {
            Response.Redirect("AdminDeleteSlots.aspx");
        }

        protected void AddExam(object sender, EventArgs e)
        {
            Response.Redirect("AdminAddExam.aspx");
        }

        protected void ViewPayments(object sender, EventArgs e)
        {
            Response.Redirect("AdminViewPayments.aspx");
        }
        protected void IssueInstallments(object sender, EventArgs e)
        {
            Response.Redirect("AdminIssueInstallments.aspx");
        }
        protected void UpdateStatus(object sender, EventArgs e)
        {
            Response.Redirect("AdminUpdateStatus.aspx");
        }
        protected void ViewActiveStudents(object sender, EventArgs e)
        {
            Response.Redirect("AdminViewActiveStudents.aspx");
        }
        protected void ViewGradPlans(object sender, EventArgs e)
        {
            Response.Redirect("AdminViewGradPlans.aspx");
        }
        protected void ViewTranscripts(object sender, EventArgs e)
        {
            Response.Redirect("AdminViewTranscripts.aspx");
        }
        protected void ViewSemesters(object sender, EventArgs e)
        {
            Response.Redirect("AdminViewSemesters.aspx");
        }
        protected void Admin1(object sender, EventArgs e)
        {
            Response.Redirect("../Admin1/admin_page.aspx");
        }
    }
}