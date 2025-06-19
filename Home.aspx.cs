using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication7
{
    public partial class Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                string id = Request.QueryString["id"].ToString();
                Session["id"] = Decrypt(id);
            }
            catch
            {
                
            }
        }
        private static string Decrypt(string cipherText)
        {
            string EncryptionKey = "MAKV2SPBNI99212";
            cipherText = cipherText.Replace(" ", "+");
            byte[] cipherBytes = Convert.FromBase64String(cipherText);
            using (Aes encryptor = Aes.Create())
            {
                Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                encryptor.Key = pdb.GetBytes(32);
                encryptor.IV = pdb.GetBytes(16);
                using (MemoryStream ms = new MemoryStream())
                {
                    using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateDecryptor(), CryptoStreamMode.Write))
                    {
                        cs.Write(cipherBytes, 0, cipherBytes.Length);
                        cs.Close();
                    }
                    cipherText = Encoding.Unicode.GetString(ms.ToArray());
                }
            }
            return cipherText;
        }
        private static string Encrypt(string clearText)
        {
            string EncryptionKey = "MAKV2SPBNI99212";
            byte[] clearBytes = Encoding.Unicode.GetBytes(clearText);
            using (Aes encryptor = Aes.Create())
            {
                Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                encryptor.Key = pdb.GetBytes(32);
                encryptor.IV = pdb.GetBytes(16);
                using (MemoryStream ms = new MemoryStream())
                {
                    using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateEncryptor(), CryptoStreamMode.Write))
                    {
                        cs.Write(clearBytes, 0, clearBytes.Length);
                        cs.Close();
                    }
                    clearText = Convert.ToBase64String(ms.ToArray());
                }
            }
            return clearText;
        }
        [WebMethod]
        public static void setsession(string id , string type)
        {
            HttpContext.Current.Session["Type"] = type;
            HttpContext.Current.Session["id"] = id;
        }
        [WebMethod]
        public static int getsessionid()
        {
            try
            {
                return Convert.ToInt32(HttpContext.Current.Session["id"].ToString());
            }
            catch
            {
                return -1;
            }
        }
        [WebMethod]
        public static int addroom(string price, string descp, string type, string name)
        {
            try
            {
                if (HttpContext.Current.Session["Type"].ToString().ToLower().Equals("admin"))
                {
                    myDAL obj = new myDAL();
                    return obj.addroom(price, descp, type, name);
                }
                else
                {
                    return -1;
                }
            }
            catch
            {
                return -1;
            }
        }
        [WebMethod]
        public static int addreview(string name, string email, string cno, string comment, int rating)
        {
            myDAL obj = new myDAL();
            return obj.addreview(name, email, cno, comment, rating);
        }
        [WebMethod]
        public static int addpics(string pics, int id)
        {
            try
            {
                if (HttpContext.Current.Session["Type"].ToString().ToLower().Equals("admin"))
                {
                    myDAL obj = new myDAL();
                    return obj.addpics(pics, id);
                }
                else
                {
                    return -1;
                }
            }
            catch
            {
                return -1;
            }
        }
        [WebMethod]
        public static int addfeatures(string features, int id)
        {
            try
            {
                if (HttpContext.Current.Session["Type"].ToString().ToLower().Equals("admin"))
                {
                    myDAL obj = new myDAL();
                    return obj.addfeatures(features, id);
                }
                else
                {
                    return -1;
                }

            }
            catch
            {
                return -1;
            }
        }
        [WebMethod]
        public static string loginto(string username, string pass)
        {
            myDAL obj = new myDAL();
            string type = "";
            int id = 0;
            int status = 0;
            string email = "";
            int result = obj.loginto(username, pass, ref id, ref type, ref status, ref email);
            HttpContext.Current.Session["id1"] = id;
            if (result == 1 && status == 1)
            {
                HttpContext.Current.Session["Type"] = type;
                HttpContext.Current.Session["id"] = id;
            }
            if (status == 0)
                return email;
            else
                return status.ToString();
        }
        [WebMethod]
        public static string getaccounts(int id)
        {
            myDAL obj = new myDAL();
            return obj.getaccounts(id).GetXml();
        }
        [WebMethod]
        public static string getreviews()
        {
            myDAL obj = new myDAL();
            return obj.getreviews().GetXml();
        }
        [WebMethod]
        public static void deletereview(int rid)
        {
            if (HttpContext.Current.Session["Type"].ToString().ToLower().Equals("admin"))
            {
                myDAL obj = new myDAL();
                obj.deletereview(rid);
            }
        }
        [WebMethod]
        public static int averagerating()
        {
            myDAL obj = new myDAL();
            return obj.getaveragerating();
        }
        [WebMethod]
        public static string gethomerooms()
        {
            myDAL obj = new myDAL();
            return obj.gethomerooms().GetXml();
        }
        [WebMethod]
        public static void clearsession()
        {
            HttpContext.Current.Session.Clear();
            HttpContext.Current.Session.RemoveAll();
        }
        [WebMethod]
        public static int sendemail(string email, string domain)
        {
            try
            {
                string id = HttpContext.Current.Session["id1"].ToString();
                MailMessage o = new MailMessage("mbilal1980@hotmail.com", email, "Confirm Email", "<div><a href = " + "\"" + domain + "/Home.aspx?id=" + Encrypt(id) + "\" > Click Here To Confirm Your Email </a></div> ");
                o.IsBodyHtml = true;
                NetworkCredential netCred = new NetworkCredential("mbilal1980@hotmail.com", "QW[]14zx");
                SmtpClient smtpobj = new SmtpClient("smtp.live.com", 587);
                smtpobj.EnableSsl = true;
                smtpobj.Credentials = netCred;
                smtpobj.Send(o);
                return 1;
            }
            catch
            {
                return 0;
            }
        }
        [WebMethod]
        public static int updateaccstatus(String id)
        {
            myDAL obj = new myDAL();
            return obj.updateaccstatus(int.Parse(Decrypt(id.ToString())));
        }
        [WebMethod]
        public static int updatepass(int id, string pass)
        {
            myDAL obj = new myDAL();
            return obj.updatepass(id, pass);
        }
    }
}