using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace MiTasksWAA
{
    public class utils
    {

        public static bool isAuthenticated()
        {
            if(HttpContext.Current.Session["nameid"] == null)
            {
                return false;
            }
            return true;
        }
        public static string Base64Decode(string base64EncodedData)
        {
            var base64EncodedBytes = System.Convert.FromBase64String(base64EncodedData);
            return System.Text.Encoding.UTF8.GetString(base64EncodedBytes);
        }
        public static string Base64Encode(string plainText)
        {
            var plainTextBytes = System.Text.Encoding.UTF8.GetBytes(plainText);
            return System.Convert.ToBase64String(plainTextBytes);
        }
        public static DataSet get_data(string sqlcommand, out int totalRecords)
        {
            string connectionString;
            string queryString = sqlcommand;
            SqlDataAdapter adapter = new SqlDataAdapter();
            connectionString =
            "Data Source=sql5107.site4now.net;" +
            "Initial Catalog=db_a83e13_uoflhealth;" +
            "User id=db_a83e13_uoflhealth_admin;" +
            "Password=Test#123;";
            DataSet ds = new DataSet();
            using (SqlConnection connection = new SqlConnection(
                          connectionString))
            {
                SqlCommand command = new SqlCommand(
                    queryString, connection);
                connection.Open();
                adapter.SelectCommand = command;
                string commandstring = adapter.SelectCommand.ToString();
                adapter.Fill(ds);
                adapter.Dispose();
                command.Dispose();
                connection.Close();

            }
            totalRecords = ds.Tables[0].Rows.Count;
            return ds;
        }

        public static void insert_update_data(string sqlcommand)
        {
            string connectionString;
            string queryString = sqlcommand;
            SqlDataAdapter adapter = new SqlDataAdapter();
            connectionString =
            "Data Source=sql5107.site4now.net;" +
            "Initial Catalog=db_a83e13_uoflhealth;" +
            "User id=db_a83e13_uoflhealth_admin;" +
            "Password=Test#123;";
            DataSet ds = new DataSet();
            using (SqlConnection connection = new SqlConnection(
                          connectionString))
            {
                SqlCommand command = new SqlCommand(
                    queryString, connection);
                connection.Open();
                command.ExecuteNonQuery();
                connection.Close();

            }
        }
    }

    public class NameValue
    {
        public string name { get; set; }
        public string value { get; set; }
    }
}