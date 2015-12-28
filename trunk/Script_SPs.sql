SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fbook_tiene_boda]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[fbook_tiene_boda]
	@IdFacebookUsr INT
AS
BEGIN
	SELECT boda.*
	FROM Organizador org, UsuarioFacebook usrfb, Boda boda
	WHERE usrfb.Id = @IdFacebookUsr
	AND	usrfb.Asociado = 1
	AND org.IdUsuario = usrfb.IdUsuario
	AND boda.Id = org.IdBoda
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fbook_esta_asociado]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[fbook_esta_asociado]
	@IdFacebookUsr INT
AS
BEGIN
	SELECT * FROM UsuarioFacebook WHERE Id=@IdFacebookUsr AND Asociado=1
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fbook_nuevo_usuario]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[fbook_nuevo_usuario]
	@IdFacebookUsr INT
AS
BEGIN
	if(NOT EXISTS(select * from UsuarioFacebook where Id=@IdFacebookUsr))
	BEGIN
		INSERT INTO UsuarioFacebook VALUES(@IdFacebookUsr, 0, NULL)
	END
END
' 
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fbook_obtener_regalos]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[fbook_obtener_regalos]
	@IdFacebookUsr INT
AS
BEGIN
	SELECT Regalo.Id, ProdSer.Precio, ProdSer.Denominacion, Regalo.IdProdSer
	FROM ProdSer, Regalo, UsuarioFacebook usrfb
	WHERE usrfb.Id = @IdFacebookUsr
	AND usrfb.Asociado = 1
	AND	Regalo.IdUsuario = usrfb.IdUsuario
	AND Regalo.Regalado = 0
	AND ProdSer.Id = Regalo.IdProdSer
END


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fbook_obtener_regalos_reservados]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[fbook_obtener_regalos_reservados]
	@IdFacebookUser INT,
	@IdAmigoFacebookUser INT
	
AS
BEGIN
	SELECT CompraRegalo.Id, ProdSer.Denominacion, ProdSer.Precio, Regalo.IdProdSer
	FROM CompraRegalo, Regalo, ProdSer, UsuarioFacebook usrfb
	WHERE CompraRegalo.IdFacebookUser = @IdFacebookUser
	AND CompraRegalo.Confirmado = 0
	AND	Regalo.Id = CompraRegalo.IdRegalo
	AND usrfb.Id = @IdAmigoFacebookUser
	AND Regalo.IdUsuario = usrfb.IdUsuario
	AND ProdSer.Id = Regalo.IdProdSer
END

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fbook_confirmar_regalo_reservado]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[fbook_confirmar_regalo_reservado]
	@IdCompraRegalo INT,
	@NombreComprador VARCHAR(50)
	
AS
	
BEGIN
	UPDATE CompraRegalo SET NombreComprador = @NombreComprador, Confirmado=1
	WHERE Id = @IdCompraRegalo

	DECLARE @IdRegalo INT
	SELECT @IdRegalo = IdRegalo FROM CompraRegalo WHERE Id = @IdCompraRegalo
	
	UPDATE Regalo SET Regalado=1
	WHERE Id = @IdRegalo

	SELECT	prov.Nombre, prov.Direccion, prov.Telefono, prov.Mail, prov.NombreResp, prov.ApellidoResp,
			ProdSer.Denominacion, ProdSer.Precio
	FROM Proveedor prov, Regalo, ProdSer
	WHERE Regalo.Id = @IdRegalo
	AND ProdSer.Id = Regalo.IdProdSer
	AND prov.Id = ProdSer.IdProveedor
END



' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fbook_asociar_cuenta]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[fbook_asociar_cuenta]
	@IdFacebookUsr INT,
	@EWUser VARCHAR(50),
	@EWPass VARCHAR(50)
AS
BEGIN
	IF(EXISTS(SELECT * FROM Usuario WHERE NombreUsuario=@EWUser AND Contrasenia=@EWPass))
	BEGIN
		INSERT INTO UsuarioFacebook SELECT @IdFacebookUsr,1, Id FROM Usuario WHERE NombreUsuario=@EWUser AND Contrasenia=@EWPass
	END

	SELECT * FROM Usuario WHERE NombreUsuario=@EWUser AND Contrasenia=@EWPass

END

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fbook_reservar_regalo_2]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[fbook_reservar_regalo_2]
	@IdFacebookUsr INT,
	@IdAmigoFacebookUsr INT,
	@IdProdSer INT
	
AS
	
BEGIN
	DECLARE @IdRegalo INT
	DECLARE @IdUsuario INT
	
	SELECT @IdUsuario = IdUsuario FROM UsuarioFacebook WHERE Id=@IdAmigoFacebookUsr
	SELECT @IdRegalo = Id FROM Regalo WHERE IdProdSer=@IdProdSer AND IdUsuario=@IdUsuario

	INSERT INTO CompraRegalo(IdFacebookUser, IdRegalo, Confirmado) 
	VALUES(@IdFacebookUsr, @IdRegalo, 0)
END


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fbook_reservar_regalo]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[fbook_reservar_regalo]
	@IdFacebookUsr INT,
	@IdAmigoFacebookUsr INT,
	@IdProdSer INT
	
AS
	
BEGIN
	INSERT INTO CompraRegalo(IdFacebookUser, IdRegalo, Confirmado) 
	VALUES(@IdFacebookUsr, @IdProdSer, 0)
END


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fbook_borrar_regalo]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[fbook_borrar_regalo]
	@IdRegalo INT
	
AS
BEGIN
	DELETE FROM CompraRegalo WHERE Id = @IdRegalo
END
' 
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_UsrFacebook_IdUsuario_Usuarios_Id]') AND parent_object_id = OBJECT_ID(N'[dbo].[UsuarioFacebook]'))
ALTER TABLE [dbo].[UsuarioFacebook]  WITH CHECK ADD  CONSTRAINT [FK_UsrFacebook_IdUsuario_Usuarios_Id] FOREIGN KEY([Id])
REFERENCES [dbo].[UsuarioFacebook] ([Id])
GO
ALTER TABLE [dbo].[UsuarioFacebook] CHECK CONSTRAINT [FK_UsrFacebook_IdUsuario_Usuarios_Id]
