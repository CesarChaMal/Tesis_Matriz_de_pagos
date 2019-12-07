/* Cálculo para tipo 2 */
Select c.idCaracteristica, Total=sum(df.valor)
into ##tmpValores
from CatMarcas m, catAutomovil a, FichaTecnica f, detFichaTecnica df, catCaracteristicas c
where m.idMarca=a.idMarca and f.idAutomovil=a.idautomovil and f.idFicha=df.idFicha and c.idCaracteristica=df.idCaracteristica and
	f.Activo=1 and c.Tipo=2
Group by c.idCaracteristica

Select m.Marca, a.Modelo, c.Descripcion, c.idCaracteristica,
	Proporcion=1-(sum(df.valor)/t.Total)
into ##tmpCargaMatriz
from CatMarcas m, catAutomovil a, FichaTecnica f, detFichaTecnica df, catCaracteristicas c, ##tmpValores t
where m.idMarca=a.idMarca and f.idAutomovil=a.idautomovil and f.idFicha=df.idFicha and 
	c.idCaracteristica=df.idCaracteristica and t.idCaracteristica=c.idCaracteristica and
	f.Activo=1 and c.Tipo=2
Group by m.Marca, a.Modelo, c.Descripcion, c.idCaracteristica, t.Total
order by c.Descripcion asc, proporcion asc

drop table ##tmpValores

Select t.*, P.Peso, Factor = t.Proporcion * p.Peso
from ##tmpCargaMatriz t, 
	catCaracteristicas c, catFamilias cf, relPuntoFamilia r, catPuntosAdquisicion pa, Pareto p
where t.idCaracteristica=c.idCaracteristica and
	c.idFamilia=cf.idFamilia and cf.idFamilia=r.idFamilia and pa.idPunto=r.idPunto and pa.idPunto=p.idPunto

drop table ##tmpCargaMatriz



/* Cálculo para tipo 1 */
Select c.idCaracteristica, Total=sum(df.valor)
into ##tmpValores
from CatMarcas m, catAutomovil a, FichaTecnica f, detFichaTecnica df, catCaracteristicas c
where m.idMarca=a.idMarca and f.idAutomovil=a.idautomovil and f.idFicha=df.idFicha and c.idCaracteristica=df.idCaracteristica and
	f.Activo=1 and c.Tipo=1			-- <- Diferencia con tipo 2
Group by c.idCaracteristica

Select m.Marca, a.Modelo, c.Descripcion, c.idCaracteristica,
	Proporcion=(sum(df.valor)/t.Total)  	-- <- Diferencia con tipo 2
into ##tmpCargaMatriz
from CatMarcas m, catAutomovil a, FichaTecnica f, detFichaTecnica df, catCaracteristicas c, ##tmpValores t
where m.idMarca=a.idMarca and f.idAutomovil=a.idautomovil and f.idFicha=df.idFicha and 
	c.idCaracteristica=df.idCaracteristica and t.idCaracteristica=c.idCaracteristica and
	f.Activo=1 and c.Tipo=1			-- <- Diferencia con tipo 2
Group by m.Marca, a.Modelo, c.Descripcion, c.idCaracteristica, t.Total
order by c.Descripcion asc, proporcion asc

drop table ##tmpValores

Select t.*, P.Peso, Factor = t.Proporcion * p.Peso
from ##tmpCargaMatriz t, 
	catCaracteristicas c, catFamilias cf, relPuntoFamilia r, catPuntosAdquisicion pa, Pareto p
where t.idCaracteristica=c.idCaracteristica and
	c.idFamilia=cf.idFamilia and cf.idFamilia=r.idFamilia and pa.idPunto=r.idPunto and pa.idPunto=p.idPunto

drop table ##tmpCargaMatriz


/* Cálculo para tipo 0 */
Select m.Marca, a.Modelo, c.Descripcion, c.idCaracteristica,
	Proporcion=df.Valor  	-- <- Diferencia con tipo 2
into ##tmpCargaMatriz
from CatMarcas m, catAutomovil a, FichaTecnica f, detFichaTecnica df, catCaracteristicas c
where m.idMarca=a.idMarca and f.idAutomovil=a.idautomovil and f.idFicha=df.idFicha and 
	c.idCaracteristica=df.idCaracteristica and
	f.Activo=1 and c.Tipo=0			-- <- Diferencia con tipo 2
order by c.Descripcion asc, proporcion asc

Select t.*, P.Peso, Factor = t.Proporcion * p.Peso
from ##tmpCargaMatriz t, 
	catCaracteristicas c, catFamilias cf, relPuntoFamilia r, catPuntosAdquisicion pa, Pareto p
where t.idCaracteristica=c.idCaracteristica and
	c.idFamilia=cf.idFamilia and cf.idFamilia=r.idFamilia and pa.idPunto=r.idPunto and pa.idPunto=p.idPunto

drop table ##tmpCargaMatriz