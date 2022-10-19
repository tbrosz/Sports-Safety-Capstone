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
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod(EnableSession = true)]
        public static Dictionary<string,string> wmLogin(NameValue[] formVars)
        {
            Dictionary<string,string> d = new Dictionary<string,string>();
            var username = formVars.SingleOrDefault(item => item.name == "txtusername").value;
            var password = formVars.SingleOrDefault(item => item.name == "txtpassword").value;
            password = utils.Base64Encode(password);
            DataSet ds = utils.get_data("SELECT * FROM dbo.Users WHERE username = '" + username + "' AND pw = '" + password + "'", out int total);
            if(total > 0)
            {
                auth.Login(username, password);
                d.Add("verified", "true");
            }
           else
            {
                d.Add("verified", "false");
            }
            return d;
        }
    }
}