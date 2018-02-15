using myop_ihm.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace myop_ihm.Controllers
{
    public class HomeController : Controller
    {
        MYOPEntities db = new MYOPEntities();
        //
        // GET: /Home/
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Presentation()
        {
            return View();
        }

        public ActionResult Clients()
        {
            return View();
        }

        public ActionResult Pricing()
        {
            return View();
        }

        public ActionResult Faq()
        {
            return View();
        }

        public ActionResult Contact()
        {
            return View();
        }

        public ActionResult Connexion()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Connexion(string txtNomCompte, string txtMdp)
        {


            try
            {
                var o = db.compte.FirstOrDefault(u => u.nom_de_compte == txtNomCompte && u.mot_de_passe == txtMdp);
                ViewBag.ErrorConn = "";
                Session["Compte"] = o;
                return Content("OK");

            }

            catch
            {
                ViewBag.ErrorConn = "Nom de compte et/ou mot de passe incorrect !";
                return View();
            }




        }

        public ActionResult Inscription()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Inscription(compte nouveau)
        {
            try
            {
                ViewBag.error = "";
                if (nouveau.client.adresse == "" || nouveau.client.adresse == null)
                    nouveau.client = null;
                if (nouveau.pizzeria.adresse == "" || nouveau.pizzeria.adresse == null)
                    nouveau.pizzeria = null;
                if (nouveau.client.adresse != null && nouveau.pizzeria.adresse != null)
                {
                    ViewBag.error = "ce que tu veux";
                    return View();
                }
                db.compte.Add(nouveau);
                db.SaveChanges();
                return Content("Bonjour " + nouveau.nom_de_compte);

            }
            catch
            {
                return View();
            }

        }

        public ActionResult Inscriptiontest()
        {
            return View();
        }


    }
}