﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;

namespace myop_ihm.Models
{
    public class Compte
    {
        //contenue de la table compte
        private string _id_compte;
        private string _nom_de_compte;
        private string _type_de_compte;

        //contenue des info lier au compte dans les autres table
        private string _id_contenue;
        private string _nom; // nom du proprietaire
        private string _prenom;
        private string _adresse;
        private string _no_telephone;
        private string _email;
        private string _nom_pizzeria;// nom de la propriete
        private string _adresse_pizzeria;


        #region Encapsulation

        public string Id_compte
        {
            get { return _id_compte; }
            set { _id_compte = value; }
        }
        [Required]
        [RegularExpression(@"^[a-zA-Z0-9_-]{1,25}$",
         ErrorMessage = "Characters are not allowed.")]
        public string Nom_de_compte
        {
            get { return _nom_de_compte; }
            set { _nom_de_compte = value; }
        }

        public string Type_de_compte
        {
            get { return _type_de_compte; }
            set { _type_de_compte = value; }
        }

        public string Id_contenue
        {
            get { return _id_contenue; }
            set { _id_contenue = value; }
        }
        [Required]
        [RegularExpression(@"^[a-zA-Z -]{1,25}$",
         ErrorMessage = "Characters are not allowed.")]
        public string Nom
        {
            get { return _nom; }
            set { _nom = value; }
        }
        [Required]
        [RegularExpression(@"^[a-zA-Z -]{1,25}$",
         ErrorMessage = "Characters are not allowed.")]
        public string Prenom
        {
            get { return _prenom; }
            set { _prenom = value; }
        }
        [Required]
        [RegularExpression(@"^[a-zA-Z0-9, -]{1,100}$",
         ErrorMessage = "Characters are not allowed.")]
        public string Adresse
        {
            get { return _adresse; }
            set { _adresse = value; }
        }
        [Phone]
        public string No_telephone
        {
            get { return _no_telephone; }
            set { _no_telephone = value; }
        }
        [Required]
        [EmailAddress]
        public string Email
        {
            get { return _email; }
            set { _email = value; }
        }
        [RegularExpression(@"^[a-zA-Z -]{1,25}$",
         ErrorMessage = "Characters are not allowed.")]
        public string Nom_pizzeria
        {
            get { return _nom_pizzeria; }
            set { _nom_pizzeria = value; }
        }
        [RegularExpression(@"^[a-zA-Z -]{1,25}$",
         ErrorMessage = "Characters are not allowed.")]
        public string Adresse_pizzeria
        {
            get { return _adresse_pizzeria; }
            set { _adresse_pizzeria = value; }
        }

        #endregion


        /// <summary>
        /// constructeur par default non utiliser
        /// </summary>
        public Compte()
        {

        }
        /// <param name="list">id du compte, nom du compte, type de compte, id de la table cible, nom, prenom, adresse, 
        /// n° de telephone, email, nom de la pizzeria, adresse de la pizzeria</param>
        public Compte(params string[] list)
        {
            Id_compte = list[0];
            Nom_de_compte = list[1];
            Type_de_compte = list[2];
            Id_contenue = list[3];
            Nom = list[4];
            Prenom = list[5];
            Adresse = list[6];
            No_telephone = list[7];
            Email = list[8];
            if (9 > list.Length)
            {
                Nom_pizzeria = list[9];
                Adresse_pizzeria = list[10];
            }
        }
    }


}
