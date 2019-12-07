select a.idEncuesta,a.idAutomovil, b.Modelo from dbo.Encuesta a, dbo.catAutomovil b where a.IdAutomovil=b.IdAutomovil and a.Activo=1 order by a.IdAutomovil
select a.idFicha,a.idAutomovil, b.Modelo from dbo.FichaTecnica a, dbo.catAutomovil b where a.IdAutomovil=b.IdAutomovil  and a.Activo=1 and b.Activo=1 order by a.IdAutomovil

CREATE TABLE [detFichaTecnica] (
	[idFicha] [int] NOT NULL ,
	[idCaracteristica] [int] NOT NULL ,
	[Valor] [real] NOT NULL ,
	CONSTRAINT [IX_detFichaTecnica] UNIQUE  NONCLUSTERED 
	(
		[idFicha],
		[idCaracteristica]
	)  ON [PRIMARY] ,
	CONSTRAINT [FK_detFichaTecnica_catCaracteristicas] FOREIGN KEY 
	(
		[idCaracteristica]
	) REFERENCES [catCaracteristicas] (
		[IdCaracteristica]
	),
	CONSTRAINT [FK_detFichaTecnica_FichaTecnica] FOREIGN KEY 
	(
		[idFicha]
	) REFERENCES [FichaTecnica] (
		[IdFicha]
	)
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[productos] ADD 
	CONSTRAINT [DF_productos_stock] DEFAULT (0) FOR [stock],
	CONSTRAINT [DF_productos_promocion] DEFAULT (0) FOR [promocion],
	CONSTRAINT [PK_productos] PRIMARY KEY  NONCLUSTERED 
	(
		[id_producto]
	)  ON [PRIMARY] ,
	CONSTRAINT [IX_codigo] UNIQUE  NONCLUSTERED 
	(
		[codigo]
	)  ON [PRIMARY] 
GO

ALTER TABLE productos ADD
CONSTRAINT IX_codigo UNIQUE  NONCLUSTERED 	
	(codigo)  ON PRIMARY
GO

