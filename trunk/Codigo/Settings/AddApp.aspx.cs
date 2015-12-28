using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using facebook.Schema;
using facebook.web;

namespace FacebookApp
{
	public partial class Add : System.Web.UI.Page
	{
        public facebook.API API
        {
            get { return ((CanvasIFrameMasterPage)Master).API; }
        }

		protected void Page_Load(object sender, EventArgs e)
		{
            DBKeeper.getInstance().NuevoUsuario(API.uid);
		}
	}
}