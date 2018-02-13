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

            Compte o;

            try
            {

                    o = DAL.DAL.Connection(txtNomCompte, txtMdp);
            }

            catch
            {
                ViewBag.ErrorConn = "Nom de compte et/ou mot de passe incorrect !";
                return View();
            }

            ViewBag.ErrorConn = "";
            Session["Compte"] = o;

            return Content("OK");

        }

        public ActionResult Inscription()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Inscription(Compte nouveau, string txtMdp)
        {
            nouveau.Type_de_compte = "pizzeria";
            nouveau.Id_compte = nouveau.Id_contenue = "0";

            try
            {

                DAL.DAL.CreationStandard(nouveau, txtMdp);
            }
            catch
            {
                return Content("aïe ! ");
            }

            Session["Compte"] = nouveau;

            Compte o;

            try
            {

                o = DAL.DAL.Connection(nouveau.Nom_de_compte, txtMdp);
            }

            catch
            {
                return View();
            }

            return Content("Bonjour " + nouveau.Nom_de_compte);
        }

    }
}