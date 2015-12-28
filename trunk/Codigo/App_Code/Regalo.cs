using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Regalo
/// </summary>
public class Regalo
{
    int id;
    byte[] foto;
    string desc;
    decimal precio;
    int idProdSer; 

    public int Id
    {
        get { return this.id; }
        set { this.id = value; }
    }
    public byte[] Foto
    {
        get { return this.foto; }
        set { this.foto = value; }
    }
    public string Descripcion
    {
        get { return this.desc; }
        set { this.desc = value; }
    }
    public decimal Precio
    {
        get { return this.precio; }
        set { this.precio = value; }
    }
    public int IdProdSer
    {
        get { return this.idProdSer; }
        set { this.idProdSer = value; }
    }
}
