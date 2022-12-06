using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using MySql.Data;
using MySql.Data.MySqlClient;

namespace MiTasksWAA
{
    public partial class Login : System.Web.UI.Page
    {
        

        [WebMethod(EnableSession = true)]
        public static Dictionary<string,string> wmLogin(NameValue[] formVars)
        {
            int valid = 0;
            MySqlConnection con;
            MySqlCommand cmd;
            MySqlDataReader dr;
            Dictionary<string,string> d = new Dictionary<string,string>();
            var username = formVars.SingleOrDefault(item => item.name == "txtusername").value;
            var password = formVars.SingleOrDefault(item => item.name == "txtpassword").value;
            con = new MySqlConnection("Server=localhost;Database=login;user=root;Pwd=pippy1314;SslMode=none");
            cmd = new MySqlCommand();
            con.Open();
            cmd.Connection = con;
            string s = "SELECT * FROM logins where email='" + username + "' AND password='" + password + "'";
            cmd.CommandText = s;
            dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                
                MessageBox.Show("User Validated");
            }
            else
            {
                MessageBox.Show("Invalid Login please check username and password");
                
            }
            con.Close();
            return d;
        }
        public void Page_Load(object sender, EventArgs e)
        {
        }

    }
}