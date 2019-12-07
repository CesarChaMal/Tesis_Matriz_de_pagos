Create Procedure CargaMatrizPersonalizado @NombreTabla VarChar(80),@NombreTablaDetalles VarChar(80) as
-- drop procedure CargaMatrizPersonalizado

-- Declare @NombreTabla VarChar(20)
-- set @NombreTabla = 'Matriz070524'

--Select Nombre=@NombreTabla into ##tmpAux

Declare @sql VarChar(1500)
--Declare @NombreTabla VarChar(20)
--select @NombreTabla = Nombre from ##tmpAux

/* Cálculo para tipo 2: Decremental */
Set @sql = 'Select c.idCaracteristica, Total=sum(df.valor) '+
'into ##tmpValores1 '+
'from CatMarcas m, catAutomovil a, FichaTecnica f, '+ @NombreTablaDetalles + ' df, catCaracteristicas c '+
'where m.idMarca=a.idMarca and f.idAutomovil=a.idautomovil and f.idFicha=df.idFicha and c.idCaracteristica=df.idCaracteristica and '+
'	f.Activo=1 and a.Activo=1 and c.Tipo=2 '+
'Group by c.idCaracteristica'
Exec (@sql)

Set @sql = 'Select m.Marca, a.Modelo, c.Descripcion as ''Caracteristica '', c.idCaracteristica, '+
'	Proporcion=1-(sum(df.valor)/t.Total) '+
'into ##tmpCargaMatriz1 '+
'from CatMarcas m, catAutomovil a, FichaTecnica f,'+ @NombreTablaDetalles + ' df, catCaracteristicas c, ##tmpValores1 t '+
'where m.idMarca=a.idMarca and f.idAutomovil=a.idautomovil and f.idFicha=df.idFicha and '+
'	c.idCaracteristica=df.idCaracteristica and t.idCaracteristica=c.idCaracteristica and '+
'	f.Activo=1 and a.Activo=1 and c.Tipo=2 '+
'Group by m.Marca, a.Modelo, c.Descripcion, c.idCaracteristica, t.Total '+
'order by c.Descripcion asc, proporcion asc'
Exec (@sql)


-- Set @sql = 'Select * into ' + @NombreTabla + ' from ##tmpValores1'
Set @sql = 'Select * into ' + @NombreTabla + ' from ##tmpCargaMatriz1'
Exec (@sql)

drop table ##tmpValores1
drop table ##tmpCargaMatriz1

-- Exec CargaMatrizPersonalizado 'Cesar1','CargaMatrizDetalleFichaTecnica'
-- drop table Cesar1
-- select * from Cesar1