select 'Costo de Mantenimiento' 
select a.idFicha,a.idCaracteristica,a.Valor, b.IdAutomovil, c.Modelo, d.Marca from detFichatecnica a,FichaTecnica b, catAutomovil c, catMarcas d 
where a.idCaracteristica=24 and b.idFicha=a.IdFicha and c.IdAutomovil=b.IdAutomovil and c.IdMarca=d.IdMarca 
and b.Activo=1 and d.Activo=1 and c.Activo=1 
and a.Valor>-1 and a.Valor<=1
order by d.Marca

select 'Rendimiento de la Gasolina km/lt' 
select a.idFicha,a.idCaracteristica,a.Valor, b.IdAutomovil, c.Modelo, d.Marca from detFichatecnica a,FichaTecnica b, catAutomovil c, catMarcas d 
where a.idCaracteristica=2 and b.idFicha=a.IdFicha and c.IdAutomovil=b.IdAutomovil and c.IdMarca=d.IdMarca 
and b.Activo=1 and d.Activo=1 and c.Activo=1 
and a.Valor>-1 and a.Valor<=1
order by d.Marca