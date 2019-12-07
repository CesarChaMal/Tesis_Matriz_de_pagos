select * from pareto order by factor desc
select * from dbo.Matriz070906 order by Modelo, Descripcion

select * from dbo.view_MatrizBruta
where tipo=0 and punto like'%Comodidad%'
order by Modelo, Punto

select * from dbo.view_MatrizBruta
where tipo=0
order by Modelo, Punto

-- Verifica que todos los puntos tengan el mismo número de Items calificados
select Punto, Modelo, count(*)
from dbo.view_MatrizBruta
group by Punto, Modelo
Order  by Punto

/*
La idea está siendo que todo lo dejemos en valores entre 0 y 1 de forma que el 
cálculo sea para todos del tipo 0...
*/

-- Crea tabla puente para normailzar todos los tipos de características a 0
Select IdMarca, IdAutomovil, IdPunto, Valor, Factor
into ##tmpMatriz
from dbo.view_MatrizBruta   
Where Tipo=0

-- drop table ##tmpMatriz

-- Calcula la proporcion y el peso de los modelos incrementales (Tipo 1)
/*
Select Modelo, Punto, c.Descripcion,
	Proporcion = valor / (Select max(valor) from dbo.view_MatrizBruta x where x.idCaracteristica=m.idCaracteristica),
	Peso = Factor
from dbo.view_MatrizBruta m, catCaracteristicas c
Where m.Tipo=1 and m.idCaracteristica=c.idCaracteristica
Order by Modelo, c.Descripcion
*/
Insert into ##tmpMatriz
Select IdMarca, IdAutomovil, IdPunto,
	valor / (Select max(valor) from dbo.view_MatrizBruta x where x.idCaracteristica=m.idCaracteristica),
	factor
from dbo.view_MatrizBruta m, catCaracteristicas c
Where m.Tipo=1 and m.idCaracteristica=c.idCaracteristica
Order by Modelo, c.Descripcion

-- Calcula la proporcion y el peso de los modelos decrementales (Tipo 2)
/*
Select Modelo, Punto, c.Descripcion,
	Proporcion = 1 - (valor / (Select max(valor) from dbo.view_MatrizBruta x where x.idCaracteristica=m.idCaracteristica)),
	Peso = Factor
from dbo.view_MatrizBruta m, catCaracteristicas c
Where m.Tipo=2 and m.idCaracteristica=c.idCaracteristica
Order by Modelo, c.Descripcion
*/
Insert into ##tmpMatriz
Select IdMarca, IdAutomovil, IdPunto,
	1 - (valor / (Select max(valor) from dbo.view_MatrizBruta x where x.idCaracteristica=m.idCaracteristica)),
	Factor
from dbo.view_MatrizBruta m, catCaracteristicas c
Where m.Tipo=2 and m.idCaracteristica=c.idCaracteristica
Order by Modelo, c.Descripcion

-- Select * from #tmpMatriz

-- Calcula la proporcion de los modelos de acuerdo al punto de Pareto agrupando
-- por Puntos de Adquisicion (Familias de caracterìsticas)
Select IdMarca, IdAutomovil, IdPunto, 
	Proporcion=sum(valor)/convert(float,count(*)), Factor=max(Factor)
into ##tmpBase
from ##tmpMatriz
group by IdMarca, IdAutomovil, IdPunto
Order by IdMarca, IdAutomovil, IdPunto

-- Select * from ##tmpBase
-- drop table ##tmpBase

-- Calcula el peso por Punto de Adquisiciòn
Select a.Modelo, pa.Descripcion, t.Proporcion, t.Factor, Peso=t.Proporcion*t.Factor
into ##tmpMatrizPago
from ##tmpBase t, catAutomovil a, catPuntosAdquisicion pa
where t.idAutomovil=a.idAutomovil and t.idPunto=pa.IdPunto

-- Select * from ##tmpMatrizPago
-- drop table ##tmpMatrizPago

-- Càlculo por Modelo
Select Modelo, sum(Peso)
from ##tmpMatrizPago
group by Modelo
--having Modelo like '%clio%'
order by sum(Peso) desc