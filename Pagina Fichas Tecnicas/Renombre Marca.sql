if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CalculaRenombre]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[CalculaRenombre]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

Create Procedure CalculaRenombre as

drop table RenombreMarca

Select cat.idMarca, Consultado=count(*) 
into ##tmpPrueba
from ComparacionAutomovil cmp, catAutomovil cat
where cmp.idAutomovil=cat.idautomovil
group by cat.idMarca

insert into ##tmpPrueba
select a.idMarca, Consultado=count(*) 
from dbo.Encuesta e, catAutomovil a
where e.idAutomovil=a.idAutomovil
group by a.idMarca

select idMarca, Consultado=sum(Consultado) 
into RenombreMarca
from ##tmpPrueba
group by idMarca
order by idmarca

drop table ##tmpPrueba
-- exec CalculaRenombre
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

