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

/*
-- esta es la vista de la Matriz Bruta
-- Modelo,anio,descripcion,valor,tipo,idautomovil,idcaracteristica,idfamilia,familia,idmarca,marca,idpunto,punto,factor

select 
	a.Modelo, f.anio, c.Descripcion as Caracteristica, d.Valor, c.Tipo, a.IdAutomovil, c.idCaracteristica, 
	c.idFamilia, Familia=c.descripcion, m.idMarca, m.Marca, pa.idPunto, 
	Punto=pa.Descripcion, p.factor
from 
	FichaTecnica f, detFichaTecnica d, catAutomovil a, catCaracteristicas c, 
	catFamilias cf, catMarcas m, relPuntoFamilia pf, catPuntosAdquisicion pa,
	pareto p
where 
	f.idFicha=d.idFicha and f.idAutomovil=a.idautomovil and 
	c.idcaracteristica=d.idcaracteristica and cf.idFamilia=c.idfamilia and
	m.idMarca=a.idmarca and cf.IdFamilia=pf.IdFamilia and pf.IdPunto=pa.IdPunto and
	p.idPunto=pa.idpunto and
	a.activo=1 and f.activo=1

select 
	a.Modelo, f.anio, c.Descripcion as Caracteristica, d.Valor, c.Tipo, a.IdAutomovil, c.idCaracteristica, 
	c.idFamilia, Familia=c.descripcion, m.idMarca, m.Marca, pa.idPunto, 
	Punto=pa.Descripcion, p.factor
into 
	#tmpMatrizBruta
from 
	FichaTecnica f, detFichaTecnica d, catAutomovil a, catCaracteristicas c, 
	catFamilias cf, catMarcas m, relPuntoFamilia pf, catPuntosAdquisicion pa,
	pareto p
where 
	f.idFicha=d.idFicha and f.idAutomovil=a.idautomovil and 
	c.idcaracteristica=d.idcaracteristica and cf.idFamilia=c.idfamilia and
	m.idMarca=a.idmarca and cf.IdFamilia=pf.IdFamilia and pf.IdPunto=pa.IdPunto and
	p.idPunto=pa.idpunto and
	a.activo=1 and f.activo=1

drop table #tmpMatrizBruta
*/

-- Insert into es para cuando ya existe la tabla y quiero agregar registros
-- Insert into #tmpMatriz Select idMarca, IdAutomovil, IdPunto, Valor, Factor from  dbo.view_MatrizBruta Where	Tipo=0

-- Select into es para cuando no existe la tabla y la quiero crear y agregar registros
-- Select idMarca, IdAutomovil, IdPunto, Valor, Factor into #tmpMatriz from dbo.view_MatrizBruta Where	Tipo=0


/*
La idea está siendo que todo lo dejemos en valores entre 0 y 1 de forma que el 
cálculo sea para todos del tipo 0...
*/

/* Cálculo para la Matriz Bruta */
SET @sql = 'SELECT '+
	'a.Modelo, f.anio, c.Descripcion as Caracteristica, d.Valor, c.Tipo, a.IdAutomovil, c.idCaracteristica ,'+ 
	'c.idFamilia, Familia=c.descripcion, m.idMarca, m.Marca, pa.idPunto, '+ 
	'Punto=pa.Descripcion, p.factor '+
'INTO '+
	'#tmpMatrizBruta '+
'FROM '+
	'FichaTecnica f, ' + @NombreTablaDetalles + ' d, catAutomovil a, catCaracteristicas c, '+
	'catFamilias cf, catMarcas m, relPuntoFamilia pf, catPuntosAdquisicion pa, '+
	'pareto p '+
'WHERE '+
	'f.idFicha=d.idFicha AND f.idAutomovil=a.idautomovil AND '+
	'c.idcaracteristica=d.idcaracteristica AND cf.idFamilia=c.idfamilia AND '+
	'm.idMarca=a.idmarca and cf.IdFamilia=pf.IdFamilia and pf.IdPunto=pa.IdPunto and '+
	'p.idPunto=pa.idpunto and '+
	'a.activo=1 and f.activo=1 '
EXEC (@sql)
/*
-- Select IdMarca, IdAutomovil, IdPunto, Valor, Factor
-- Select idfamilia,familia,marca,modelo,caracteristica,idcaracteristica,proporcion,factor,peso
Select idautomovil,idfamilia,familia,idmarca,marca,modelo,caracteristica,idcaracteristica,idpunto,valor,factor
into #tmpMatriz
from #tmpMatrizBruta
Where Tipo=0

Select IdMarca, IdAutomovil, IdPunto, Valor, Factor
into #tmpMatriz
from dbo.view_MatrizBruta   
Where Tipo=0
*/
-- Crea tabla puente para normailzar todos los tipos de características a 0
SELECT
	IdAutomovil,
	IdFamilia,
	Familia,
	IdMarca,
	Marca,
	Modelo,
	Caracteristica,
	IdCaracteristica,
	IdPunto,
	Valor,
	Factor
INTO
	#tmpMatriz
FROM
	#tmpMatrizBruta
WHERE
	Tipo=0

-- drop table #tmpMatriz

/*
Insert into #tmpMatriz
Select 
	IdMarca, 
	IdAutomovil, 
	IdPunto,
--	valor / (Select max(valor) from dbo.view_MatrizBruta x where x.idCaracteristica=m.idCaracteristica),
	valor / (Select max(valor) from #tmpMatrizBruta x where x.idCaracteristica=m.idCaracteristica),
	factor
from 
--	dbo.view_MatrizBruta m, 
	#tmpMatrizBruta m, 
	catCaracteristicas c
Where 
	m.Tipo=1 and 
	m.idCaracteristica=c.idCaracteristica
Order by 
	Modelo, 
	c.Descripcion
*/

/*
Insert into #tmpMatriz
Select 
	IdMarca, 
	IdAutomovil, 
	IdPunto,
	valor/(Select 
			max(valor) 
		from 
		       	(select 
				a.Modelo, f.anio, c.Descripcion, d.Valor, c.Tipo, a.IdAutomovil, c.idCaracteristica, 
				c.idFamilia, Familia=c.descripcion, m.idMarca, m.Marca, pa.idPunto, 
				Punto=pa.Descripcion, p.factor
			from 
				FichaTecnica f, detFichaTecnica d, catAutomovil a, catCaracteristicas c, 
				catFamilias cf, catMarcas m, relPuntoFamilia pf, catPuntosAdquisicion pa,
				pareto p
			where 
				f.idFicha=d.idFicha and f.idAutomovil=a.idautomovil and 
				c.idcaracteristica=d.idcaracteristica and cf.idFamilia=c.idfamilia and
				m.idMarca=a.idmarca and cf.IdFamilia=pf.IdFamilia and pf.IdPunto=pa.IdPunto and
				p.idPunto=pa.idpunto and
				a.activo=1 and f.activo=1) x 
		where 
			x.idCaracteristica=m.idCaracteristica),
	factor
from 
	(select 
		a.Modelo, f.anio, c.Descripcion, d.Valor, c.Tipo, a.IdAutomovil, c.idCaracteristica, 
		c.idFamilia, Familia=c.descripcion, m.idMarca, m.Marca, pa.idPunto, 
		Punto=pa.Descripcion, p.factor
	from 
		FichaTecnica f, detFichaTecnica d, catAutomovil a, catCaracteristicas c, 
		catFamilias cf, catMarcas m, relPuntoFamilia pf, catPuntosAdquisicion pa,
		pareto p
	where 
		f.idFicha=d.idFicha and f.idAutomovil=a.idautomovil and 
		c.idcaracteristica=d.idcaracteristica and cf.idFamilia=c.idfamilia and
		m.idMarca=a.idmarca and cf.IdFamilia=pf.IdFamilia and pf.IdPunto=pa.IdPunto and
		p.idPunto=pa.idpunto and
		a.activo=1 and f.activo=1) m, 
	catCaracteristicas c
Where 
	m.Tipo=1 and 
	m.idCaracteristica=c.idCaracteristica
Order by 
	Modelo, 
	c.Descripcion
*/

-- Calcula la proporcion y el peso de los modelos incrementales (Tipo 1)
INSERT INTO
	#tmpMatriz
SELECT
	IdAutomovil,
	m.IdFamilia,
	Familia,
	IdMarca,
	Marca,
	Modelo,
	Caracteristica,
	m.IdCaracteristica,
	IdPunto,
	Valor / (SELECT MAX(valor) FROM #tmpMatrizBruta x WHERE x.idCaracteristica=m.idCaracteristica),
	Factor
FROM
	#tmpMatrizBruta m,
	catCaracteristicas c
WHERE
	m.Tipo=1 AND
	m.idCaracteristica=c.idCaracteristica AND
	m.idFamilia=c.idFamilia
ORDER BY
	Modelo,
	c.Descripcion

/*
Insert into #tmpMatriz
Select 
	IdMarca, 
	IdAutomovil, 
	IdPunto,
--	1 - (valor / (Select max(valor) from dbo.view_MatrizBruta x where x.idCaracteristica=m.idCaracteristica)),
	1 - (valor / (Select max(valor) from #tmpMatrizBruta x where x.idCaracteristica=m.idCaracteristica)),
	factor
from 
--	dbo.view_MatrizBruta m, 
	#tmpMatrizBruta m, 
	catCaracteristicas c
Where 
	m.Tipo=1 and 
	m.idCaracteristica=c.idCaracteristica
Order by 
	Modelo, 
	c.Descripcion
*/
-- Calcula la proporcion y el peso de los modelos decrementales (Tipo 2)
INSERT INTO
	#tmpMatriz
SELECT
	IdAutomovil,
	m.IdFamilia,
	Familia,
	IdMarca,
	Marca,
	Modelo,
	Caracteristica,
	m.IdCaracteristica,
	IdPunto,
	1 - (valor / (SELECT MAX(valor) FROM #tmpMatrizBruta x WHERE x.idCaracteristica=m.idCaracteristica)),
	Factor
FROM
	#tmpMatrizBruta m,
	catCaracteristicas c
WHERE
	m.Tipo=2 AND
	m.idCaracteristica=c.idCaracteristica AND
	m.idFamilia=c.idFamilia
ORDER BY
	Modelo,
	c.Descripcion

-- select * from #tmpMatriz

-- Calcula la proporcion de los modelos de acuerdo al punto de Pareto agrupando
-- por Puntos de Adquisicion (Familias de caracterìsticas)
SELECT 
	IdMarca,
	IdAutomovil,
	IdPunto,
	Proporcion = SUM(valor)/CONVERT(FLOAT,COUNT(*)), 
	Factor=MAX(Factor)
INTO 
 	#tmpBase
FROM
	#tmpMatriz
GROUP BY 
	IdMarca,
	IdAutomovil,
	IdPunto
ORDER BY
	IdMarca, 
	IdAutomovil, 
	IdPunto
/*
-- Calcula la proporcion de los modelos de acuerdo alas caracterìsticas
SELECT 
	IdMarca,
	IdAutomovil,
	IdCaracteristica,
	Proporcion = SUM(valor)/CONVERT(FLOAT,COUNT(*)), 
	Factor=MAX(Factor)
INTO 
 	#tmpBase
FROM
	#tmpMatriz
GROUP BY 
	IdMarca,
	IdAutomovil,
	IdCaracteristica
ORDER BY
	IdMarca, 
	IdAutomovil, 
	IdCaracteristica
*/
-- drop table #tmpBase
-- Select * from #tmpBase

-- Calcula el peso por Punto de Adquisiciòn
SELECT 
	a.idAutomovil,
	a.idmarca,
	a.Modelo,
	pa.Descripcion as Punto,
	t.IdPunto,
	t.Proporcion, 
	t.Factor,
	Peso=t.Proporcion*t.Factor
INTO 
	#tmpMatrizPago
FROM 
	#tmpBase t, 
	catAutomovil a, 
	catPuntosAdquisicion pa
WHERE 
	t.idAutomovil=a.idAutomovil AND 
	t.idPunto=pa.IdPunto
/*
-- Calcula el peso por Caracteristicas
SELECT 
	a.idAutomovil,
	a.idmarca,
	a.Modelo,
	ct.Descripcion as Caracteristica,
	t.Proporcion, 
	t.Factor,
	Peso=t.Proporcion*t.Factor
INTO 
	#tmpMatrizPago
FROM 
	#tmpBase t, 
	catAutomovil a,
	catCaracteristicas ct
WHERE 
	t.idAutomovil=a.idAutomovil AND 
	a.idMarca=t.idMarca AND
	ct.idCaracteristica=t.idCaracteristica
*/

-- Select * from #tmpMatrizPago
-- drop table #tmpMatrizPago

/* Graba la matriz de pagos en la tabla seleccionada */
-- SELECT * FROM #tmpMatriz
-- SET @sql = 'SELECT * INTO ' + @NombreTabla + ' FROM #tmpMatrizPago ORDER BY Marca, Modelo'
SET @sql = 'SELECT * INTO ' + @NombreTabla + ' FROM #tmpMatrizPago'
EXEC (@sql)


SELECT 
	Modelo, Peso
FROM 
	#tmpMatrizPago
ORDER BY 
--	Peso DESC
	Modelo

SELECT 
	Modelo, SUM(Peso) pesototal
FROM 
	#tmpMatrizPago
GROUP BY
	Modelo
ORDER BY 
--	SUM(Peso) DESC
	Modelo

SELECT 
	Modelo, SUM(Peso) pesototal
FROM 
	#tmpMatrizPago
GROUP BY
	Modelo
ORDER BY 
	SUM(Peso) DESC

SELECT 
	Modelo, SUM(Peso) suma
FROM 
	#tmpMatrizPago
WHERE
	Modelo like '%clio%'
GROUP BY
	Modelo
ORDER BY 
	SUM(Peso) DESC

SELECT 
	Modelo, SUM(Peso) suma
FROM 
	#tmpMatrizPago
GROUP BY
	Modelo
HAVING 
	Modelo like '%clio%'
ORDER BY 
	SUM(Peso) DESC

select 
	a.Modelo, f.anio, c.Descripcion as Caracteristica, d.Valor, c.Tipo, a.IdAutomovil, c.idCaracteristica, 
	c.idFamilia, Familia=c.descripcion, m.idMarca, m.Marca, pa.idPunto, 
	Punto=pa.Descripcion, p.factor
from 
	FichaTecnica f, detFichaTecnica d, catAutomovil a, catCaracteristicas c, 
	catFamilias cf, catMarcas m, relPuntoFamilia pf, catPuntosAdquisicion pa,
	pareto p
where 
	f.idFicha=d.idFicha and f.idAutomovil=a.idautomovil and 
	c.idcaracteristica=d.idcaracteristica and cf.idFamilia=c.idfamilia and
	m.idMarca=a.idmarca and cf.IdFamilia=pf.IdFamilia and pf.IdPunto=pa.IdPunto and
	p.idPunto=pa.idpunto and
	a.activo=1 and f.activo=1

SELECT 
	m.marca as Marca,t.Modelo,Punto,t.idPunto,Proporcion,Factor,Peso
FROM 
	#tmpMatrizPago t, catPuntosAdquisicion pa, relPuntoFamilia pf, catFamilias cf, catMarcas m
where 
	t.idPunto=pa.idPunto and pf.IdPunto=pa.IdPunto
	and cf.idFamilia=pf.idFamilia and m.idMarca=t.idmarca

SELECT 
	t.Modelo,SUM(peso)
FROM 
	#tmpMatrizPago t, catPuntosAdquisicion pa, relPuntoFamilia pf, catFamilias cf, catMarcas m
where 
	t.idPunto=pa.idPunto and pf.IdPunto=pa.IdPunto
	and cf.idFamilia=pf.idFamilia and m.idMarca=t.idmarca
GROUP BY 
	modelo
ORDER BY 
	SUM(Peso) DESC

SELECT 
	Punto,SUM(peso)
FROM 
	#tmpMatrizPago t, catPuntosAdquisicion pa, relPuntoFamilia pf, catFamilias cf, catMarcas m
where 
	t.idPunto=pa.idPunto and pf.IdPunto=pa.IdPunto
	and cf.idFamilia=pf.idFamilia and m.idMarca=t.idmarca
GROUP BY 
	Punto
ORDER BY 
	SUM(Peso) DESC

-- Select * from #tmpMatrizPago

DROP TABLE #tmpMatriz


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
