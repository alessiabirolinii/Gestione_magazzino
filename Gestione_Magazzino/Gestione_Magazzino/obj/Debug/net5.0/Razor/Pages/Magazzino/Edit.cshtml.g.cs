#pragma checksum "C:\Users\birolini.17464\Documents\GitHub\Gestione_magazzino\Gestione_Magazzino\Gestione_Magazzino\Pages\Magazzino\Edit.cshtml" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "74109f76fc6c01f7ddee2b05de9891115456319e"
// <auto-generated/>
#pragma warning disable 1591
[assembly: global::Microsoft.AspNetCore.Razor.Hosting.RazorCompiledItemAttribute(typeof(Gestione_Magazzino.Pages.Magazzino.Pages_Magazzino_Edit), @"mvc.1.0.razor-page", @"/Pages/Magazzino/Edit.cshtml")]
namespace Gestione_Magazzino.Pages.Magazzino
{
    #line hidden
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Threading.Tasks;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.AspNetCore.Mvc.Rendering;
    using Microsoft.AspNetCore.Mvc.ViewFeatures;
#nullable restore
#line 1 "C:\Users\birolini.17464\Documents\GitHub\Gestione_magazzino\Gestione_Magazzino\Gestione_Magazzino\Pages\_ViewImports.cshtml"
using Microsoft.AspNetCore.Identity;

#line default
#line hidden
#nullable disable
#nullable restore
#line 2 "C:\Users\birolini.17464\Documents\GitHub\Gestione_magazzino\Gestione_Magazzino\Gestione_Magazzino\Pages\_ViewImports.cshtml"
using Gestione_Magazzino;

#line default
#line hidden
#nullable disable
#nullable restore
#line 3 "C:\Users\birolini.17464\Documents\GitHub\Gestione_magazzino\Gestione_Magazzino\Gestione_Magazzino\Pages\_ViewImports.cshtml"
using Gestione_Magazzino.Data;

#line default
#line hidden
#nullable disable
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"74109f76fc6c01f7ddee2b05de9891115456319e", @"/Pages/Magazzino/Edit.cshtml")]
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"ab2c420c79956f5f70f1187e88914c52965c0c05", @"/Pages/_ViewImports.cshtml")]
    public class Pages_Magazzino_Edit : global::Microsoft.AspNetCore.Mvc.RazorPages.Page
    {
        private static readonly global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute __tagHelperAttribute_0 = new global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute("method", "post", global::Microsoft.AspNetCore.Razor.TagHelpers.HtmlAttributeValueStyle.DoubleQuotes);
        #line hidden
        #pragma warning disable 0649
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperExecutionContext __tagHelperExecutionContext;
        #pragma warning restore 0649
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperRunner __tagHelperRunner = new global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperRunner();
        #pragma warning disable 0169
        private string __tagHelperStringValueBuffer;
        #pragma warning restore 0169
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperScopeManager __backed__tagHelperScopeManager = null;
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperScopeManager __tagHelperScopeManager
        {
            get
            {
                if (__backed__tagHelperScopeManager == null)
                {
                    __backed__tagHelperScopeManager = new global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperScopeManager(StartTagHelperWritingScope, EndTagHelperWritingScope);
                }
                return __backed__tagHelperScopeManager;
            }
        }
        private global::Microsoft.AspNetCore.Mvc.TagHelpers.FormTagHelper __Microsoft_AspNetCore_Mvc_TagHelpers_FormTagHelper;
        private global::Microsoft.AspNetCore.Mvc.TagHelpers.RenderAtEndOfFormTagHelper __Microsoft_AspNetCore_Mvc_TagHelpers_RenderAtEndOfFormTagHelper;
        #pragma warning disable 1998
        public async override global::System.Threading.Tasks.Task ExecuteAsync()
        {
            WriteLiteral("<h1>Modifica</h1>\r\n<p></p>\r\n ");
            __tagHelperExecutionContext = __tagHelperScopeManager.Begin("form", global::Microsoft.AspNetCore.Razor.TagHelpers.TagMode.StartTagAndEndTag, "74109f76fc6c01f7ddee2b05de9891115456319e3988", async() => {
                WriteLiteral("\r\n      <div class=\"card\" style=\"width: 18rem; margin-left:1rem\">\r\n           <div class=\"card-body\">\r\n                  <h5 class=\"card-title\">ID: ");
#nullable restore
#line 10 "C:\Users\birolini.17464\Documents\GitHub\Gestione_magazzino\Gestione_Magazzino\Gestione_Magazzino\Pages\Magazzino\Edit.cshtml"
                                        Write(Model.mag.codice);

#line default
#line hidden
#nullable disable
                WriteLiteral("</h5>\r\n                  <h5 class=\"card-title\">Nome: ");
#nullable restore
#line 11 "C:\Users\birolini.17464\Documents\GitHub\Gestione_magazzino\Gestione_Magazzino\Gestione_Magazzino\Pages\Magazzino\Edit.cshtml"
                                          Write(Model.mag.nome);

#line default
#line hidden
#nullable disable
                WriteLiteral("</h5>\r\n                  <h5 class=\"card-title\">Numero Referente: ");
#nullable restore
#line 12 "C:\Users\birolini.17464\Documents\GitHub\Gestione_magazzino\Gestione_Magazzino\Gestione_Magazzino\Pages\Magazzino\Edit.cshtml"
                                                      Write(Model.mag.numero_referente);

#line default
#line hidden
#nullable disable
                WriteLiteral("</h5>\r\n                  <h5 class=\"card-title\">Indirizzo: ");
#nullable restore
#line 13 "C:\Users\birolini.17464\Documents\GitHub\Gestione_magazzino\Gestione_Magazzino\Gestione_Magazzino\Pages\Magazzino\Edit.cshtml"
                                               Write(Model.mag.indirizzo);

#line default
#line hidden
#nullable disable
                WriteLiteral("</h5>\r\n           </div>\r\n        <button type=\"submit\">Modifica</button>\r\n    </div>\r\n");
            }
            );
            __Microsoft_AspNetCore_Mvc_TagHelpers_FormTagHelper = CreateTagHelper<global::Microsoft.AspNetCore.Mvc.TagHelpers.FormTagHelper>();
            __tagHelperExecutionContext.Add(__Microsoft_AspNetCore_Mvc_TagHelpers_FormTagHelper);
            __Microsoft_AspNetCore_Mvc_TagHelpers_RenderAtEndOfFormTagHelper = CreateTagHelper<global::Microsoft.AspNetCore.Mvc.TagHelpers.RenderAtEndOfFormTagHelper>();
            __tagHelperExecutionContext.Add(__Microsoft_AspNetCore_Mvc_TagHelpers_RenderAtEndOfFormTagHelper);
            __Microsoft_AspNetCore_Mvc_TagHelpers_FormTagHelper.Method = (string)__tagHelperAttribute_0.Value;
            __tagHelperExecutionContext.AddTagHelperAttribute(__tagHelperAttribute_0);
            await __tagHelperRunner.RunAsync(__tagHelperExecutionContext);
            if (!__tagHelperExecutionContext.Output.IsContentModified)
            {
                await __tagHelperExecutionContext.SetOutputContentAsync();
            }
            Write(__tagHelperExecutionContext.Output);
            __tagHelperExecutionContext = __tagHelperScopeManager.End();
        }
        #pragma warning restore 1998
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.ViewFeatures.IModelExpressionProvider ModelExpressionProvider { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.IUrlHelper Url { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.IViewComponentHelper Component { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.Rendering.IJsonHelper Json { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.Rendering.IHtmlHelper<Gestione_Magazzino.Pages.Magazzino.EditModel> Html { get; private set; }
        public global::Microsoft.AspNetCore.Mvc.ViewFeatures.ViewDataDictionary<Gestione_Magazzino.Pages.Magazzino.EditModel> ViewData => (global::Microsoft.AspNetCore.Mvc.ViewFeatures.ViewDataDictionary<Gestione_Magazzino.Pages.Magazzino.EditModel>)PageContext?.ViewData;
        public Gestione_Magazzino.Pages.Magazzino.EditModel Model => ViewData.Model;
    }
}
#pragma warning restore 1591