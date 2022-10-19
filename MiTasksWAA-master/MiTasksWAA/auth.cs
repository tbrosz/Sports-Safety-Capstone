using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace MiTasksWAA
{
    public class auth
    {
        
        public static bool Login(string username, string password)
        {
            System.Web.SessionState.HttpSessionState ss = HttpContext.Current.Session;
            DataSet ds = utils.get_data("SELECT * FROM Users WHERE username = '" + username + "' AND pw = '" + password + "'", out int total);
            if(total > 0)
            {         
                ss["nameid"] = Convert.ToInt32(ds.Tables[0].Rows[0]["userid"]);
                return true;
            }
            else
            {
                ss["nameid"] = null;
                return false;
            }
        }

        public static void LogOut()
        {
            System.Web.SessionState.HttpSessionState ss = HttpContext.Current.Session;
            ss["nameid"] = null;
            return;
        }
    }


}