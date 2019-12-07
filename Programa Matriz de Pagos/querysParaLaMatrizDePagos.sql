/* Crear las tablas y hacerle un select  */
declare @sql as varchar(1500)
declare @nombre as varchar(150)
set @nombre = 'Original'
set @sql = 'Exec detFichaTecnicaPersonalizado ''sc' + @nombre + 'FichaTecnica'''
select @sql as 'sql'
Exec (@sql)
set @sql = 'select *  from sc' + @nombre + 'FichaTecnica'
select @sql as 'sql'
Exec (@sql)

set @sql = 'Exec CargaMatrizPersonalizado ''sc' + @nombre + 'Matriz'',''sc' + @nombre + 'FichaTecnica'''
select @sql as 'sql'
Exec (@sql)
set @sql = 'select *  from sc' + @nombre + 'Matriz'
select @sql as 'sql'
Exec (@sql)


/* Lo mismo que el anterior pero en un procedimiento pasando como parametros el nombre de las tablas a crear */
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[createMatrixTables]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[createMatrixTables]
GO
Create Procedure createMatrixTables @nombre varChar(80) as
declare @sql as varchar(1500)
set @sql = 'Exec detFichaTecnicaPersonalizado ''sc' + @nombre + 'FichaTecnica'' '
select @sql as 'sql'
Exec (@sql)
set @sql = 'select *  from sc' + @nombre + 'FichaTecnica order by idFicha,idCaracteristica'
select @sql as 'sql'
Exec (@sql)

set @sql = 'Exec CargaMatrizPersonalizado ''sc' + @nombre + 'Matriz'',''sc' + @nombre + 'FichaTecnica'' '
select @sql as 'sql'
-- 'select '+@sql+' as ''sql'' ' +
Exec (@sql)
set @sql = 'select *  from sc' + @nombre + 'Matriz order by Marca,Modelo,Caracteristica'
select @sql as 'sql'
Exec (@sql)


/* Ejecucion del procediento anterior */
Exec createMatrixTables 'Original'
Exec createMatrixTables 'Cesar'


/* para crear las tablas usado en el codigo */
/* Lo mismo que el anterior pero en un procedimiento pasando como parametros el nombre de las tablas a crear */
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[createMatrizTables]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[createMatrizTables]
GO
Create Procedure createMatrizTables @nombre varChar(80) as
declare @sql as varchar(1500)
set @sql = 'Exec detFichaTecnicaPersonalizado ''sc' + @nombre + 'FichaTecnica'' '
Exec (@sql)
set @sql = 'Exec CargaMatrizPersonalizado ''sc' + @nombre + 'Matriz'',''sc' + @nombre + 'FichaTecnica'' '
Exec (@sql)


/* Ejecucion del procediento anterior */
Exec createMatrizTables 'Original'
Exec createMatrizTables 'Cesar'


/* Borrar las tablas */
declare @sql as varchar(1500)
declare @nombre as varchar(150)
set @nombre = 'Original'
set @sql = 'drop table sc' + @nombre + 'FichaTecnica'
select @sql as 'sql'
Exec (@sql)

set @sql = 'drop table sc' + @nombre + 'Matriz'
select @sql as 'sql'
Exec (@sql)


/* Borra si existen las tablas */
declare @sql as varchar(1500)
declare @nombre as varchar(150)
set @nombre = 'Original'
set @sql='if exists (select * from dbo.sysobjects where '+
'id = object_id(N''[dbo].[sc'+@nombre+'Matriz]'') and OBJECTPROPERTY(id, N''IsUserTable'') = 1) '+
'drop table [dbo].[sc'+@nombre+'Matriz]'
select @sql as 'sql'
Exec (@sql)

set @sql='if exists (select * from dbo.sysobjects where '+
'id = object_id(N''[dbo].[sc'+@nombre+'FichaTecnica]'') and OBJECTPROPERTY(id, N''IsUserTable'') = 1) '+
'drop table [dbo].[sc'+@nombre+'FichaTecnica]'
select @sql as 'sql'
Exec (@sql)


/* checa = 1 si existe y borra la tabla else checa = 0 si no existe y no borra la tabla */
declare @checa as varchar(5)
if exists (select * from dbo.sysobjects where 
id = object_id(N'[dbo].[scOriginalFichaTecnica]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
drop table [dbo].[scOriginalFichaTecnica]
set @checa = 1 
END
ELSE
BEGIN
set @checa = 0
END
select @checa as 'checa1'

if exists (select * from dbo.sysobjects where 
id = object_id(N'[dbo].[scOriginalMatriz]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
drop table [dbo].[scOriginalMatriz]
set @checa = 1 
END
ELSE
BEGIN
set @checa = 0
END
select @checa as 'checa2'


/* lo mismo que el anterior pero en en procedure y pasando como parametro el nombre */
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[deleteIfExists]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[deleteIfExists]
GO
Create Procedure deleteIfExists @nombre varChar(80) as
declare @sql as varchar(1500)
-- declare @nombre as varchar(150)
-- set @nombre = 'Original'
set @sql = 'declare @checa as varchar(5) '+
'if exists (select * from dbo.sysobjects where '+
'id = object_id(N''[dbo].[sc' + @nombre + 'FichaTecnica]'') and OBJECTPROPERTY(id, N''IsUserTable'') = 1) '+
'BEGIN '+
'drop table [dbo].[sc' + @nombre + 'FichaTecnica] '+
'set @checa = 1 '+
' END '+
'ELSE '+
'BEGIN '+
'set @checa = 0 '+
'END '+
'select @checa as ''checa1'''
-- ' PRINT @checa'
Exec (@sql)

set @sql = 'declare @checa as varchar(5) '+
'if exists (select * from dbo.sysobjects where '+
'id = object_id(N''[dbo].[sc' + @nombre + 'Matriz]'') and OBJECTPROPERTY(id, N''IsUserTable'') = 1) '+
'BEGIN '+
'drop table [dbo].[sc' + @nombre + 'Matriz] '+
'set @checa = 1 '+
' END '+
'ELSE '+
'BEGIN '+
'set @checa = 0 '+
'END '+
'select @checa as ''checa2'''
-- ' PRINT @checa'
Exec (@sql)


/* Ejecucion del procediento anterior */
Exec deleteIfExists 'Original'
Exec deleteIfExists 'Cesar'

/* lo mismo que el anterior pero en en procedure y pasando como parametro el nombre y sin borrar las tablas*/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ifExists]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[ifExists]
GO
Create Procedure ifExists @nombre varChar(80) as
declare @sql as varchar(1500)
-- declare @nombre as varchar(150)
-- set @nombre = 'Original'
set @sql = 'declare @checa as varchar(5) '+
'if exists (select * from dbo.sysobjects where '+
'id = object_id(N''[dbo].[sc' + @nombre + 'FichaTecnica]'') and OBJECTPROPERTY(id, N''IsUserTable'') = 1) '+
'BEGIN '+
'set @checa = 1 '+
' END '+
'ELSE '+
'BEGIN '+
'set @checa = 0 '+
'END '+
'select @checa as ''checa1'''+
'into ##tmp1 '
-- ' PRINT @checa'
Exec (@sql)

set @sql = 'declare @checa as varchar(5) '+
'if exists (select * from dbo.sysobjects where '+
'id = object_id(N''[dbo].[sc' + @nombre + 'Matriz]'') and OBJECTPROPERTY(id, N''IsUserTable'') = 1) '+
'BEGIN '+
'set @checa = 1 '+
' END '+
'ELSE '+
'BEGIN '+
'set @checa = 0 '+
'END '+
'select checa1,@checa as ''checa2'''+
'into ##tmp2 from ##tmp1 '+
'select * from ##tmp2 '
-- ' PRINT @checa'
Exec (@sql)
drop table ##tmp1
drop table ##tmp2

/* Ejecucion del procediento anterior */
Exec ifExists 'Original'

/* listado de todas las bases de datos del servidor */
EXEC sp_helpdb

/* listado de todas los objetos de cierta base de datos */
USE Tesis EXEC sp_help
--- o tambien para lo mismo --------------------------------------------------------------
EXEC sp_help

/* visualiza todos los objetos de la bd */
select * from dbo.sysobjects

/* visualiza en la bd todas las tablas del usuario */
select * from dbo.sysobjects where OBJECTPROPERTY(id, N'IsUserTable') = 1
--- o tambien para lo mismo --------------------------------------------------------------
select * from dbo.sysobjects where xtype='U'
--- o tambien para lo mismo --------------------------------------------------------------
select * from dbo.sysobjects where type='U'

/* busca en la bd la tabla 'scOriginalFichaTecnica' */
select * from dbo.sysobjects where 
id = object_id(N'[dbo].[scOriginalFichaTecnica]') and OBJECTPROPERTY(id, N'IsUserTable') = 1

/* busca en la bd la tablas que empiecen con sc y terminen con Matriz con cualquier palabra menos Original */
select * from dbo.sysobjects where 
name like 'sc%Matriz' and name <> 'scOriginalMatriz' and OBJECTPROPERTY(id, N'IsUserTable') = 1
--- o tambien para lo mismo --------------------------------------------------------------
select * from dbo.sysobjects where 
name like 'sc%Matriz' and not(name = 'scOriginalMatriz') and OBJECTPROPERTY(id, N'IsUserTable') = 1

/* busca en la bd la tablas que empiecen con sc y terminen con FichaTecnica con cualquier palabra menos Original */
select * from dbo.sysobjects where 
name like 'sc%FichaTecnica' and name <> 'scOriginalFichaTecnica' and OBJECTPROPERTY(id, N'IsUserTable') = 1


/* busca en la bd la tablas que empiecen con sc y terminen con Matriz con cualquier palabra menos Original y
tambien busca en la bd la tablas que empiecen con sc y terminen con FichaTecnica con cualquier palabra menos Original */
select name from dbo.sysobjects where 
(name like 'sc%Matriz' and name <> 'scOriginalMatriz' and OBJECTPROPERTY(id, N'IsUserTable') = 1)
or
(name like 'sc%FichaTecnica' and name <> 'scOriginalFichaTecnica' and OBJECTPROPERTY(id, N'IsUserTable') = 1)
order by name


/* los nombre de los escenarios en una tabla temporal cos 2 columnas una para las matrices y otra para las fichas Tecnicas*/
select name as Matriz into ##tmp1 from dbo.sysobjects 
where name like 'sc%Matriz' and OBJECTPROPERTY(id, N'IsUserTable') = 1 
order by name

select name as Ficha into ##tmp2 from dbo.sysobjects 
where name like 'sc%FichaTecnica' and OBJECTPROPERTY(id, N'IsUserTable') = 1
order by name

select Matriz /*into ##tablesNames */from ##tmp1,##tmp2

select Matriz,name as Ficha /*into ##tablesNames*/ from ##tmp1,dbo.sysobjects 
where name like 'sc%FichaTecnica' and OBJECTPROPERTY(id, N'IsUserTable') = 1
order by name

Select Modelo as 'Chevrolet' into ##tmp1 from scOriginalMatriz where Caracteristica = 'Catálogo de colores' and Marca='Chevrolet'
Select Modelo as 'Dodge'into ##tmp2 from scOriginalMatriz where Caracteristica = 'Catálogo de colores' and Marca='Dodge'
select Chevrolet,Dodge into ##tablesNames from ##tmp1,##tmp2

select Modelo Ficha into ##tablesNames from ##tmp1,##tmp2 where
(Matriz like 'sc%Matriz' )
AND
(Ficha like 'sc%FichaTecnica')
group by Matriz,Ficha
order by Matriz,Ficha

select * from ##tmp1
select * from ##tmp2
select * from ##tablesNames
	
drop table ##tmp1
drop table ##tmp2
drop table ##tablesNames

--------------------------------------------------------------------------------
select name as Matriz into ##tmp1 from dbo.sysobjects 
where name like 'sc%Matriz' and OBJECTPROPERTY(id, N'IsUserTable') = 1 
order by name

select * into ##tablesNames from ##tmp1
drop table ##tmp1

select name as Ficha into ##tmp2 from dbo.sysobjects where 
name like 'sc%FichaTecnica' and OBJECTPROPERTY(id, N'IsUserTable') = 1
order by name

insert into ##tablesNames select Ficha from ##tmp2
drop table ##tmp2

select * from ##tmp1
select * from ##tmp2
select * from ##tablesNames
	
drop table ##tmp1
drop table ##tmp2
drop table ##tablesNames




/* querys para el programa en php*/
----------------------------------------------------------------------------------------------------------------------------------
Select * from scOriginalFichaTecnica
Select * from scOriginalMatriz

Select idFamilia,Familia,Marca,Modelo,idCaracteristica,Caracteristica,Proporcion,Peso,Factor
from scOriginalMatriz
order by Marca,Modelo,Caracteristica,idCaracteristica asc

select Marca,Modelo,idFamilia,Familia,Caracteristica,idCaracteristica,Proporcion,Peso,Factor
from scOriginalMatriz c
group by Marca,Modelo,idFamilia,Familia,Caracteristica,idCaracteristica,Proporcion,Peso,Factor
order by Marca,Modelo,Caracteristica,idCaracteristica asc

-- order by Marca,Modelo,Caracteristica,idCaracteristica asc

select Marca,Modelo,sum(Peso) as 'Ranking'
from scOriginalMatriz c
group by Marca,Modelo
order by Marca,Modelo asc

/* Crea las tablas para los escenarios */
Exec createMatrixTables 'Original'

/* Borra las tablas de los escenarios si existen */
Exec deleteIfExists 'Original'

/* Checa si las tablas de los escenarios existen pero no las borra */
Exec ifExists 'Original'

/* Query que imprime todos los modelos con sus respectivas marcas */
Select Marca, Modelo from scOriginalMatriz
group by Marca, Modelo
Order by Marca, Modelo asc

/* Query que imprime todos los caracteristicas ,el id de la misma y sus respectivas familia y el id de las mismas */
Select idFamilia,Familia,idCaracteristica,Caracteristica from scOriginalMatriz
group by idFamilia,Familia,idCaracteristica,Caracteristica 
Order by Caracteristica,idCaracteristica asc

/* Query que imprime todos los modelos con sus repectivas marcas ,la caracteristica y su id , su familia y su id
 y el valor por cada modelo */
SELECT f.Marca,e.Modelo,b.idFamilia,b.Descripcion as Familia,a.IdCaracteristica,a.Descripcion as Caracteristica,d.Valor
FROM catCaracteristicas a, catFamilias b ,FichaTecnica c, scOriginalFichaTecnica d, catAutomovil e, catMarcas f
WHERE a.IdFamilia=b.IdFamilia and a.IdCaracteristica=d.IdCaracteristica and c.IdFicha=d.IdFicha and c.IdAutomovil=e.IdAutomovil and e.IdMarca=f.IdMarca
and a.Activo=1 and b.Activo=1 and c.Activo=1 and e.Activo=1 and f.Activo=1
order by f.Marca,e.Modelo,Caracteristica,a.idCaracteristica asc

/* Query que imprime todos los modelos con sus repectivas marcas ,la caracteristica y su id , su familia y su id
 y la Proporcion por cada modelo */
select Marca,Modelo,idFamilia,Familia,Caracteristica,idCaracteristica,Proporcion
from scOriginalMatriz c
group by Marca,Modelo,idFamilia,Familia,Caracteristica,idCaracteristica,Proporcion
order by Marca,Modelo,Caracteristica,idCaracteristica asc

/* Query que imprime todos los modelos con sus repectivas marcas ,la caracteristica y su id , su familia y su id
 y el peso por cada modelo */
select Marca,Modelo,idFamilia,Familia,Caracteristica,idCaracteristica,Peso 
from scOriginalMatriz c
group by Marca,Modelo,idFamilia,Familia,Caracteristica,idCaracteristica,Peso 
order by Marca,Modelo,Caracteristica,idCaracteristica asc

/* Query que imprime todos los modelos con sus repectivas marcas ,la caracteristica y su id , su familia y su id
 y el Factor por cada modelo */
select Marca,Modelo,idFamilia,Familia,Caracteristica,idCaracteristica,Factor
from scOriginalMatriz c
group by Marca,Modelo,idFamilia,Familia,Caracteristica,idCaracteristica,Factor
order by Marca,Modelo,Caracteristica,idCaracteristica asc

/* Query que imprime todos los modelos con sus repectivas marcas e imprime el ranking que es la suma del factor de todas las
caracteristicas por modelo */
select Marca,Modelo,sum(Peso) as 'Ranking'
from scOriginalMatriz c
group by Marca,Modelo
order by Marca,Modelo asc

----------------------------------------------------------------------------------------------------------------------------------

Select Marca, Modelo, sum(Peso)as 'Ranking' from scOriginalMatriz
group by Marca, Modelo
Order by 'Ranking' desc

/*
Select c.Marca, c.Modelo ,c.Caracteristica,c.idCaracteristica, cd.valor from scCesarMatriz c,scCesarFichaTecnica cd,FichaTecnica f
where c.idCaracteristica=cd.idCaracteristica and f.Activo=1 and f.idFicha=cd.idFicha
group by c.Marca, c.Modelo,c.Caracteristica,c.idCaracteristica, cd.valor
Order by c.Marca,c.Modelo, c.Caracteristica
*/

SELECT c.IdFicha, f.Marca, e.Modelo, d.Valor,a.Descripcion as Caracteristica,a.IdCaracteristica,  c.Anio, a.Tipo, b.IdFamilia, b.Descripcion as Familia
FROM catCaracteristicas a, catFamilias b ,FichaTecnica c, scOriginalFichaTecnica d, catAutomovil e, catMarcas f
WHERE a.IdFamilia=b.IdFamilia and a.IdCaracteristica=d.IdCaracteristica and c.IdFicha=d.IdFicha and c.IdAutomovil=e.IdAutomovil and e.IdMarca=f.IdMarca
and a.Activo=1 and b.Activo=1 and c.Activo=1 and e.Activo=1 and f.Activo=1
order by f.Marca,e.Modelo,Caracteristica

SELECT * FROM
	(SELECT c.IdFicha, f.Marca, e.Modelo, d.Valor,a.Descripcion as Caracteristica,a.IdCaracteristica,  c.Anio, a.Tipo, b.IdFamilia, b.Descripcion as Familia
	FROM catCaracteristicas a, catFamilias b ,FichaTecnica c, scOriginalFichaTecnica d, catAutomovil e, catMarcas f
	WHERE a.IdFamilia=b.IdFamilia and a.IdCaracteristica=d.IdCaracteristica and c.IdFicha=d.IdFicha and c.IdAutomovil=e.IdAutomovil and e.IdMarca=f.IdMarca
	and a.Activo=1 and b.Activo=1 and c.Activo=1 and e.Activo=1 and f.Activo=1
	) as Original
INNER JOIN scOriginalMatriz Matriz ON (Original.Familia=Matriz.Familia AND Original.Marca=Matriz.Marca AND 
Original.Modelo=Matriz.Modelo AND Original.Caracteristica=Matriz.Caracteristica AND Original.idCaracteristica=Matriz.idCaracteristica)
ORDER BY Matriz.Marca,Matriz.Modelo,Matriz.Caracteristica,Matriz.idCaracteristica

select *
from scOriginalMatriz c
order by Marca,Modelo,Caracteristica asc

select Modelo,Caracteristica, sum(factor) as 'Ranking'
from scOriginalMatriz c
group by Modelo,Caracteristica
order by sum(factor) desc

/*
SELECT c.IdFicha, e.Modelo, f.Marca, c.Anio, a.IdCaracteristica, a.Descripcion as Caracteristica, a.Tipo, b.IdFamilia, b.Descripcion as Familia ,d.Valor
FROM catCaracteristicas a, catFamilias b ,FichaTecnica c, scCesarFichaTecnica d, catAutomovil e, catMarcas f
WHERE a.IdFamilia=b.IdFamilia and a.IdCaracteristica=d.IdCaracteristica and c.IdFicha=d.IdFicha and c.IdAutomovil=e.IdAutomovil and e.IdMarca=f.IdMarca
and a.Activo=1 and b.Activo=1 and c.Activo=1 and e.Activo=1 and f.Activo=1
order by c.IdFicha,Caracteristica
*/

select * from scOriginalFichaTecnica

select Marca, Modelo, idCaracteristica, Caracteristica, Proporcion, Peso, Factor from scOriginalMatriz
Order by Marca, Modelo,idCaracteristica ,Caracteristica


Select Marca, Modelo from scOriginalMatriz
group by Marca, Modelo
Order by Marca, Modelo

Select Familia, Caracteristica from scOriginalMatriz
group by Familia, Caracteristica
Order by Familia, Caracteristica

select b.Marca as 'Marca', a.Modelo as 'Modelo', de.Valor as 'Precio del Mantenimiento acumulado a 60,000 Km' from scOriginalFichaTecnica de , catCaracteristicas ca ,catFamilias caf,fichaTecnica f,catAutomovil a,catMarcas b
where de.idCaracteristica = 24 and de.idCaracteristica = ca.idCaracteristica and ca.idFamilia=caf.idFamilia
and f.idFicha=de.idFicha and a.IdAutomovil=f.IdAutomovil and a.IdMarca=b.IdMarca and ca.Activo=1 and caf.Activo=1 and
f.Activo=1 and a.Activo=1 and b.Activo=1
group by Marca,Modelo,de.Valor
order by Marca,Modelo,de.Valor

select left(t.modelo,6) as 'Modelo', sum(factor) as 'Total Factor'
from scOriginalMatriz t, catFamilias f, catcaracteristicas c
where t.idcaracteristica=c.idcaracteristica and c.idfamilia=f.idfamilia
group by left(t.modelo, 6)
order by sum(factor) desc

select Marca,left(c.Modelo,80) as 'Modelo', sum(factor) as 'Total Factor'
from scOriginalMatriz c
group by Marca,left(c.Modelo,80)
order by sum(factor) desc

select Modelo,Caracteristica, sum(c.factor) as 'Total Factor'
from scOriginalMatriz c
group by Modelo,Caracteristica
order by sum(c.factor) desc

select Modelo,Caracteristica,d.valor,sum(factor) as 'Total Factor'
from scOriginalMatriz c, scOriginalFichaTecnica d
where c.IdCaracteristica=d.IdCaracteristica
group by Modelo,Caracteristica,d.valor
order by sum(factor) desc

select Marca,Modelo,Caracteristica, sum(factor) as 'Total Factor'
from scOriginalMatriz c
group by Marca,Modelo,Caracteristica
order by Marca,Modelo,Caracteristica

select c.Modelo,c.Caracteristica,d.valor
from scOriginalMatriz c, scOriginalFichaTecnica d
where c.IdCaracteristica=d.IdCaracteristica
group by c.Modelo,c.Caracteristica,d.valor
order by c.Modelo

/*
select * from catCaracteristicas where descripcion='Sensor movimiento interno'
select * from catCaracteristicas where IdCaracteristica=20
select * from catAutomovil where Modelo like 'Matiz%'
select * from dbo.FichaTecnica where IdAutomovil in ('290','291','292')
select * from dbo.detFichaTecnica where IdFicha in ('150','151','152')
select * from dbo.detFichaTecnica where IdFicha in ('150','151','152') And idCaracteristica=31
select * from detFichaTecnica d ,catCaracteristicas c where d.IdFicha in ('150','151','152') And c.idCaracteristica=d.idCaracteristica

select d.IdFicha,cm.Marca,ct.Modelo,c.idCaracteristica,c.Descripcion,c.idFamilia,d.Valor,c.Tipo,c.Activo 
from catAutomovil ct, catMarcas cm,detFichaTecnica d ,catCaracteristicas c ,FichaTecnica f
where d.IdFicha in ('1','10','15') And c.idCaracteristica=d.idCaracteristica and ct.IdMarca=cm.IdMarca and ct.Activo=1 
and cm.Activo=1 and c.idCaracteristica=d.idCaracteristica and f.IdFicha=d.IdFicha
group by d.IdFicha,cm.Marca,ct.Modelo
order by d.IdFicha

*/
