select m.Marca, a.Modelo, f.Descripcion, sum(Valor)
from dbo.catAutomovil a, dbo.catMarcas m, dbo.FichaTecnica hf, 
	dbo.detFichaTecnica df, dbo.catCaracteristicas c, 
	dbo.catFamilias f
where a.idAutomovil=hf.idAutomovil and a.idMarca=m.idMarca and 
	hf.idFicha=df.idFicha and Anio=2007 and 
	df.idCaracteristica=c.idCaracteristica and 
	c.IdFamilia = f.IdFamilia and 
	a.Activo=1 and c.Activo=1 and f.Activo=1 and
	f.idFamilia=1 --Precio
Group by m.marca, a.Modelo, f.Descripcion

Union

select m.Marca, a.Modelo, f.Descripcion, sum(Valor)
from dbo.catAutomovil a, dbo.catMarcas m, dbo.FichaTecnica hf, 
	dbo.detFichaTecnica df, dbo.catCaracteristicas c, 
	dbo.catFamilias f
where a.idAutomovil=hf.idAutomovil and a.idMarca=m.idMarca and 
	hf.idFicha=df.idFicha and Anio=2007 and 
	df.idCaracteristica=c.idCaracteristica and 
	c.IdFamilia = f.IdFamilia and 
	a.Activo=1 and c.Activo=1 and f.Activo=1 and
	f.idFamilia=2 --Rendimiento de combustible
Group by m.marca, a.Modelo, f.Descripcion

Union

select m.Marca, a.Modelo, f.Descripcion, sum(Valor)
from dbo.catAutomovil a, dbo.catMarcas m, dbo.FichaTecnica hf, 
	dbo.detFichaTecnica df, dbo.catCaracteristicas c, 
	dbo.catFamilias f
where a.idAutomovil=hf.idAutomovil and a.idMarca=m.idMarca and 
	hf.idFicha=df.idFicha and Anio=2007 and 
	df.idCaracteristica=c.idCaracteristica and 
	c.IdFamilia = f.IdFamilia and 
	a.Activo=1 and c.Activo=1 and f.Activo=1 and
	f.idFamilia=3 and valor>0 --Comodidad
Group by m.marca, a.Modelo, f.Descripcion


Union

select m.Marca, a.Modelo, f.Descripcion, sum(Valor)
from dbo.catAutomovil a, dbo.catMarcas m, dbo.FichaTecnica hf, 
	dbo.detFichaTecnica df, dbo.catCaracteristicas c, 
	dbo.catFamilias f
where a.idAutomovil=hf.idAutomovil and a.idMarca=m.idMarca and 
	hf.idFicha=df.idFicha and Anio=2007 and 
	df.idCaracteristica=c.idCaracteristica and 
	c.IdFamilia = f.IdFamilia and 
	a.Activo=1 and c.Activo=1 and f.Activo=1 and
	f.idFamilia=5 --Bajo costo de mantenimiento
Group by m.marca, a.Modelo, f.Descripcion

Union

select m.Marca, a.Modelo, f.Descripcion, sum(Valor)
from dbo.catAutomovil a, dbo.catMarcas m, dbo.FichaTecnica hf, 
	dbo.detFichaTecnica df, dbo.catCaracteristicas c, 
	dbo.catFamilias f
where a.idAutomovil=hf.idAutomovil and a.idMarca=m.idMarca and 
	hf.idFicha=df.idFicha and Anio=2007 and 
	df.idCaracteristica=c.idCaracteristica and 
	c.IdFamilia = f.IdFamilia and 
	a.Activo=1 and c.Activo=1 and f.Activo=1 and
	f.idFamilia=6 and valor>0 --Seguridad
Group by m.marca, a.Modelo, f.Descripcion

Union

select m.Marca, a.Modelo, f.Descripcion, sum(Valor)
from dbo.catAutomovil a, dbo.catMarcas m, dbo.FichaTecnica hf, 
	dbo.detFichaTecnica df, dbo.catCaracteristicas c, 
	dbo.catFamilias f
where a.idAutomovil=hf.idAutomovil and a.idMarca=m.idMarca and 
	hf.idFicha=df.idFicha and Anio=2007 and 
	df.idCaracteristica=c.idCaracteristica and 
	c.IdFamilia = f.IdFamilia and 
	a.Activo=1 and c.Activo=1 and f.Activo=1 and
	f.idFamilia=7 --Potencia
Group by m.marca, a.Modelo, f.Descripcion

Union

select m.Marca, a.Modelo, f.Descripcion, count(co.Activo)
from dbo.catAutomovil a, dbo.catMarcas m, dbo.FichaTecnica hf, 
	dbo.detFichaTecnica df, dbo.catCaracteristicas c, 
	dbo.catFamilias f, dbo.Colores co
where a.idAutomovil=hf.idAutomovil and a.idMarca=m.idMarca and 
	hf.idFicha=df.idFicha and hf.idFicha=co.idFicha and Anio=2007 and 
	df.idCaracteristica=c.idCaracteristica and 
	c.IdFamilia = f.IdFamilia and 
	a.Activo=1 and c.Activo=1 and f.Activo=1 and co.Activo=1 and
	f.idFamilia=8 --Color
Group by m.marca, a.Modelo, f.Descripcion

Union

select m.Marca, a.Modelo, f.Descripcion, Count(Valor)
from dbo.catAutomovil a, dbo.catMarcas m, dbo.FichaTecnica hf, 
	dbo.detFichaTecnica df, dbo.catCaracteristicas c, 
	dbo.catFamilias f
where a.idAutomovil=hf.idAutomovil and a.idMarca=m.idMarca and 
	hf.idFicha=df.idFicha and Anio=2007 and 
	df.idCaracteristica=c.idCaracteristica and 
	c.IdFamilia = f.IdFamilia and 
	a.Activo=1 and c.Activo=1 and f.Activo=1 and
	f.idFamilia=9 and valor>0 --Equipamento
Group by m.marca, a.Modelo, f.Descripcion

Union

select m.Marca, a.Modelo, f.Descripcion, Count(Valor)
from dbo.catAutomovil a, dbo.catMarcas m, dbo.FichaTecnica hf, 
	dbo.detFichaTecnica df, dbo.catCaracteristicas c, 
	dbo.catFamilias f
where a.idAutomovil=hf.idAutomovil and a.idMarca=m.idMarca and 
	hf.idFicha=df.idFicha and Anio=2007 and 
	df.idCaracteristica=c.idCaracteristica and 
	c.IdFamilia = f.IdFamilia and 
	a.Activo=1 and c.Activo=1 and f.Activo=1 and
	f.idFamilia=10 and valor>0 --Renombre de la marca
Group by m.marca, a.Modelo, f.Descripcion