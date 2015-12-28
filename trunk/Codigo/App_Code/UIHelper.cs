using System;
using System.Text;
using System.Collections.Generic;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

/// <summary>
/// Summary description for UIHelper
/// </summary>
public class UIHelper
{
    public UIHelper()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    
    public static IDictionary<string, string> BindToEnum(Type enumType)
    {
        string[] names = Enum.GetNames(enumType);
        Array values = Enum.GetValues(enumType);
        IDictionary<string, string> dc = new Dictionary<string, string>();
        for (int i = 0; i < names.Length; i++)
            dc.Add(names[i], values.GetValue(i).ToString());
        return dc;
    }

    public static void Alert(Page page, Type ctype, string name, string text)
    {
        if (!page.ClientScript.IsStartupScriptRegistered(name))
        {
            StringBuilder script = new StringBuilder();

            script.Append("<script language=\"jscript\">\n");
            script.Append("   alert('"+text+"');\n");
            script.Append("</script>\n");

            System.Web.UI.ScriptManager.RegisterStartupScript(page, ctype, name, script.ToString(), false);
        }
    }

    public static void Alert(Control control, string name, string text)
    {
        if (!control.Page.ClientScript.IsStartupScriptRegistered(name))
        {
            StringBuilder script = new StringBuilder();

            script.Append("<script language=\"jscript\">\n");
            script.Append("   alert('" + text + "');\n");
            script.Append("</script>\n");

            System.Web.UI.ScriptManager.RegisterStartupScript(control, control.GetType(), name, script.ToString(), false);
        }
    }

    public static bool Confirm(Control control, HtmlInputHidden input,string name, string text)
    {
        if (!control.Page.ClientScript.IsStartupScriptRegistered(name))
        {
            StringBuilder script = new StringBuilder();

            script.Append("<script language=\"jscript\">\n");
            script.Append("document.getElementById('" + input.ClientID + "').value = confirm('"+text+"');");
            script.Append("</script>\n");

            System.Web.UI.ScriptManager.RegisterStartupScript(control, control.GetType(), name, script.ToString(), false);
        }
        return bool.Parse(input.Value);
    }

    public static void WindowReturn(Control control)
    {
        if (!control.Page.ClientScript.IsStartupScriptRegistered("script_retorno"))
        {
            StringBuilder script = new StringBuilder();

            script.Append("<script language=\"jscript\">\n");
            script.Append("   window.top.Return(true);\n");
            script.Append("</script>\n");

            //System.Web.UI.ScriptManager.RegisterStartupScript(btnAceptar, this.GetType(), "script_Confirmar", script.ToString(), false);
        }
    }

    public static void WindowLocation(Page page, Type ctype, string location)
    {
        if (!page.ClientScript.IsStartupScriptRegistered("script_PasswordOk"))
        {
            StringBuilder script = new StringBuilder();

            script.Append("<script language=\"jscript\">\n");
            script.Append("   alert('Sus datos han sido modificados correctamente.');\n");
            script.Append("   window.location = '" + location + "'");
            script.Append("</script>\n");

            page.ClientScript.RegisterStartupScript(ctype, "script_WindowLocation", script.ToString());
        }
    }
}
