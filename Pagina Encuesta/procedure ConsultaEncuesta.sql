create procedure ConsultaEncuesta 
	@idEncuesta int
as

Select 'Encuesta'
select e.IdEncuesta, Q1=Case e.Compra4Anios When 1 then 'Si' else 'No' end, Q2=Convert(char(10),e.Fecha,103), 
	Q3=e.TiempoDeCompra, Q4=m.Descripcion, Q5=Case e.Nuevo When 1 then 'Nuevo' else 'Usado' end, Q6=p.Descripcion,
	Q7=ma.Marca+' '+a.Modelo, Q8=Costo, Q8_1=Case e.Seguro When 1 then 'Si' else 'No' end, Q11=Case e.InfluenciaVendedor When 1 then 'Si' else 'No' end,
	Q12=s.Descripcion, Q13=u.Descripcion, 
	Q14=Case e.RangoEdad
		When 1 then '<= 25' 
		When 2 then '26 < edad <= 35'
		When 3 then '36 < edad <= 45'
		When 4 then '> 45'
		else 'E R R O R' 
		end,
	Q15=c.Descripcion, Q16=Case e.Sexo When 1 then 'H' else 'M' end, Q17=l.Descripcion, Q18=en.Descripcion
from Encuesta e, catMotivos m, catMedioPago p, catAutomovil a, catMarcas ma, catComoSupo s, catUsoPrimario u,
	catEstadoCivil c, catLugares l, catEntrevistadores en
where e.idMotivo=m.idMotivo and e.idMedioPago=p.idMedioPago and e.idAutomovil=a.idAutomovil and a.idMarca=ma.idMarca
	and e.idComoSupo=s.idComoSupo and e.idUsoPrimario=u.idUsoPrimario and e.idEstadoCivil=c.idEstadoCivil
	and e.idLugar=l.idLugar and e.idEntrevistador=en.idEntrevistador
	and idEncuesta=@idEncuesta

Select 'Marcas/modelos comparadas'
Select Modelo=m.Marca+' '+a.Modelo
from ComparacionAutomovil c, catAutomovil a, catMarcas m
Where c.idAutomovil=a.idAutomovil and a.idMarca=m.idMarca and IdEncuesta=@idEncuesta
Order by Orden

Select 'Puntos de desición'
Select p.Descripcion
from PuntoAdquisicion a, catPuntosAdquisicion p
Where a.idPunto=p.idPunto and a.IdEncuesta=@idEncuesta
Order by a.IdEncuesta, a.Orden
-----------------------------------------------------------------------------------------------------
-- Exec ConsultaEncuesta 50