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
    public partial class Details : System.Web.UI.Page
    {
        private static int id = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                id = Convert.ToInt32(Request.QueryString["rid"].ToString());
            }
            catch
            {
                Response.Redirect("Rooms.aspx");
            }
        }
        [WebMethod]
        public static string singleroom(int id)
        {
            myDAL obj = new myDAL();
            return obj.singleroom(id).GetXml();
        }
        [WebMethod]
        public static string singlepics(int id)
        {
            myDAL obj = new myDAL();
            return obj.singlepics(id).GetXml();
        }
        [WebMethod]
        public static string singlefeatures(int id)
        {
            myDAL obj = new myDAL();
            return obj.singlefeatures(id).GetXml();
        }
        [WebMethod]
        public static string adjacentrooms(int id)
        {
            myDAL obj = new myDAL();
            return obj.adjacentrooms(id).GetXml();
        }
        [WebMethod]
        public static void updatedescription(string descp)
        {
            if (HttpContext.Current.Session["Type"].ToString().ToLower().Equals("admin"))
            {
                myDAL obj = new myDAL();
                obj.updatedescription(id, descp);
            }
        }
        [WebMethod]
        public static void updatefeature(int fid, string feature)
        {
            if (HttpContext.Current.Session["Type"].ToString().ToLower().Equals("admin"))
            {
                myDAL obj = new myDAL();
                obj.updatefeature(fid, feature);
            }
        }
        [WebMethod]
        public static void updateprice(string price)
        {
            if (HttpContext.Current.Session["Type"].ToString().ToLower().Equals("admin"))
            {
                myDAL obj = new myDAL();
                obj.updateprice(id, price);
            }
        }
        [WebMethod]
        public static void updatepicture(int pid, string picture, string old)
        {
            if (HttpContext.Current.Session["Type"].ToString().ToLower().Equals("admin"))
            {
                if (!picture.Contains(@"img/pic.jpg") && !picture.Contains("facebook"))
                    System.IO.File.Delete(HttpRuntime.AppDomainAppPath + "/" + old);
                myDAL obj = new myDAL();
                obj.updatepicture(pid, picture);
            }
        }
        [WebMethod]
        public static void deleteroom()
        {
            if (HttpContext.Current.Session["Type"].ToString().ToLower().Equals("admin"))
            {
                myDAL obj = new myDAL();
                DataTable set = obj.singlepics(id).Tables[0];
                foreach (DataRow item in set.Rows)
                {
                    System.IO.File.Delete(HttpRuntime.AppDomainAppPath + "/" + item["pic"].ToString());
                }
                obj.deleteroom(id);
            }
        }
        [WebMethod]
        public static void deletefeature(int fid)
        {
            if (HttpContext.Current.Session["Type"].ToString().ToLower().Equals("admin"))
            {
                myDAL obj = new myDAL();
                obj.deletefeature(fid);
            }
        }
        [WebMethod]
        public static void deletepicture(int picid, string pic)
        {
            if (HttpContext.Current.Session["Type"].ToString().ToLower().Equals("admin"))
            {
                myDAL obj = new myDAL();
                System.IO.File.Delete(HttpRuntime.AppDomainAppPath + "/" + pic);
                obj.deletepicture(picid);
            }
        }
        [WebMethod]
        public static void updateavailiability(string available)
        {
            if (HttpContext.Current.Session["Type"].ToString().ToLower().Equals("admin"))
            {
                myDAL obj = new myDAL();
                obj.updateavailiability(id, available);
            }
        }
    }
}