using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using facebook.Schema;
using facebook.web;

public partial class AsociarCuenta : System.Web.UI.Page
{
    public facebook.API API
    {
        get { return ((CanvasIFrameMasterPage)Master).API; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            
        }
    }

    public void btnConfirmar_Click(object sender, EventArgs e)
    {
        if (DBKeeper.getInstance().AsociarCuenta(API.uid, txtUser.Text, txtPass.Text) < 0)
            UIHelper.Alert(this, "Usuario inválido", "Las credenciales de eWeddings ingresadas son inválidas");
        else
        {
            UIHelper.Alert(this, "Asociación exitosa!!", "La asociación de su usuario de facebook con su usuario de eWeddings ha resultado exitosa!!");
            //UIHelper.WindowLocation(this, this.GetType(), "PantallaPrincipal.aspx");
            Response.Redirect("PantallaPrincipal.aspx");
        }
    }

    public void btnCancelar_Click(object sender, EventArgs e)
    {
        Response.Redirect("PantallaPrincipal.aspx");
    }
}
