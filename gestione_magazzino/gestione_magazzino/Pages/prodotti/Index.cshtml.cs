using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Net.Mime;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;


namespace gestione_magazzino.Pages.prodotti
{
    public class IndexModel : PageModel
    {
        static public string URL = "https://gestionemagazzino.pythonanywhere.com/";
        public class User
        {
            public string index { get; set; }

            public string amount { get; set; }
        }
        public class Prodotto
        {
            public string nome { get; set; }
            public string quantita { get; set; }
            public string prezzo { get; set; }
            public string categoria { get; set; }
            public string magazzino { get; set; }
            public string data { get; set; }
            public string id { get; set; }
        }
        public List<Prodotto> eleProdotto { get; set; }

        public void OnGet()
        {
            HttpClient client = new HttpClient();
            client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", Class.token);

            var result = client.GetStringAsync(URL + "prodotto");

            var json = JsonConvert.SerializeObject(new User()
            {
                index = "0",
                amount="100"
            }) ;
            var request = new HttpRequestMessage
            {
                Method = HttpMethod.Get,
                RequestUri = new Uri(URL + "prodotto"),
                Content = new StringContent(json, Encoding.UTF8, MediaTypeNames.Application.Json)
            };

            HttpResponseMessage response = client.Send(request);

            Task<string> responseBody = response.Content.ReadAsStringAsync();
            var response2 = JsonConvert.DeserializeObject<List<Prodotto>>(JObject.Parse(responseBody.Result)["prodotti"].ToString());
            eleProdotto = response2;
        }
    }
}
