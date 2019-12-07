Declare @Total int

select 'Renombre de Modelo'

select Modelo into ##tmpModelo	--Incluye comparados
from dbo.ComparacionAutomovil c, catautomovil a
where c.idautomovil=a.idautomovil -- and a.activo=1

Insert into ##tmpModelo 
select Modelo			-- Incluye comprados
from encuesta e, dbo.catAutomovil a
where e.idautomovil=a.idautomovil-- and a.activo=1

Select @Total=count(*) from ##tmpModelo

select Modelo, (Convert(real,Count(*))/@Total)*100
from ##tmpModelo
Group by Modelo
Order by count(*) desc

drop table ##tmpModelo


select 'Renombre de Marca'

select Marca into ##tmpMarca	--Incluye comparados
from dbo.ComparacionAutomovil c, catautomovil a, catMarcas m
where c.idautomovil=a.idautomovil and a.idMarca=m.idMarca and m.activo=1

Insert into ##tmpMarca
select Marca			-- Incluye comprados
from encuesta e, dbo.catAutomovil a, catMarcas m
where e.idautomovil=a.idautomovil and a.idMarca=m.idMarca and m.activo=1

Select @Total=count(*) from ##tmpMarca

select Marca, (Convert(real,Count(*))/@Total)*100
from ##tmpMarca
Group by Marca
Order by count(*) desc

drop table ##tmpMarca


/*

Coches comparados. No incluye comprados.

select 'Renombre de Modelo'
--Declare @Total int
--Select @Total=count(*) from dbo.Encuesta where activo=1
select Modelo, (Convert(real,Count(*))/@Total)*100
from dbo.ComparacionAutomovil c, catautomovil a
where c.idautomovil=a.idautomovil and a.activo=1
Group by Modelo
Order by count(*) desc

select 'Renombre de Marca'
--Declare @Total int
--Select @Total=count(*) from dbo.Encuesta where activo=1
select Marca, (Convert(real,Count(*))/@Total)*100
from dbo.ComparacionAutomovil c, catautomovil a, catMarcas b
where c.idautomovil=a.idautomovil and a.idMarca=b.idMarca and a.activo=1 and b.Activo=1
Group by Marca
Order by count(*) desc

*/

/*

Coches Comprados. No incluye comparados

select 'Renombre de Modelo'
--Declare @Total int
--Select @Total=count(*) from dbo.Encuesta where activo=1
select Modelo, (Convert(real,Count(*))/@Total)*100
from dbo.Encuesta c, catautomovil a
where c.idautomovil=a.idautomovil and a.activo=1
Group by Modelo
Order by count(*) desc

select 'Renombre de Marca'
--Declare @Total int
--Select @Total=count(*) from dbo.Encuesta where activo=1
select Marca, (Convert(real,Count(*))/@Total)*100
from dbo.Encuesta c, catautomovil a, catMarcas b
where c.idautomovil=a.idautomovil and a.idMarca=b.idMarca and a.activo=1 and b.Activo=1
Group by Marca
Order by count(*) desc

*/