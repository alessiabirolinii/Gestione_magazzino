using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace gestione_magazzino.Pages.prodotti
{
    public class loginModel : PageModel
    {
        static public string URL = "https://gestionemagazzino.pythonanywhere.com/";
        public class User
        {          
            public string password { get; set; }

            public string email { get; set; }
        }

        public void OnPost( string Password, string Email)
        {
            var httpWebRequest = (HttpWebRequest)WebRequest.Create(URL + "login");
            httpWebRequest.ContentType = "application/json";
            httpWebRequest.Method = "POST";

            using (var streamWriter = new StreamWriter(httpWebRequest.GetRequestStream()))
            {
                string json = JsonConvert.SerializeObject(new User()
                {                  
                    password = Password,
                    email = Email
                });

                streamWriter.Write(json);
            }
            try
            {
                var httpResponse = (HttpWebResponse)httpWebRequest.GetResponseAsync().Result;
                using (var streamReader = new StreamReader(httpResponse.GetResponseStream()))
                {
                    var result = streamReader.ReadToEnd();
                    Class.token = JObject.Parse(result)["access_token"].ToString();
                }
            }
            catch (Exception)
            {

            }
            
        }
    }
}
