SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UsuarioFacebook]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[UsuarioFacebook](
	[Id] [int] NOT NULL,
	[Asociado] [bit] NOT NULL,
	[IdUsuario] [int] NULL,
 CONSTRAINT [PK_UsuarioFacebook] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Regalo]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Regalo](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdProdSer] [int] NOT NULL,
	[IdUsuario] [int] NOT NULL,
	[Regalado] [bit] NOT NULL CONSTRAINT [DF_Regalo_Regalado]  DEFAULT ((0)),
 CONSTRAINT [PK_Regalo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CompraRegalo]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CompraRegalo](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdFacebookUser] [int] NOT NULL,
	[IdRegalo] [int] NOT NULL,
	[NombreComprador] [varchar](50) NULL,
	[MailComprador] [varchar](50) NULL,
	[Confirmado] [bit] NOT NULL CONSTRAINT [DF_CompraRegalo_Confirmado]  DEFAULT ((0)),
 CONSTRAINT [PK_CompraRegalo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO