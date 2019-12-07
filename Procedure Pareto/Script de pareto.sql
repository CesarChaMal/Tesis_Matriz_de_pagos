if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CargaPareto]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[CargaPareto]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/* Script para creación del proceso para generar Pareto */

Create Procedure CargaPareto as

-- Elimina registros anteriores
Delete Pareto

-- Declaración de variables
-- Declare @Id int, @Descripcion VarChar(30), @Puntaje int, @Acumulador int, @Total int, @Peso real
Declare @Id int, @Descripcion VarChar(30), @Puntaje int, @Acumulador int, @Total int, @Factor real
Select @Total=count(*)
	from PuntoAdquisicion a, catPuntosAdquisicion b
	Where a.idPunto=b.idPunto and b.Activo=1
Set @Acumulador=0  --El set indica operación entre variables de memoria, NO CAMPOS

-- Creación del cursor
Declare Pareto Cursor For
Select b.IdPunto, b.Descripcion,count(a.IdPunto) as 'Total Punto'
from PuntoAdquisicion a, catPuntosAdquisicion b
Where a.idPunto=b.idPunto and b.Activo=1
group by b.IdPunto, b.Descripcion 
order by 'Total Punto' asc

-- Apertura del cursor
Open Pareto

-- Lee el registro actual y se posiciona en el siguiente registro
Fetch Next From Pareto into @Id, @Descripcion, @Puntaje

-- Ciclo Do - While
While @@Fetch_Status=0
    Begin
    Set @Acumulador = @Acumulador + @Puntaje
--    Set @Peso = Convert(real, @Acumulador)/Convert(real, @Total)
    Set @Factor = Convert(real, @Acumulador)/Convert(real, @Total)
    --Select @Id, @Descripcion, @Puntaje, @Acumulador, @Peso

--    Insert into Pareto (IdPunto, Descripcion, Peso) values (@Id, @Descripcion, @Peso)
    Insert into Pareto (IdPunto, Descripcion, Factor) values (@Id, @Descripcion, @Factor)
    Fetch Next From Pareto into @Id, @Descripcion, @Puntaje
    End

-- Cerrar el cursor
Close Pareto

-- Descargar de memoria el cursor
Deallocate Pareto

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO
