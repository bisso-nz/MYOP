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
    
    public partial class ingredients
    {
        public ingredients()
        {
            this.pizza = new HashSet<pizza>();
        }
    
        public int Id { get; set; }
        public string nom { get; set; }
        public int categorie_id { get; set; }
        public int pizzeria_id { get; set; }
        public decimal prix { get; set; }
        public bool disponible { get; set; }
        public int description_id { get; set; }
    
        public virtual categorie categorie { get; set; }
        public virtual description description { get; set; }
        public virtual pizzeria pizzeria { get; set; }
        public virtual ICollection<pizza> pizza { get; set; }
    }
}
