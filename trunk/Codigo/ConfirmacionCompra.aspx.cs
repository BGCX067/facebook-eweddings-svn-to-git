using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using facebook.Schema;
using facebook.web;

public partial class ConfirmacionCompra : System.Web.UI.Page
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

        if (DBKeeper.getInstance().EstaAsociado(API.uid))
            lbAsociarCuenta.Visible = false;
        else
            lbAsociarCuenta.Visible = true;

        lblTitle.Text = String.Format("Confirmación de los regalos para {0}", AmigoARegalar.first_name);
        lbVolver.Text = String.Format("Volver a Regalos de {0}", AmigoARegalar.first_name);
    }

    private void CargarGrilla()
    {
        IList<Regalo> regalos = DBKeeper.getInstance().ObtenerRegalosReservados((int)API.uid, Convert.ToInt32(AmigoARegalar.uid));
        decimal precio = 0;

        foreach (Regalo regalo in regalos)
        {
            precio += regalo.Precio;
        }
        lblValorTotal.Text = String.Format("$ {0}", precio);
        gvRegalosDisponibles.DataSource = regalos;
        gvRegalosDisponibles.DataBind();
    }

    public void ResetearInfo()
    {
        CargarGrilla();
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
            case "borrar":
                DBKeeper.getInstance().BorrarRegalo(Convert.ToInt32(e.CommandArgument));
                break;
        }

        ResetearInfo();
    }

    protected void btnConfirmar_Click(object sender, EventArgs e)
    {
        IList<Regalo> regalos = DBKeeper.getInstance().ObtenerRegalosReservados((int)API.uid, (int)AmigoARegalar.uid);
        InfoCompra compra;
        string infoCompra;

        foreach (Regalo regalo in regalos)
        {
            compra = DBKeeper.getInstance().ConfirmarRegalo(regalo.Id, String.Format("{0} {1}", API.users.getInfo(API.uid).first_name, API.users.getInfo(API.uid).last_name));

            if (compra != null)
            {
                infoCompra = String.Format("Felicitaciones! Has realizado la compra de un regalo para la boda de {0}.\n\n", AmigoARegalar.first_name);
                infoCompra += String.Format("Datos de la compra:\n\n");
                infoCompra += String.Format("Proveedor: {0}\n", compra.NombreProveedor);
                infoCompra += String.Format("Direccion del Proveedor: {0}\n", compra.DireccionProveedor);
                infoCompra += String.Format("Teléfono del Proveedor: {0}\n", compra.TelefonoProveedor);
                infoCompra += String.Format("E-mail del Proveedor: {0}\n", compra.MailProveedor);
                infoCompra += String.Format("Nombre del Responsable del Proveedor: {0}, {1}\n", compra.ApellidoRespProveedor, compra.NombreRespProveedor);
                infoCompra += String.Format("Denominación del producto comprado: {0}\n", compra.DenominacionProducto);
                infoCompra += String.Format("Precio del producto comprado: {0}\n\n", compra.PrecioProducto);
                infoCompra += String.Format("Muchas Gracias por su Compra,\n");
                infoCompra += String.Format("eWeddings Team.\n\n");
                infoCompra += String.Format("Para más información visite http://www.eweddings.com.ar");

                API.notifications.send(API.uid.ToString(), infoCompra);
                API.notifications.sendEmail(API.uid.ToString(), "Compra de regalo en eWeddings!", infoCompra, "");

                infoCompra = String.Format("Felicitaciones!\n El usuario {0} {1}, te ha regalado el producto {2} para tu boda a través de Facebook-eWeddings", API.users.getInfo(API.uid).first_name, API.users.getInfo(API.uid).last_name, compra.DenominacionProducto);
                API.notifications.send(AmigoARegalar.uid.ToString(), infoCompra);
                API.notifications.sendEmail(AmigoARegalar.uid.ToString(), "Te hicieron un regalo a través de Facebook-eWeddings!!!", infoCompra, "");
            }
        }

        ResetearInfo();
    }
}
