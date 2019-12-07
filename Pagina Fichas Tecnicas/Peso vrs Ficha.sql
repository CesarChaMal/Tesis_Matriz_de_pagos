select m.Marca, a.Modelo, f.Descripcion, count(*), Peso
from dbo.catAutomovil a, dbo.catMarcas m, dbo.FichaTecnica hf, 
	dbo.detFichaTecnica df, dbo.catCaracteristicas c, 
	dbo.catFamilias f, dbo.catPuntosAdquisicion pa, dbo.Pareto p
where a.idAutomovil=hf.idAutomovil and a.idMarca=m.idMarca and 
	hf.idFicha=df.idFicha and Anio=2007 and 
	df.idCaracteristica=c.idCaracteristica and 
	c.IdFamilia = f.IdFamilia and pa.idPunto=f.idFamilia and
	pa.idPunto=p.idPunto and 
	a.Activo=1 and c.Activo=1 and f.Activo=1 and pa.Activo=1
group by m.Marca, a.Modelo, f.Descripcion, Peso
order by m.marca, a.Modelo, f.Descripcion
