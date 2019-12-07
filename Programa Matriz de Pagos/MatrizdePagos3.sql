if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CargaMatrizPersonalizado]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[CargaMatrizPersonalizado]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

Create Procedure CargaMatrizPersonalizado @NombreTabla VarChar(80),@NombreTablaDetalles VarChar(80) as
-- drop procedure CargaMatrizPersonalizado

-- Declare @NombreTabla VarChar(20)
-- set @NombreTabla = 'Matriz070524'

--Select Nombre=@NombreTabla into ##tmpAux

Declare @sql VarChar(1500)
--Declare @NombreTabla VarChar(20)
--select @NombreTabla = Nombre from ##tmpAux

/* Cálculo para tipo 2: Decremental */
-- Set @sql = 'Select c.idCaracteristica, Total=sum(df.valor) '+
Set @sql = 'Select c.idCaracteristica, Promedio=avg(df.valor) '+
'into ##tmpValores1 '+
'from CatMarcas m, catAutomovil a, FichaTecnica f, ' + @NombreTablaDetalles + ' df, catCaracteristicas c '+
'where m.idMarca=a.idMarca and f.idAutomovil=a.idautomovil and f.idFicha=df.idFicha and c.idCaracteristica=df.idCaracteristica and '+
'	f.Activo=1 and a.Activo=1 and c.Tipo=2 '+
'Group by c.idCaracteristica'
Exec (@sql)

-- Set @sql = 'Select m.Marca, a.Modelo, c.Descripcion as ''Caracteristica'', c.idCaracteristica, '+
-- '	Proporcion=1-(sum(df.valor)/t.Total) '+
Set @sql = 'Select m.Marca, a.Modelo, c.Descripcion as ''Caracteristica'', c.idCaracteristica, '+
'	Proporcion= (t.Promedio - sum(df.valor)) / t.Promedio '+
'into ##tmpCargaMatriz1 '+
'from CatMarcas m, catAutomovil a, FichaTecnica f, ' + @NombreTablaDetalles + ' df, catCaracteristicas c, ##tmpValores1 t '+
'where m.idMarca=a.idMarca and f.idAutomovil=a.idautomovil and f.idFicha=df.idFicha and '+
'	c.idCaracteristica=df.idCaracteristica and t.idCaracteristica=c.idCaracteristica and '+
'	f.Activo=1 and a.Activo=1 and c.Tipo=2 '+
-- 'Group by m.Marca, a.Modelo, c.Descripcion, c.idCaracteristica, t.Total '+
'Group by m.Marca, a.Modelo, c.Descripcion, c.idCaracteristica, t.Promedio '+
'order by c.Descripcion asc, proporcion asc'
Exec (@sql)

drop table ##tmpValores1

-- Select cf.idFamilia,cf.Descripcion as 'Familia',t.*, P.Peso, Factor = t.Proporcion * p.Peso * -1
-- Select cf.idFamilia,cf.Descripcion as 'Familia',t.*, P.Peso, Factor = t.Proporcion * p.Peso
Select cf.idFamilia,cf.Descripcion as 'Familia',t.*, P.Factor, Peso = t.Proporcion * p.Factor
	into ##tmpMatriz
from ##tmpCargaMatriz1 t,
	catCaracteristicas c, catFamilias cf, relPuntoFamilia r, catPuntosAdquisicion pa, Pareto p
where t.idCaracteristica=c.idCaracteristica and 
	c.idFamilia=cf.idFamilia and cf.idFamilia=r.idFamilia and pa.idPunto=r.idPunto and pa.idPunto=p.idPunto

drop table ##tmpCargaMatriz1

/* Cálculo para tipo 1 : Incremental */
Set @sql = 'Select c.idCaracteristica, Total=sum(df.valor) '+
'into ##tmpValores2 '+
'from CatMarcas m, catAutomovil a, FichaTecnica f, '+ @NombreTablaDetalles + ' df, catCaracteristicas c '+
'where m.idMarca=a.idMarca and f.idAutomovil=a.idautomovil and f.idFicha=df.idFicha and c.idCaracteristica=df.idCaracteristica and '+
'	f.Activo=1 and a.Activo=1 and c.Tipo=1 '+     -- <- Diferencia con tipo 2
'Group by c.idCaracteristica'
Exec (@sql)

Set @sql = 'Select m.Marca, a.Modelo, c.Descripcion as ''Caracteristica'', c.idCaracteristica, '+
'	Proporcion=(sum(df.valor)/t.Total) '+  	      -- <- Diferencia con tipo 2
'into ##tmpCargaMatriz2 '+
'from CatMarcas m, catAutomovil a, FichaTecnica f, ' + @NombreTablaDetalles + ' df, catCaracteristicas c, ##tmpValores2 t '+
'where m.idMarca=a.idMarca and f.idAutomovil=a.idautomovil and f.idFicha=df.idFicha and '+
'	c.idCaracteristica=df.idCaracteristica and t.idCaracteristica=c.idCaracteristica and '+
'	f.Activo=1 and a.Activo=1 and c.Tipo=1 '+     -- <- Diferencia con tipo 2
'Group by m.Marca, a.Modelo, c.Descripcion, c.idCaracteristica, t.Total '+
'order by c.Descripcion asc, proporcion asc'
Exec (@sql)

drop table ##tmpValores2

insert into ##tmpMatriz
-- Select cf.idFamilia,cf.Descripcion as 'Familia',t.*, P.Peso, Factor = t.Proporcion * p.Peso
Select cf.idFamilia,cf.Descripcion as 'Familia',t.*, P.Factor, Peso = t.Proporcion * p.Factor
from ##tmpCargaMatriz2 t, 
	catCaracteristicas c, catFamilias cf, relPuntoFamilia r, catPuntosAdquisicion pa, Pareto p
where t.idCaracteristica=c.idCaracteristica and
	c.idFamilia=cf.idFamilia and cf.idFamilia=r.idFamilia and pa.idPunto=r.idPunto and pa.idPunto=p.idPunto

drop table ##tmpCargaMatriz2

/* Cálculo para tipo 0 : Boleano */
Set @sql = 'Select m.Marca, a.Modelo, c.Descripcion as ''Caracteristica'', c.idCaracteristica, '+
'	Proporcion=df.Valor '+  			-- <- Diferencia con tipo 2
'into ##tmpCargaMatriz3 '+
'from CatMarcas m, catAutomovil a, FichaTecnica f, ' + @NombreTablaDetalles + ' df, catCaracteristicas c '+
'where m.idMarca=a.idMarca and f.idAutomovil=a.idautomovil and f.idFicha=df.idFicha and '+
'	c.idCaracteristica=df.idCaracteristica and '+
'	f.Activo=1 and a.Activo=1 and c.Tipo=0 '+ 	-- <- Diferencia con tipo 2
'order by c.Descripcion asc, proporcion asc'
Exec (@sql)

insert into ##tmpMatriz
-- Select cf.idFamilia,cf.Descripcion as 'Familia',t.*, P.Peso, Factor = t.Proporcion * p.Peso
Select cf.idFamilia,cf.Descripcion as 'Familia',t.*, P.Factor, Peso = t.Proporcion * p.Factor
from ##tmpCargaMatriz3 t, 
	catCaracteristicas c, catFamilias cf, relPuntoFamilia r, catPuntosAdquisicion pa, Pareto p
where t.idCaracteristica=c.idCaracteristica and
	c.idFamilia=cf.idFamilia and cf.idFamilia=r.idFamilia and pa.idPunto=r.idPunto and pa.idPunto=p.idPunto

drop table ##tmpCargaMatriz3

/* Graba la matriz de pagos en la tabla seleccionada */
-- Declare @sql VarChar(500)
-- Declare @NombreTabla VarChar(20)
-- select @NombreTabla = Nombre from ##tmpAux

Set @sql = 'Select * into ' + @NombreTabla + ' from ##tmpMatriz Order by Marca, Modelo'
Exec (@sql)

drop table ##tmpMatriz
--drop table ##tmpAux

/*
Declare @sql VarChar(1500)
Declare @nombre VarChar(150)

Set @nombre ='Cesar' 
Set @sql ='Exec detFichaTecnicaPersonalizado ''sc' + @nombre + 'FichaTecnica'''
select @sql as 'sql'
Exec (@sql)

Set @sql ='Exec CargaMatrizPersonalizado ''sc' + @nombre + 'Matriz'', ''sc' + @nombre + 'FichaTecnica'''
select @sql as 'sql'
Exec (@sql)
*/

/*
Declare @sql VarChar(1500)
Declare @nombre VarChar(150)

Set @nombre ='Cesar' 
Set @sql ='drop table sc' + @nombre + 'FichaTecnica'
select @sql as 'sql'
Exec (@sql)

Set @sql ='drop table sc' + @nombre + 'Matriz'
select @sql as 'sql'
Exec (@sql)
*/

/*
Exec detFichaTecnicaPersonalizado 'scCesarFichaTecnica'
select * from scCesarFichaTecnica

Exec CargaMatrizPersonalizado 'scCesarMatriz','scCesarFichaTecnica'
select * from scCesarMatriz

-- drop table scCesarFichaTecnica
-- drop table scCesarMatriz
*/

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO
