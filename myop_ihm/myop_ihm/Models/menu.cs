//------------------------------------------------------------------------------
// <auto-generated>
//     Ce code a été généré à partir d'un modèle.
//
//     Des modifications manuelles apportées à ce fichier peuvent conduire à un comportement inattendu de votre application.
//     Les modifications manuelles apportées à ce fichier sont remplacées si le code est régénéré.
// </auto-generated>
//------------------------------------------------------------------------------

namespace myop_ihm.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class menu
    {
        public menu()
        {
            this.composition_menu = new HashSet<composition_menu>();
            this.commande = new HashSet<commande>();
        }
    
        public int Id { get; set; }
        public string nom { get; set; }
        public Nullable<decimal> prix { get; set; }
    
        public virtual ICollection<composition_menu> composition_menu { get; set; }
        public virtual ICollection<commande> commande { get; set; }
    }
}
