using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MYOP_Model_DAL.Models;
using System.Data; //a changer selon le projet 

namespace MYOP_Model_DAL.Data_Access_Layer
{
    class DAL
    {

        private static SqlConnection _maCnx;

        public static Compte Connection(string nomCompte, string motDePasse)
        {
            //SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\v11.0;AttachDbFilename=|DataDirectory|App_Data\Database.mdf;Integrated Security=True");
            Compte o;
            DataTable dt = new DataTable();
            DataTable sdt = new DataTable();
            int idFK = 0;
            string typeDeCompte = "";
            string nomDeCompte = "";
            string[] infocompte = new string[11];
            try
            {
                using (SqlCommand cmd = new SqlCommand("connection", _maCnx))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@nomDeCompte", nomCompte);
                    cmd.Parameters.AddWithValue("@motDePasse", motDePasse);
                    _maCnx.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                    _maCnx.Close();

                    /*
                    for (int i = 0; i < ds.Rows[0].Table.Columns.Count; i++)
                    {
                        Console.Write(ds.Rows[0].Table.Columns[i] + " ");//nom des colonne
                    }
                    Console.WriteLine();*/

                    for (int i = 3; i < dt.Rows[0].Table.Columns.Count; i++)
                    {
                        if (dt.Rows[0][i].ToString() != "")
                        {
                            Console.Write(dt.Rows[0][i] + " ");
                            typeDeCompte = dt.Rows[0].Table.Columns[i].ToString();
                            typeDeCompte = typeDeCompte.Substring(0, typeDeCompte.LastIndexOf('_'));
                            idFK = int.Parse(dt.Rows[0][i].ToString());

                            break;
                        }

                        else
                            Console.Write("NULL ");
                    }

                    infocompte[0] = dt.Rows[0][0].ToString();
                    infocompte[1] = dt.Rows[0][1].ToString();
                    infocompte[2] = typeDeCompte;
                }
                

                using (SqlCommand souscmd = new SqlCommand("recuperationDeCompte", _maCnx))
                {
                    souscmd.CommandType = CommandType.StoredProcedure;
                    souscmd.Parameters.AddWithValue("@nomDeTable", typeDeCompte);
                    souscmd.Parameters.AddWithValue("@id", idFK);
                    Console.WriteLine(typeDeCompte + " " + idFK);
                    _maCnx.Open();
                    SqlDataAdapter sda = new SqlDataAdapter(souscmd);
                    sda.Fill(sdt);
                    _maCnx.Close();
                    
                    for (int y = 0; y < sdt.Rows[0].Table.Columns.Count; y++)
                    {
                        if (sdt.Rows[0][y].ToString() != "")
                            Console.Write(sdt.Rows[0][y] + " ");
                        infocompte[y + 3] = sdt.Rows[0][y].ToString();
                    }

                }
                o = new Compte(infocompte);
                
            }
            catch (Exception ex)
            {
                _maCnx.Close();
                throw new IndexOutOfRangeException();
                // Gérer les erreurs ici.                
            }
            return o;

        }


        static DAL()
        {
            string chaineCnx = ConfigurationManager.ConnectionStrings["getconn"].ToString();
            _maCnx = new SqlConnection(chaineCnx);
        }

    }
}
