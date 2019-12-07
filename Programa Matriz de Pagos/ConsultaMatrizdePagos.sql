if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Cesar]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Cesar]

Exec CargaMatriz 'Cesar'

Select Marca, Modelo, sum(Factor)as 'Total Factor' from Cesar
group by Marca, Modelo
Order by 'Total Factor' desc

select Marca, Modelo, Familia, Caracteristica, Proporcion, Peso, Factor from cesar
Order by Marca, Modelo, Familia, Caracteristica


Select Marca, Modelo from cesar
group by Marca, Modelo
Order by Marca, Modelo

Select Familia, Caracteristica from cesar
group by Familia, Caracteristica
Order by Familia, Caracteristica

