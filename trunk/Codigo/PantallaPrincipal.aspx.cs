using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using facebook.Schema;
using facebook.web;

public partial class PantallaPrincipal : System.Web.UI.Page
{
    private IList<user> amigos;
    private IDictionary<long, user> amigosConId;

    public facebook.API API
    {
        get { return ((CanvasIFrameMasterPage)Master).API; }
    }

    public IList<user> AmigosConBoda
    {
        get { return this.amigos; }
        set { this.amigos = value; }
    }

    public user AmigoARegalar
    {
        get { return (user)Session["friend"]; }
        set { Session["friend"] = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        CargarGrilla();

        if (!IsPostBack)
        {
            
            IList<album> albums = API.photos.getAlbums();
            facebook.Schema.user userinfo = API.users.getInfo(API.uid);
            //Label1.Text = "Hi, " + userinfo.first_name;
            //Image1.ImageUrl = userinfo.pic;
        }

        if (DBKeeper.getInstance().EstaAsociado(API.uid))
            lbAsociarCuenta.Visible = false;
        else
            lbAsociarCuenta.Visible = true;
    }

    private void CargarGrilla()
    {
        AmigosConBoda = new List<user>();
        this.amigosConId = new Dictionary<long, user>();
        foreach (user friend in API.friends.getUserObjects())
        {
            if (DBKeeper.getInstance().TieneBoda(friend))
            {
                AmigosConBoda.Add(friend);
                this.amigosConId.Add((long)friend.uid, friend);
            }
        }

        gvAmigosConBoda.DataSource = AmigosConBoda;
        gvAmigosConBoda.DataBind();
    }

    public void Friend_Click(object sender, FriendListItemClickEventArgs e)
    {
    }

    protected void lbAsociarCuenta_Click(object sender, EventArgs e)
    {
        Response.Redirect("AsociarCuenta.aspx");
    }

    protected void gvAmigosConBoda_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        switch (e.CommandName.ToLower())
        {
            case "verregalos":
                AmigoARegalar = this.amigosConId[(long)Convert.ToInt32(e.CommandArgument)];
                Response.Redirect("Regalos.aspx");
                break;
        }

    }

    private void VerRegalos()
    {

    }
}
