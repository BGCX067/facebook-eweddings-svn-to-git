using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using facebook.Schema;
using facebook.web;

public partial class Regalos : System.Web.UI.Page
{
    private IList<user> amigos;
    private IDictionary<long, user> amigosConId;

    public facebook.API API
    {
        get { return ((CanvasIFrameMasterPage)Master).API; }
    }

    public user AmigoARegalar
    {
        get { return (user)Session["friend"]; }
        set { Session["friend"] = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        ResetearInfo();
    }

    private void ResetearInfo()
    {
        lblNotifCarrito.Visible = false;
        CargarGrilla();

        if (DBKeeper.getInstance().EstaAsociado(API.uid))
            lbAsociarCuenta.Visible = false;
        else
            lbAsociarCuenta.Visible = true;

        lblTitle.Text = String.Format("Regalos disponibles para tu amigo/a {0}", AmigoARegalar.first_name);

        IList<Regalo> regalos = DBKeeper.getInstance().ObtenerRegalosReservados((int)API.uid, (int)AmigoARegalar.uid);

        if (regalos.Count > 0)
        {
            lblNotifCarrito.Text = String.Format("ACTUALMENTE TENES {0} ITEMS EN TU CARRITO DE COMPRAS PARA REGALARLE A {1}", regalos.Count, AmigoARegalar.first_name);
            lblNotifCarrito.Visible = true;
        }
    }

    private void CargarGrilla()
    {
        gvRegalosDisponibles.DataSource = DBKeeper.getInstance().ObtenerRegalosUsuario(Convert.ToInt32(AmigoARegalar.uid)); ;
        gvRegalosDisponibles.DataBind();
    }

    protected void lbAsociarCuenta_Click(object sender, EventArgs e)
    {
        Response.Redirect("AsociarCuenta.aspx");
    }

    protected void gvRegalosDisponibles_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            int id = Convert.ToInt32(gvRegalosDisponibles.DataKeys[e.Row.RowIndex].Values["IdProdSer"]);
            Image image = (Image)e.Row.Cells[0].FindControl("ImagenProducto");

            image.ImageUrl = String.Format("~/Imag/Productos/{0}.jpg", id.ToString()); 
        }
    }

    protected void gvRegalosDisponibles_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        switch (e.CommandName.ToLower())
        {
            case "agregar":
                DBKeeper.getInstance().ReservarRegalo((int)API.uid, (int)AmigoARegalar.uid, Convert.ToInt32(e.CommandArgument));
                break;
        }

        ResetearInfo();
    }

    protected void lbFinCompra_Click(object sender, EventArgs e)
    {
        Response.Redirect("ConfirmacionCompra.aspx");
    }
}
