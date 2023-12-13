using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace Advising_Team.Student
{
    public partial class Course_Request : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user"] == null)
            {
                Response.Redirect("Student_Login.aspx");
                return;
            }
        }

        protected void SendCourseRequest(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Advising_System"].ToString();

            using(SqlConnection conn = new SqlConnection(connStr)) {
                conn.Open();

                if (!int.TryParse(courseID.Value, out int course))
                {
                    errorMessage.Text = "Invalid Course ID";
                    errorMessage.Visible = true;
                    successMessage.Visible = false;
                    return;
                }

                int studentId = (int)Session["user"];
                string commentIn = comment.Value;

                using(SqlCommand courseRequestProc = new SqlCommand("Procedures_StudentSendingCourseRequest", conn))
                {
                    courseRequestProc.CommandType = CommandType.StoredProcedure;
                    courseRequestProc.Parameters.Add(new SqlParameter("@courseID", course));
                    courseRequestProc.Parameters.Add(new SqlParameter("@StudentID", studentId));
                    courseRequestProc.Parameters.Add(new SqlParameter("@type", "course"));
                    courseRequestProc.Parameters.Add(new SqlParameter("@comment", commentIn));

                    courseRequestProc.ExecuteNonQuery();

                    // display changes to web page
                    successMessage.Text = "Course Request was sent successfully!";
                    successMessage.Visible = true;
                    errorMessage.Visible = false;
                    courseID.Value = "";
                    comment.Value = "";
                }
            }
        }
    }
}