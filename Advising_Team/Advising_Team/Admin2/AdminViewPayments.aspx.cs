using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Advising_Team.Admin2
{
    public partial class AdminViewPayments : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Get the connection string from web.config
            string connectionString = ConfigurationManager.ConnectionStrings["Advising_System"].ConnectionString;

            // Create a SQL command to select all data from the Student_Payment table
            string commandText = "SELECT * FROM Student_Payment";

            // Create a data adapter to execute the command and fill the data set
            SqlDataAdapter dataAdapter = new SqlDataAdapter(commandText, connectionString);
            DataSet dataSet = new DataSet();
            dataAdapter.Fill(dataSet);

            // Bind the data set to the grid view
            GridView1.DataSource = dataSet;
            GridView1.DataBind();

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            // Get the user input from the text box
            string[] columns = TextBox1.Text.Split(',');

            // Get the connection string from web.config
            string connectionString = ConfigurationManager.ConnectionStrings["Advising_System"].ConnectionString;

            // Create a SQL command to select all data from the Student_Payment table
            string commandText = "SELECT * FROM Student_Payment";

            // Create a data adapter to execute the command and fill the data set
            SqlDataAdapter dataAdapter = new SqlDataAdapter(commandText, connectionString);
            DataSet dataSet = new DataSet();
            dataAdapter.Fill(dataSet);

            // Create a data view from the data set and sort it by the user input
            DataView dataView = dataSet.Tables[0].DefaultView;
            dataView.Sort = string.Join(", ", columns);

            // Bind the data view to the grid view
            GridView1.DataSource = dataView;
            GridView1.DataBind();
        }
    }
}