using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Regalo
/// </summary>
public class InfoCompra
{
    string nombreProveedor;
    string direccionProveeedor;
    string telefonoProveedor;
    string mailProveedor;
    string nombreRespProveedor;
    string apellidoRespProveedor;
    string denominacionProducto;
    decimal precioProducto;

    public string NombreProveedor
    {
        get { return this.nombreProveedor; }
        set { this.nombreProveedor = value; }
    }

    public string DireccionProveedor
    {
        get { return this.direccionProveeedor; }
        set { this.direccionProveeedor = value; }
    }

    public string TelefonoProveedor
    {
        get { return this.telefonoProveedor; }
        set { this.telefonoProveedor = value; }
    }

    public string MailProveedor
    {
        get { return this.mailProveedor; }
        set { this.mailProveedor = value; }
    }

    public string NombreRespProveedor
    {
        get { return this.nombreRespProveedor; }
        set { this.nombreRespProveedor = value; }
    }

    public string ApellidoRespProveedor
    {
        get { return this.apellidoRespProveedor; }
        set { this.apellidoRespProveedor = value; }
    }

    public string DenominacionProducto
    {
        get { return this.denominacionProducto; }
        set { this.denominacionProducto = value; }
    }

    public decimal PrecioProducto
    {
        get { return this.precioProducto; }
        set { this.precioProducto = value; }
    }
}
