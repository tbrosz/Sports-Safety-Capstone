using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MiTasksWAA
{
    public partial class Map : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (!utils.isAuthenticated())
            //{
            //    Response.Redirect("/Login.aspx");
            // }

            ProcessStartInfo start = new ProcessStartInfo();
            // TODO: This will need to be changed to the location of wherever the bat file will be stored on the machine running the server
            // It should be added into a settings file for easy changing.
            start.FileName = @"C:\Users\spenc\OneDrive\Documents\GitHub\Sports-Safety-Capstone\MapsTesting\test.bat";
            start.UseShellExecute = false;
            start.RedirectStandardOutput = true;
            start.RedirectStandardError = true;
            using (Process process = Process.Start(start))
            {
                using (StreamReader reader = process.StandardOutput)
                {
                }
                process.WaitForExit();
            }
        }

        [WebMethod(EnableSession = true)]
        public static Dictionary<string, string> wmLoadEvent(NameValue[] formVars)
        {
            Dictionary<string, string> d = new Dictionary<string, string>();
            if (!utils.isAuthenticated()) return d;
            var mapeventid = formVars.SingleOrDefault(item => item.name == "ctl00$MainContent$ddlevents").value;
            DataSet ds = utils.get_data("SELECT * FROM dbo.xRefMapEventCoordinates WHERE mapeventid = " + mapeventid, out int totalRecords);
            string lats = "";
            string longs = "";
            string tentslat = "";
            string tentslong = "";
            if (totalRecords > 0)
            {
                int i = 0;
                foreach(DataRow dr in ds.Tables[0].Rows)
                {
                    i++;
                    if(i == 205)
                    {
                        i = 0;
                        tentslat += dr["coordinatepointlat"].ToString() + ",";
                        tentslong += dr["coordinatepointlong"].ToString() + ",";
                    }
                    lats += dr["coordinatepointlat"].ToString() + ",";
                    longs += dr["coordinatepointlong"].ToString() + ",";
                }
            }
            d.Add("lats", lats.Substring(0,lats.Length-1));
            d.Add("longs", longs.Substring(0, longs.Length - 1));
            d.Add("tentslat", lats.Substring(0, lats.Length - 1));
            d.Add("tentslong", longs.Substring(0, longs.Length - 1));
            return d;
        }


    }


}