using System;
using System.Collections.Generic;
using System.Text;
using DBServices;
using System.Data;
using System.Threading;
using System.Globalization;
using System.Configuration;
using facebook.Schema;
using facebook.web;

public class DBKeeper
{
	private static DBKeeper instance;
	private DBConnection dbConn;

	#region Constructor & Singleton
	public DBKeeper(string connectionString, int numConnections, string dbType, int timeout, int secondsCommandTimeout)
	{
		switch (dbType.ToUpper())
		{
			case "SQL":
				this.dbConn = new DBSqlConnection(connectionString, numConnections, timeout, secondsCommandTimeout);
				break;

			case "ORACLE":
				this.dbConn = new DBOracleConnection(connectionString, numConnections, timeout, secondsCommandTimeout);
				break;
		}

		instance = this;
	}

	public static DBKeeper getInstance()
	{
        if (instance == null)
            instance = new DBKeeper(ConfigurationManager.ConnectionStrings["eWeddingPablo"].ConnectionString, 10, "SQL", 30, 30);

		return instance;
	}
	#endregion

	
    #region Nuevo Usuario
    public void NuevoUsuario(long uid)
    {
        ParamInfo parameters = new ParamInfo();
        ReturnValue retVal;

        parameters.Add("@IdFacebookUsr", SqlDbType.Int, 15, ParameterDirection.Input, uid);

        retVal = dbConn.ExecuteStoredProcedure("fbook_nuevo_usuario", ref parameters);
    }
    #endregion

    #region ¿Tiene Boda?
    public bool TieneBoda(user friend)
    {
        ParamInfo parameters = new ParamInfo();
        ReturnValue retVal;

        parameters.Add("@IdFacebookUsr", SqlDbType.Int, 15, ParameterDirection.Input, friend.uid);

        retVal = dbConn.ExecuteStoredProcedure("fbook_tiene_boda", ref parameters);
        if (retVal.ErrorCode != Error.OK)
            return false;

        if (retVal.Cursor.Tables[0].Rows.Count > 0)
            return true;

        return false;
    }
    #endregion

    #region Asociar Cuenta
    public int AsociarCuenta(long uid, string user, string pass)
    {
        ParamInfo parameters = new ParamInfo();
        ReturnValue retVal;

        parameters.Add("@IdFacebookUsr", SqlDbType.Int, 15, ParameterDirection.Input, uid);
        parameters.Add("@EWUser", SqlDbType.VarChar, 50, ParameterDirection.Input, user);
        parameters.Add("@EWPass", SqlDbType.VarChar, 50, ParameterDirection.Input, pass);

        retVal = dbConn.ExecuteStoredProcedure("fbook_asociar_cuenta", ref parameters);

        if (retVal.Cursor.Tables[0].Rows.Count <= 0)
            return -1;

        return 0;
    }
    #endregion


    public bool EstaAsociado(long uid)
    {
        ParamInfo parameters = new ParamInfo();
        ReturnValue retVal;

        parameters.Add("@IdFacebookUsr", SqlDbType.Int, 15, ParameterDirection.Input, uid);

        retVal = dbConn.ExecuteStoredProcedure("fbook_esta_asociado", ref parameters);

        if (retVal.ErrorCode != Error.OK || retVal.Cursor.Tables[0].Rows.Count <= 0)
            return false;
        else
            return true;
    }

    public IList<Regalo> ObtenerRegalosUsuario(int facebookId)
    {
        ParamInfo parameters = new ParamInfo();
        ReturnValue retVal;
        IList<Regalo> regalos = new List<Regalo>();
        Regalo regalo;

        parameters.Add("@IdFacebookUsr", SqlDbType.Int, 15, ParameterDirection.Input, facebookId);

        retVal = dbConn.ExecuteStoredProcedure("fbook_obtener_regalos", ref parameters);

        if (retVal.ErrorCode != Error.OK || retVal.Cursor.Tables[0].Rows.Count <= 0)
            return regalos;

        foreach (DataRow row in retVal.Cursor.Tables[0].Rows)
        {
            regalo = new Regalo();
            regalo.Id = Convert.ToInt32(row["Id"]);
            regalo.Descripcion = Convert.ToString(row["Denominacion"]);
            regalo.Precio = Convert.ToDecimal(row["Precio"]);
            regalo.IdProdSer = Convert.ToInt32(row["IdProdSer"]);
            regalos.Add(regalo);
        }

        return regalos;
    }

    public bool ReservarRegalo(int idFacebook, int amigoFacebookId, int regaloId)
    {
        ParamInfo parameters = new ParamInfo();
        ReturnValue retVal;

        parameters.Add("@IdFacebookUsr", SqlDbType.Int, 15, ParameterDirection.Input, idFacebook);
        parameters.Add("@IdAmigoFacebookUsr", SqlDbType.Int, 15, ParameterDirection.Input, amigoFacebookId);
        parameters.Add("@IdProdSer", SqlDbType.Int, 15, ParameterDirection.Input, regaloId);

        retVal = dbConn.ExecuteStoredProcedure("fbook_reservar_regalo", ref parameters);

        if (retVal.ErrorCode != Error.OK)
            return false;
        
        return true;
    }

    public bool BorrarRegalo(int regaloId)
    {
        ParamInfo parameters = new ParamInfo();
        ReturnValue retVal;

        parameters.Add("@IdRegalo", SqlDbType.Int, 15, ParameterDirection.Input, regaloId);

        retVal = dbConn.ExecuteStoredProcedure("fbook_borrar_regalo", ref parameters);

        if (retVal.ErrorCode != Error.OK)
            return false;

        return true;
    }

    public IList<Regalo> ObtenerRegalosReservados(int facebookId, int amigoFacebookId)
    {
        ParamInfo parameters = new ParamInfo();
        ReturnValue retVal;
        IList<Regalo> regalos = new List<Regalo>();
        Regalo regalo;

        parameters.Add("@IdFacebookUser", SqlDbType.Int, 15, ParameterDirection.Input, facebookId);
        parameters.Add("@IdAmigoFacebookUser", SqlDbType.Int, 15, ParameterDirection.Input, amigoFacebookId);

        retVal = dbConn.ExecuteStoredProcedure("fbook_obtener_regalos_reservados", ref parameters);

        if (retVal.ErrorCode != Error.OK || retVal.Cursor.Tables[0].Rows.Count <= 0)
            return regalos;

        foreach (DataRow row in retVal.Cursor.Tables[0].Rows)
        {
            regalo = new Regalo();
            regalo.Id = Convert.ToInt32(row["Id"]);
            regalo.Descripcion = Convert.ToString(row["Denominacion"]);
            regalo.Precio = Convert.ToDecimal(row["Precio"]);
            regalo.IdProdSer = Convert.ToInt32(row["IdProdSer"]);
            regalos.Add(regalo);
        }

        return regalos;
    }

    public InfoCompra ConfirmarRegalo(int idCompra, string nombreComprador)
    {
        ParamInfo parameters = new ParamInfo();
        ReturnValue retVal;
        InfoCompra compra;
        DataRow row;

        parameters.Add("@IdCompraRegalo", SqlDbType.Int, 15, ParameterDirection.Input, idCompra);
        parameters.Add("@NombreComprador", SqlDbType.VarChar, 50, ParameterDirection.Input, nombreComprador);

        retVal = dbConn.ExecuteStoredProcedure("fbook_confirmar_regalo_reservado", ref parameters);

        if (retVal.ErrorCode != Error.OK || retVal.Cursor.Tables[0].Rows.Count <= 0)
            return null;

        row = retVal.Cursor.Tables[0].Rows[0];
        compra = new InfoCompra();

        compra.NombreProveedor = row["Nombre"].ToString();
        compra.DireccionProveedor = row["Direccion"].ToString();
        compra.TelefonoProveedor = row["Telefono"].ToString();
        compra.MailProveedor = row["Mail"].ToString();
        compra.NombreRespProveedor = row["NombreResp"].ToString();
        compra.ApellidoRespProveedor= row["ApellidoResp"].ToString();
        compra.DenominacionProducto = row["Denominacion"].ToString();
        compra.PrecioProducto = Convert.ToDecimal(row["Precio"]);

        return compra;
    }
}
