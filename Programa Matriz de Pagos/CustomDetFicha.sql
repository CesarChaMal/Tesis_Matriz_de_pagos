if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[detFichaTecnicaPersonalizado]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[detFichaTecnicaPersonalizado]
GO
-- drop procedure detFichaTecnicaPersonalizado
Create Procedure detFichaTecnicaPersonalizado @NombreTabla VarChar(80) as

-- Declare @NombreTabla VarChar(20)
-- set @NombreTabla = 'Cesar'

--Select Nombre=@NombreTabla into ##tmpAux

Select * into ##tmpdetFichaTecnica from detFichaTecnica
/* Graba la matriz de pagos en la tabla seleccionada */
Declare @sql VarChar(500)
--Declare @NombreTabla VarChar(20)
--select @NombreTabla = Nombre from ##tmpAux

Set @sql = 'Select * into ' + @NombreTabla + ' from ##tmpdetFichaTecnica df Order by df.idFicha,df.idCaracteristica'
Exec (@sql)
drop table ##tmpdetFichaTecnica

/* Ejecucion del procedimiento
Exec detFichaTecnicaPersonalizado 'CargaMatrizDetalleFichaTecnica'
select * from CargaMatrizDetalleFichaTecnica
drop table CargaMatrizDetalleFichaTecnica
*/