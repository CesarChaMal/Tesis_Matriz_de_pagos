
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER view [dbo].[view_MatrizBruta] as

select 
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
	a.activo=1 and f.activo=1
-- order by a.Modelo

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO