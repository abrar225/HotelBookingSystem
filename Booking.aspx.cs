using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication7
{
    public partial class Booking : System.Web.UI.Page
    {
        int roomid;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                roomid = Convert.ToInt32(Request.QueryString["rid"].ToString());
            }
            catch
            {
                if (!HttpContext.Current.Request.Path.EndsWith("Rooms.aspx", StringComparison.InvariantCultureIgnoreCase))
                    Response.Redirect("Rooms.aspx");
            }
        }
        [WebMethod]
        public static int bookaroom(string name, string email, string phone, string checkin, string checkout, string comment, int roomid)
        {
            myDAL obj = new myDAL();
            return obj.bookaroom(name, email, phone, checkin, checkout, comment, roomid);
        }
        [WebMethod]
        public static string adjustdate(int roomid)
        {
            myDAL obj = new myDAL();
            return obj.dateadjust(roomid).GetXml();
        }
    }
}