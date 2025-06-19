using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication7
{
    public partial class Rooms : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public static string getrooms(string status, int start, int end, string type, string checkin, string checkout)
        {
            if (status.ToLower() == "unapproved")
            {
                try
                {
                    if (HttpContext.Current.Session["Type"].ToString().ToLower().Equals("admin"))
                    {
                        myDAL obj = new myDAL();
                        return obj.getrooms(status, start, end, type, checkin, checkout).GetXml();
                    }
                    else
                    {
                        return "0";
                    }
                }
                catch
                {
                    return "0";
                }
            }
            else
            {
                myDAL obj = new myDAL();
                return obj.getrooms(status, start, end, type, checkin, checkout).GetXml();
            }
        }
        [WebMethod]
        public static void updatesession(int id)
        {
            HttpContext.Current.Session["roomid"] = id;
        }
        [WebMethod]
        public static void deleteroom(int rid)
        {
            if (HttpContext.Current.Session["Type"].ToString().ToLower().Equals("admin"))
            {
                myDAL obj = new myDAL();
                DataTable set = obj.singlepics(rid).Tables[0];
                foreach (DataRow item in set.Rows)
                {
                    System.IO.File.Delete(HttpRuntime.AppDomainAppPath + "/" + item["pic"].ToString());
                }
                obj.deleteroom(rid);
            }
        }
    }
}