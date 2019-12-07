-- drop procedure CargaMatriz
Create Procedure CargaMatriz @NombreTabla VarChar(80) as

-- Declare @NombreTabla VarChar(20)
-- set @NombreTabla = 'Matriz070524'

--Select Nombre=@NombreTabla into ##tmpAux

/* C�lculo para tipo 2: Decremental */
Select c.idCaracteristica, Total=sum(df.valor)
into ##tmpValores1
from CatMarcas m, catAutomovil a, FichaTecnica f, detFichaTecnica df, catCaracteristicas c
where m.idMarca=a.idMarca and f.idAutomovil=a.idautomovil and f.idFicha=df.idFicha and c.idCaracteristica=df.idCaracteristica and
	f.Activo=1 and a.Activo=1 and c.Tipo=2
Group by c.idCaracteristica

Select m.Marca, a.Modelo, c.Descripcion as 'Caracteristica', c.idCaracteristica,
	Proporcion=1-(sum(df.valor)/t.Total)
into ##tmpCargaMatriz1
from CatMarcas m, catAutomovil a, FichaTecnica f, detFichaTecnica df, catCaracteristicas c, ##tmpValores1 t
where m.idMarca=a.idMarca and f.idAutomovil=a.idautomovil and f.idFicha=df.idFicha and 
	c.idCaracteristica=df.idCaracteristica and t.idCaracteristica=c.idCaracteristica and
	f.Activo=1 and a.Activo=1 and c.Tipo=2
Group by m.Marca, a.Modelo, c.Descripcion, c.idCaracteristica, t.Total
order by c.Descripcion asc, proporcion asc

drop table ##tmpValores1

Select cf.Descripcion as 'Familia',t.*, P.Peso, Factor = t.Proporcion * p.Peso * -1
	into ##tmpMatriz
from ##tmpCargaMatriz1 t, 
	catCaracteristicas c, catFamilias cf, relPuntoFamilia r, catPuntosAdquisicion pa, Pareto p
where t.idCaracteristica=c.idCaracteristica and
	c.idFamilia=cf.idFamilia and cf.idFamilia=r.idFamilia and pa.idPunto=r.idPunto and pa.idPunto=p.idPunto

drop table ##tmpCargaMatriz1

/* C�lculo para tipo 1 : Incremental */
Select c.idCaracteristica, Total=sum(df.valor)
into ##tmpValores2
from CatMarcas m, catAutomovil a, FichaTecnica f, detFichaTecnica df, catCaracteristicas c
where m.idMarca=a.idMarca and f.idAutomovil=a.idautomovil and f.idFicha=df.idFicha and c.idCaracteristica=df.idCaracteristica and
	f.Activo=1 and a.Activo=1 and c.Tipo=1			-- <- Diferencia con tipo 2
Group by c.idCaracteristica

Select m.Marca, a.Modelo, c.Descripcion as 'Caracteristica', c.idCaracteristica,
	Proporcion=(sum(df.valor)/t.Total)  	-- <- Diferencia con tipo 2
into ##tmpCargaMatriz2
from CatMarcas m, catAutomovil a, FichaTecnica f, detFichaTecnica df, catCaracteristicas c, ##tmpValores2 t
where m.idMarca=a.idMarca and f.idAutomovil=a.idautomovil and f.idFicha=df.idFicha and 
	c.idCaracteristica=df.idCaracteristica and t.idCaracteristica=c.idCaracteristica and
	f.Activo=1 and a.Activo=1 and c.Tipo=1			-- <- Diferencia con tipo 2
Group by m.Marca, a.Modelo, c.Descripcion, c.idCaracteristica, t.Total
order by c.Descripcion asc, proporcion asc

drop table ##tmpValores2

insert into ##tmpMatriz
Select cf.Descripcion as 'Familia',t.*, P.Peso, Factor = t.Proporcion * p.Peso
from ##tmpCargaMatriz2 t, 
	catCaracteristicas c, catFamilias cf, relPuntoFamilia r, catPuntosAdquisicion pa, Pareto p
where t.idCaracteristica=c.idCaracteristica and
	c.idFamilia=cf.idFamilia and cf.idFamilia=r.idFamilia and pa.idPunto=r.idPunto and pa.idPunto=p.idPunto

drop table ##tmpCargaMatriz2

/* C�lculo para tipo 0 : Boleano */
Select m.Marca, a.Modelo, c.Descripcion as 'Caracteristica', c.idCaracteristica,
	Proporcion=df.Valor  	-- <- Diferencia con tipo 2
into ##tmpCargaMatriz3
from CatMarcas m, catAutomovil a, FichaTecnica f, detFichaTecnica df, catCaracteristicas c
where m.idMarca=a.idMarca and f.idAutomovil=a.idautomovil and f.idFicha=df.idFicha and 
	c.idCaracteristica=df.idCaracteristica and
	f.Activo=1 and a.Activo=1 and c.Tipo=0			-- <- Diferencia con tipo 2
order by c.Descripcion asc, proporcion asc

insert into ##tmpMatriz
Select cf.Descripcion as 'Familia',t.*, P.Peso, Factor = t.Proporcion * p.Peso
from ##tmpCargaMatriz3 t, 
	catCaracteristicas c, catFamilias cf, relPuntoFamilia r, catPuntosAdquisicion pa, Pareto p
where t.idCaracteristica=c.idCaracteristica and
	c.idFamilia=cf.idFamilia and cf.idFamilia=r.idFamilia and pa.idPunto=r.idPunto and pa.idPunto=p.idPunto

drop table ##tmpCargaMatriz3

/* Graba la matriz de pagos en la tabla seleccionada */
Declare @sql VarChar(500)
--Declare @NombreTabla VarChar(20)
--select @NombreTabla = Nombre from ##tmpAux

Set @sql = 'Select * into ' + @NombreTabla + ' from ##tmpMatriz Order by Marca, Modelo'
Exec (@sql)

drop table ##tmpMatriz
--drop table ##tmpAux