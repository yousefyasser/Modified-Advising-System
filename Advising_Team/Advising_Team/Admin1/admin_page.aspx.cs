using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Advising_Team.Admin1
{
    public partial class admin_page : System.Web.UI.Page
    {
        
        // ahm sf7ah hena lazem t8iyar kole el webforms ele nta ht8iyaroh
        protected void button1(object sender, EventArgs e)
        {
            Response.Redirect("View_all_advisors.aspx");
        }

        protected void button3(object sender, EventArgs e)
        {
            Response.Redirect("view_all_pending_requests.aspx");
        }

        protected void button5(object sender, EventArgs e)
        {
            Response.Redirect("view_all_students_with_advisors.aspx");
        }

        protected void button7(object sender, EventArgs e)
        {
            Response.Redirect("add_semester.aspx");
        }

        protected void button9(object sender, EventArgs e)
        {
            Response.Redirect("add_course.aspx");
        }

        protected void Button6(object sender, EventArgs e)
        {
            Response.Redirect("Link_instructor_to_course_in_certain_slot.aspx");
        }

        protected void button4(object sender, EventArgs e)
        {
            Response.Redirect("Link_student_to_advisor.aspx");
        }

        protected void  button2(object sender, EventArgs e)
        {
            Response.Redirect("Link_student_to_course_with_certain_instructor.aspx");
        }

        protected void button8(object sender, EventArgs e)
        {
            Response.Redirect("view_all_details_of_instructors_with_courses.aspx");
        }

        protected void Button10(object sender, EventArgs e)
        {
            Response.Redirect("view_semester_along_with_their_courses.aspx");
        }

        protected void logbutton(object sender, EventArgs e)
        {
            Response.Redirect("../Student/Student_Login.aspx");
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

       
    }
}