using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication7
{
    public partial class Profile : System.Web.UI.Page
    {
        private static int id = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                id = Convert.ToInt32(Session["id"].ToString());
            }
            catch
            {
                Response.Redirect("Home.aspx");
            }
        }
        [WebMethod]
        public static string getaccounts()
        {
            if (HttpContext.Current.Session["Type"].ToString().ToLower().Equals("admin"))
            {
                myDAL obj = new myDAL();
                return obj.getaccounts().GetXml();
            }
            return "0";
        }
        [WebMethod]
        public static string getbookings()
        {
            myDAL obj = new myDAL();
            return obj.getbookings(id).GetXml();
        }
        [WebMethod]
        public static int cancelbooking(int bookid)
        {
            myDAL obj = new myDAL();
            return obj.cancelbooking(bookid, id);
        }
        [WebMethod]
        public static void deleteuser(int accid, string pic)
        {
            if (HttpContext.Current.Session["Type"].ToString().ToLower().Equals("admin"))
            {
                myDAL obj = new myDAL();
                if (!pic.Contains(@"img/pic.jpg") && !pic.Contains("facebook"))
                    System.IO.File.Delete(HttpRuntime.AppDomainAppPath + "/" + pic);
                obj.deleteuser(accid);
            }
        }
    }
}