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
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                int roomid = Convert.ToInt32(Session["id"].ToString());
                Response.Redirect("Home.aspx");
            }
            catch
            {

            }

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
        public static int register(string firstname, string lastname, string username, string email, string pass, string dob, string cellno, string type, int status, string picture, int accid, string domain)
        {
            myDAL obj = new myDAL();
            int id = obj.register(firstname, lastname, username, email, pass, dob, cellno, type, status, picture, accid);
            if (id == 0)
                return id;
            if (status == 0)
            {
                MailMessage o = new MailMessage("mbilal1980@hotmail.com", email, "Confirm Email", "<div><a href = " + "\"" + domain + "/Home.aspx?id=" + Encrypt(id.ToString()) + "\" > Click Here To Confirm Your Email </a></div> ");
                o.IsBodyHtml = true;
                NetworkCredential netCred = new NetworkCredential("mbilal1980@hotmail.com", "QW[]14zx");
                SmtpClient smtpobj = new SmtpClient("smtp.live.com", 587);
                smtpobj.EnableSsl = true;
                smtpobj.Credentials = netCred;
                smtpobj.Send(o);
            }
            return id;
        }
    }
}