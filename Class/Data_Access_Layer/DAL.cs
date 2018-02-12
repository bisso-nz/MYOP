using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MYOP_Model_DAL.Models;//a changer selon le projet 
using System.Data;

namespace MYOP_Model_DAL.Data_Access_Layer//a changer selon le projet 
{
    class DAL
    {

        private static SqlConnection _maCnx;

        #region connection
        public static Compte Connection(string nomCompte, string motDePasse)
        {
            Compte o;

            string[] contenuTableCompte;
            string[] contenuTableInfo;// tableau temporaire permetant de stocker les info de la table pizzeria,Admin,client si besoin
            string[] infocompte;//stockant la concatenation des 2 table précedante
            try
            {

                contenuTableCompte = VerificationCompte(nomCompte, motDePasse);
                contenuTableInfo = RecuperationCompte(contenuTableCompte);

                infocompte = new string[contenuTableCompte.GetLength(0) + contenuTableInfo.GetLength(0)];

                contenuTableCompte.CopyTo(infocompte, 0);
                contenuTableInfo.CopyTo(infocompte, contenuTableCompte.GetLength(0));

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

        private static string[] VerificationCompte(string nomCompte, string motDePasse)
        {
            string[] retour = new string[3];
            DataTable dt = new DataTable();
            _maCnx.Open();

            using (SqlCommand cmd = new SqlCommand("connection", _maCnx))
            {
                string typeDeCompte = "";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@nomDeCompte", nomCompte);
                cmd.Parameters.AddWithValue("@motDePasse", motDePasse);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);

                for (int i = dt.Rows[0].Table.Columns.Count - 3; i < dt.Rows[0].Table.Columns.Count; i++)//recherche du type de compte, i correspond au debut des FK
                {
                    if (dt.Rows[0][i].ToString() != "")//la cellule est "" lorsqu'elle est a null dans la BDD
                    {
                        typeDeCompte = dt.Rows[0].Table.Columns[i].ToString();// recuperation du nom de la colonne
                        typeDeCompte = typeDeCompte.Substring(0, typeDeCompte.LastIndexOf('_'));//transfo en nom de Table
                        break;
                    }
                }

                retour[0] = dt.Rows[0][0].ToString();//Id
                retour[1] = dt.Rows[0][1].ToString();//Pseudo
                retour[2] = typeDeCompte;//type de compte
            }
            _maCnx.Close();

            return retour;
        }

        private static string[] RecuperationCompte(string[] infocompte)
        {
            string[] retour;
            DataTable sdt = new DataTable();
            _maCnx.Open();
            using (SqlCommand souscmd = new SqlCommand("recuperationDeCompte", _maCnx))
            {
                souscmd.CommandType = CommandType.StoredProcedure;
                souscmd.Parameters.AddWithValue("@nomDeTable", infocompte[2]);
                souscmd.Parameters.AddWithValue("@id", int.Parse(infocompte[0]));

                SqlDataAdapter sda = new SqlDataAdapter(souscmd);
                sda.Fill(sdt);
                retour = new string[sdt.Rows[0].Table.Columns.Count];
                for (int y = 0; y < sdt.Rows[0].Table.Columns.Count; y++)// recuperation de la table contenant les infos du compte 
                {
                    retour[y] = sdt.Rows[0][y].ToString();
                }

            }
            _maCnx.Close();

            return retour;
        }
        #endregion

        #region creation de compte

        public static void CreationStandart(Compte o, string mdp)
        {
            try
            {

                _maCnx.Open();//bien mettre en dehors du using

                using (SqlCommand cmd = new SqlCommand("CreationComptePerso", _maCnx))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@nom_de_compte", SqlDbType.VarChar).Value = o.Nom_de_compte;
                    cmd.Parameters.AddWithValue("@mot_de_passe", SqlDbType.VarChar).Value = mdp;
                    cmd.Parameters.AddWithValue("@type_de_compte", SqlDbType.VarChar).Value = o.Type_de_compte;
                    cmd.Parameters.AddWithValue("@nom", SqlDbType.VarChar).Value = o.Nom;
                    cmd.Parameters.AddWithValue("@prenom", SqlDbType.VarChar).Value = o.Prenom;
                    cmd.Parameters.AddWithValue("@adresse", SqlDbType.VarChar).Value = o.Adresse;
                    cmd.Parameters.AddWithValue("@no_telephone", SqlDbType.VarChar).Value = o.No_telephone;
                    cmd.Parameters.AddWithValue("@email", SqlDbType.VarChar).Value = o.Email;
                    if (o.Nom_pizzeria == null)
                    {
                        cmd.Parameters.AddWithValue("@nom_pizzeria", SqlDbType.VarChar).Value = "NULL";
                        cmd.Parameters.AddWithValue("@adresse_pizzeria", SqlDbType.VarChar).Value = "NULL";
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@nom_pizzeria", SqlDbType.VarChar).Value = o.Nom_pizzeria;
                        cmd.Parameters.AddWithValue("@adresse_pizzeria", SqlDbType.VarChar).Value = o.Adresse_pizzeria;
                    }


                    cmd.ExecuteNonQuery();


                }
                _maCnx.Close();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex);
            }
        }


        #endregion

        #region modification de compte

        public static void ModificationStandard(Compte infoPrecedente, string mdp)
        {
            try
            {
                _maCnx.Open();//bien mettre en dehors du using


                using (SqlCommand cmd = new SqlCommand("ModificationComptePerso", _maCnx))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@id_compte", SqlDbType.VarChar).Value = infoPrecedente.Id_compte;
                    cmd.Parameters.AddWithValue("@id_contenue", SqlDbType.VarChar).Value = infoPrecedente.Id_contenue;
                    cmd.Parameters.AddWithValue("@nom_de_compte", SqlDbType.VarChar).Value = infoPrecedente.Nom_de_compte;
                    cmd.Parameters.AddWithValue("@mot_de_passe", SqlDbType.VarChar).Value = mdp;
                    cmd.Parameters.AddWithValue("@type_de_compte", SqlDbType.VarChar).Value = infoPrecedente.Type_de_compte;
                    cmd.Parameters.AddWithValue("@nom", SqlDbType.VarChar).Value = infoPrecedente.Nom;
                    cmd.Parameters.AddWithValue("@prenom", SqlDbType.VarChar).Value = infoPrecedente.Prenom;
                    cmd.Parameters.AddWithValue("@adresse", SqlDbType.VarChar).Value = infoPrecedente.Adresse;
                    cmd.Parameters.AddWithValue("@no_telephone", SqlDbType.VarChar).Value = infoPrecedente.No_telephone;
                    cmd.Parameters.AddWithValue("@email", SqlDbType.VarChar).Value = infoPrecedente.Email;
                    if (infoPrecedente.Nom_pizzeria == null)
                    {
                        cmd.Parameters.AddWithValue("@nom_pizzeria", SqlDbType.VarChar).Value = "NULL";
                        cmd.Parameters.AddWithValue("@adresse_pizzeria", SqlDbType.VarChar).Value = "NULL";
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@nom_pizzeria", SqlDbType.VarChar).Value = infoPrecedente.Nom_pizzeria;
                        cmd.Parameters.AddWithValue("@adresse_pizzeria", SqlDbType.VarChar).Value = infoPrecedente.Adresse_pizzeria;
                    }
                    cmd.ExecuteNonQuery();
                }
                _maCnx.Close();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex);
            }

          }

        #endregion

        #region suppression

        #endregion 

        static DAL()
        {
            string chaineCnx = ConfigurationManager.ConnectionStrings["getconn"].ToString();
            _maCnx = new SqlConnection(chaineCnx);
        }

    }
}
