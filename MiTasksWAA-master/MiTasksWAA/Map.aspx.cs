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
    public partial class Map : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!utils.isAuthenticated())
            {
                Response.Redirect("/Login.aspx");
            }
            ListItem li = new ListItem();
            li.Value = "0";
            li.Text = "";
            ddlevents.Items.Add(li);
            DataSet eventsDs = utils.get_data("SELECT * FROM MapEvents", out int total);
            foreach(DataRow dr in eventsDs.Tables[0].Rows)
            {
                ListItem li1 = new ListItem();
                li1.Value = dr["mapeventid"].ToString();
                li1.Text = dr["mapeventname"].ToString();
                ddlevents.Items.Add(li1);
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