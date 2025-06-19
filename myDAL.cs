using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace WebApplication7
{
    public class myDAL
    {
        private static readonly string connString =
            System.Configuration.ConfigurationManager.ConnectionStrings["sqlCon1"].ConnectionString;
        SqlDataAdapter da;
        public int register(string firstname, string lastname, string username, string email, string pass, string dob, string cellno, string type, int status, string picture, int accid)
        {
            int result = 0;
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd;
            try
            {
                cmd = new SqlCommand("register", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@firstname", SqlDbType.VarChar).Value = firstname;
                cmd.Parameters.Add("@lastname", SqlDbType.VarChar).Value = lastname;
                cmd.Parameters.Add("@username", SqlDbType.VarChar).Value = username;
                cmd.Parameters.Add("@email", SqlDbType.VarChar).Value = email;
                cmd.Parameters.Add("@pass", SqlDbType.VarChar).Value = pass;
                cmd.Parameters.Add("@dob", SqlDbType.VarChar).Value = dob;
                cmd.Parameters.Add("@cellno", SqlDbType.VarChar).Value = cellno;
                cmd.Parameters.Add("@type", SqlDbType.VarChar).Value = type;
                cmd.Parameters.Add("@status", SqlDbType.Int).Value = status;
                cmd.Parameters.Add("@picture", SqlDbType.VarChar).Value = picture;
                cmd.Parameters.Add("@accid", SqlDbType.Int).Value = accid;
                cmd.Parameters.Add("@out", SqlDbType.Int).Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();
                result = Convert.ToInt32(cmd.Parameters["@out"].Value);
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }
            return result;
        }
        public int addroom(string price, string descp, string type, string name)
        {
            int result = 0;
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd;
            try
            {

                cmd = new SqlCommand("insertroom", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@type", SqlDbType.VarChar).Value = type;
                cmd.Parameters.Add("@descp", SqlDbType.VarChar).Value = descp;
                cmd.Parameters.Add("@price", SqlDbType.VarChar).Value = price;
                cmd.Parameters.Add("@name", SqlDbType.VarChar).Value = name;
                cmd.Parameters.Add("@out", SqlDbType.Int).Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();
                result = Convert.ToInt32(cmd.Parameters["@out"].Value);
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }
            return result;
        }
        public int getaveragerating()
        {
            int result = 0;
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd;
            try
            {
                cmd = new SqlCommand("averagerating", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@out", SqlDbType.Int).Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();
                result = Convert.ToInt32(cmd.Parameters["@out"].Value);
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }
            return result;
        }
        public int addreview(string name, string email, string cno, string comment, int rating)
        {
            int result = 0;
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd;
            try
            {
                cmd = new SqlCommand("insertreview", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@name", SqlDbType.VarChar).Value = name;
                cmd.Parameters.Add("@email", SqlDbType.VarChar).Value = email;
                cmd.Parameters.Add("@cno", SqlDbType.VarChar).Value = cno;
                cmd.Parameters.Add("@comment", SqlDbType.VarChar).Value = comment;
                cmd.Parameters.Add("@rating", SqlDbType.Int).Value = rating; ;
                result = cmd.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }
            return result;
        }
        public int updatepass(int id, string pass)
        {
            int result = 0;
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd;
            try
            {

                cmd = new SqlCommand("updatepass", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@pass", SqlDbType.VarChar).Value = pass;
                cmd.Parameters.Add("@accid", SqlDbType.Int).Value = id;
                result = cmd.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }
            return result;
        }
        public int bookaroom(string name, string email, string phone, string checkin, string checkout, string comment, int roomid)
        {
            int result = 0;
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd;
            try
            {

                cmd = new SqlCommand("bookaroom", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@name", SqlDbType.VarChar).Value = name;
                cmd.Parameters.Add("@email", SqlDbType.VarChar).Value = email;
                cmd.Parameters.Add("@phone", SqlDbType.VarChar).Value = phone;
                cmd.Parameters.Add("@checkin", SqlDbType.VarChar).Value = checkin;
                cmd.Parameters.Add("@checkout", SqlDbType.VarChar).Value = checkout;
                cmd.Parameters.Add("@comment", SqlDbType.VarChar).Value = comment;
                cmd.Parameters.Add("@roomid", SqlDbType.Int).Value = roomid;
                result = cmd.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }
            return result;
        }
        public int loginto(string username, string pass, ref int id, ref string type, ref int status, ref string email)
        {
            int result = 0;
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd;
            try
            {
                cmd = new SqlCommand("logino", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@username", SqlDbType.VarChar).Value = username;
                cmd.Parameters.Add("@pass", SqlDbType.VarChar).Value = pass;
                cmd.Parameters.Add("@out", SqlDbType.Int).Direction = ParameterDirection.Output;
                cmd.Parameters.Add("@id", SqlDbType.Int).Direction = ParameterDirection.Output;
                cmd.Parameters.Add("@status", SqlDbType.Int).Direction = ParameterDirection.Output;
                cmd.Parameters.Add("@type", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
                cmd.Parameters.Add("@email", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();
                result = Convert.ToInt32(cmd.Parameters["@out"].Value);
                id = Convert.ToInt32(cmd.Parameters["@id"].Value);
                type = Convert.ToString(cmd.Parameters["@type"].Value);
                email = Convert.ToString(cmd.Parameters["@email"].Value);
                status = Convert.ToInt32(cmd.Parameters["@status"].Value);
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }
            return result;
        }
        public int addfeatures(string feature, int id)
        {
            int result = 0;
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd;
            try
            {

                cmd = new SqlCommand("insertfeatures", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@feature", SqlDbType.VarChar).Value = feature;
                cmd.Parameters.Add("@id", SqlDbType.Int).Value = id;
                result = cmd.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }
            return result;
        }
        public int updateaccstatus(int id)
        {
            int result = 0;
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd;
            try
            {

                cmd = new SqlCommand("updateaccstatus", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@id", SqlDbType.Int).Value = id;
                result = cmd.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }
            return result;
        }
        public int addpics(string pics, int id)
        {
            int result = 0;
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd;
            try
            {

                cmd = new SqlCommand("insertphotos", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@photo", SqlDbType.VarChar).Value = pics;
                cmd.Parameters.Add("@id", SqlDbType.Int).Value = id;
                result = cmd.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }
            return result;
        }
        public int updatedescription(int id, string description)
        {
            int result = 0;
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd;
            try
            {

                cmd = new SqlCommand("updatedescription", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@rid", SqlDbType.Int).Value = id;
                cmd.Parameters.Add("@descp", SqlDbType.VarChar).Value = description;
                result = cmd.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }
            return result;
        }
        public int updatefeature(int id, string feature)
        {
            int result = 0;
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd;
            try
            {

                cmd = new SqlCommand("updatefeature", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@fid", SqlDbType.Int).Value = id;
                cmd.Parameters.Add("@feature", SqlDbType.VarChar).Value = feature;
                result = cmd.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }
            return result;
        }
        public int updateprice(int id, string price)
        {
            int result = 0;
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd;
            try
            {

                cmd = new SqlCommand("updateprice", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@rid", SqlDbType.Int).Value = id;
                cmd.Parameters.Add("@price", SqlDbType.VarChar).Value = price;
                result = cmd.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }
            return result;
        }
        public int updatepicture(int id, string picture)
        {
            int result = 0;
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd;
            try
            {

                cmd = new SqlCommand("updatepicture", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@picid", SqlDbType.Int).Value = id;
                cmd.Parameters.Add("@picture", SqlDbType.VarChar).Value = picture;
                result = cmd.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }
            return result;
        }
        public int deleteroom(int rid)
        {

            int result = 0;
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd;
            try
            {

                cmd = new SqlCommand("deleteroom", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@rid", SqlDbType.Int).Value = rid;
                result = cmd.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }
            return result;
        }
        public int deletefeature(int fid)
        {

            int result = 0;
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd;
            try
            {

                cmd = new SqlCommand("deletefeature", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@fid", SqlDbType.Int).Value = fid;
                result = cmd.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }
            return result;
        }
        public int deletepicture(int fid)
        {

            int result = 0;
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd;
            try
            {

                cmd = new SqlCommand("deletepicture", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@picid", SqlDbType.Int).Value = fid;
                result = cmd.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }
            return result;
        }
        public int deleteuser(int accid)
        {
            int result = 0;
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd;
            try
            {
                cmd = new SqlCommand("deleteuser", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@accid", SqlDbType.Int).Value = accid;
                result = cmd.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }
            return result;
        }
        public int deletereview(int rid)
        {
            int result = 0;
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd;
            try
            {
                cmd = new SqlCommand("deletereview", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@rid", SqlDbType.Int).Value = rid;
                result = cmd.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }
            return result;
        }
        public int cancelbooking(int bookid, int accid)
        {
            int result = 0;
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd;
            try
            {
                cmd = new SqlCommand("cancelbooking", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@bookid", SqlDbType.Int).Value = bookid;
                cmd.Parameters.Add("@accid", SqlDbType.Int).Value = accid;
                cmd.Parameters.Add("@out", SqlDbType.Int).Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();
                result = Convert.ToInt32(cmd.Parameters["@out"].Value.ToString());
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }
            return result;
        }
        public int updateavailiability(int rid, string status)
        {

            int result = 0;
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd;
            try
            {

                cmd = new SqlCommand("updateavailability", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@rid", SqlDbType.Int).Value = rid;
                cmd.Parameters.Add("@status", SqlDbType.VarChar).Value = status;
                result = cmd.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }
            return result;
        }
        public DataSet getrooms(string status, int start, int end, string type, string checkin, string checkout)
        {
            DataSet a = new DataSet();
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd;
            try
            {

                cmd = new SqlCommand("getrooms", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@status", SqlDbType.VarChar).Value = status;
                cmd.Parameters.Add("@type", SqlDbType.VarChar).Value = type;
                cmd.Parameters.Add("@checkin", SqlDbType.Date).Value = checkin;
                cmd.Parameters.Add("@checkout", SqlDbType.Date).Value = checkout;
                cmd.Parameters.Add("@start", SqlDbType.Int).Value = start;
                cmd.Parameters.Add("@end", SqlDbType.Int).Value = end;
                cmd.ExecuteNonQuery();
                da = new SqlDataAdapter(cmd);
                da.Fill(a);
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }
            return a;
        }
        public DataSet gethomerooms()
        {
            DataSet a = new DataSet();
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd;
            try
            {

                cmd = new SqlCommand("homerooms", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.ExecuteNonQuery();
                da = new SqlDataAdapter(cmd);
                da.Fill(a);
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }
            return a;
        }
        public DataSet singleroom(int id)
        {
            DataSet a = new DataSet();
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd;
            try
            {

                cmd = new SqlCommand("singleroom", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@roomid", SqlDbType.Int).Value = id;
                cmd.ExecuteNonQuery();
                da = new SqlDataAdapter(cmd);
                da.Fill(a);
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }
            return a;
        }
        public DataSet getbookings(int id)
        {
            DataSet a = new DataSet();
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd;
            try
            {
                cmd = new SqlCommand("getbookings", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@id", SqlDbType.Int).Value = id;
                cmd.ExecuteNonQuery();
                da = new SqlDataAdapter(cmd);
                da.Fill(a);
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }
            return a;
        }
        public DataSet dateadjust(int id)
        {
            DataSet a = new DataSet();
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd;
            try
            {

                cmd = new SqlCommand("dateadjust", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@roomid", SqlDbType.Int).Value = id;
                cmd.ExecuteNonQuery();
                da = new SqlDataAdapter(cmd);
                da.Fill(a);
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }
            return a;
        }
        public DataSet singlepics(int id)
        {
            DataSet a = new DataSet();
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd;
            try
            {

                cmd = new SqlCommand("singlepics", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@roomid", SqlDbType.Int).Value = id;
                cmd.ExecuteNonQuery();
                da = new SqlDataAdapter(cmd);
                da.Fill(a);
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }
            return a;
        }
        public DataSet singlefeatures(int id)
        {
            DataSet a = new DataSet();
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd;
            try
            {

                cmd = new SqlCommand("singlefeatures", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@roomid", SqlDbType.Int).Value = id;
                cmd.ExecuteNonQuery();
                da = new SqlDataAdapter(cmd);
                da.Fill(a);
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }
            return a;
        }
        public DataSet adjacentrooms(int id)
        {
            DataSet a = new DataSet();
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd;
            try
            {

                cmd = new SqlCommand("adjacentrooms", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@roomid", SqlDbType.Int).Value = id;
                cmd.ExecuteNonQuery();
                da = new SqlDataAdapter(cmd);
                da.Fill(a);
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }
            return a;
        }
        public DataSet getaccounts(int id)
        {
            DataSet a = new DataSet();
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd;
            try
            {

                cmd = new SqlCommand("getaccountsinfo", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@id", SqlDbType.Int).Value = id;
                cmd.ExecuteNonQuery();
                da = new SqlDataAdapter(cmd);
                da.Fill(a);
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }
            return a;
        }
        public DataSet getaccounts()
        {
            DataSet a = new DataSet();
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd;
            try
            {
                cmd = new SqlCommand("getaccounts", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.ExecuteNonQuery();
                da = new SqlDataAdapter(cmd);
                da.Fill(a);
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }
            return a;
        }
        public DataSet getreviews()
        {
            DataSet a = new DataSet();
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd;
            try
            {
                cmd = new SqlCommand("getreviews", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.ExecuteNonQuery();
                da = new SqlDataAdapter(cmd);
                da.Fill(a);
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }
            return a;
        }
    }
}