using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MiTasksWAA
{
    public partial class Users : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!utils.isAuthenticated())
            {
                Response.Redirect("/Login.aspx");
            }
        }

        [WebMethod(EnableSession = true)]
        public static Dictionary<string, string> wmLoadUsers(NameValue[] formVars)
        {
            Dictionary<string, string> d = new Dictionary<string, string>();
            if (!utils.isAuthenticated()) return d;
            DataSet ds = utils.get_data("SELECT * FROM dbo.Users", out int totalRecords);
            string html = "";
            if(totalRecords > 0)
            {
                foreach(DataRow dr in ds.Tables[0].Rows)
                {
                    html += $"<div class=\"col-lg-3 col-md-4 col-sm-6 col-xs-12\" runat=\"server\"><div class=\"usercard\"><h2>&nbsp;{dr["firstname"].ToString() + " " + dr["lastname"].ToString()}</h2><a>&nbsp;<a href=\"javascript:editUser({Convert.ToInt32(dr["userid"])});\">Edit</a></a></div></div>";
                }
            }
            d.Add("div_users", html);
            return d;
        }

        [WebMethod(EnableSession = true)]
        public static Dictionary<string, string> wmEditUser(NameValue[] formVars)
        {
            Dictionary<string, string> d = new Dictionary<string, string>();
            if (!utils.isAuthenticated()) return d;
            var userid = formVars.SingleOrDefault(item => item.name == "userid").value;
            DataSet ds = utils.get_data("SELECT * FROM dbo.Users WHERE userid = " + userid, out int totalRecords);
            string firstname = "";
            string lastname = "";
            string dob = "";
            string gender = "";
            if (totalRecords > 0)
            {
                firstname = ds.Tables[0].Rows[0]["firstname"].ToString();
                lastname = ds.Tables[0].Rows[0]["lastname"].ToString();
                dob = Convert.ToDateTime(ds.Tables[0].Rows[0]["dob"]).ToShortDateString();
                gender = ds.Tables[0].Rows[0]["gender"].ToString();
            }
            d.Add("txtfirstname", firstname);
            d.Add("txtlastname", lastname);
            d.Add("txtdob", dob);
            d.Add("ddlGender", gender);
            return d;
        }

        [WebMethod(EnableSession = true)]
        public static Dictionary<string, string> wmSaveUser(NameValue[] formVars)
        {
            Dictionary<string, string> d = new Dictionary<string, string>();
            if (!utils.isAuthenticated()) return d;
            var userid = formVars.SingleOrDefault(item => item.name == "userid").value;
            var lastname = formVars.SingleOrDefault(item => item.name == "lastname").value;
            var firstname = formVars.SingleOrDefault(item => item.name == "firstname").value;
            var dob = formVars.SingleOrDefault(item => item.name == "dob").value;
            var gender = formVars.SingleOrDefault(item => item.name == "gender").value;
            if(userid != "0")
            {
                utils.insert_update_data("UPDATE dbo.Users SET firstname='" + firstname + "',lastname='" + lastname + "',gender='" + gender+ "',dob='" + dob + "' WHERE userid = " + userid);
            }
            return d;
        }


    }


}