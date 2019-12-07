/* Ejemplo de una transaccion y usando un roll back */
DECLARE @TranName VARCHAR(20)
SELECT @TranName = 'MyTransaction'

BEGIN TRANSACTION @TranName
GO
USE Tesis
GO
Select Modelo as 'Chevrolet' into ##tmp1 from scOriginalMatriz where Caracteristica = 'Catálogo de colores' and Marca='Chevrolet'
Select Modelo as 'Dodge'into ##tmp2 from scOriginalMatriz where Caracteristica = 'Catálogo de colores' and Marca='Dodge'
select Modelo Ficha into ##tablesNames from ##tmp1,##tmp2 -- query que marca error 
GO
ROLLBACK TRANSACTION MyTransaction
GO


/* Ejemplo de una transaccion y usando un commit */
DECLARE @TranName VARCHAR(20)
SELECT @TranName = 'MyTransaction'

BEGIN TRANSACTION @TranName
GO
USE Tesis
GO
Select Modelo as 'Chevrolet' into ##tmp1 from scOriginalMatriz where Caracteristica = 'Catálogo de colores' and Marca='Chevrolet'
Select Modelo as 'Dodge'into ##tmp2 from scOriginalMatriz where Caracteristica = 'Catálogo de colores' and Marca='Dodge'
select Modelo Ficha into ##tablesNames from ##tmp1,##tmp2 -- query que marca error 
GO
COMMIT TRANSACTION MyTransaction
GO


/* Ejemplo de una transaccion con marca */
BEGIN TRANSACTION MyTransactionWithMark
   WITH MARK 'My Transaction'
GO
USE Tesis
GO
Select Modelo as 'Chevrolet' into ##tmp1 from scOriginalMatriz where Caracteristica = 'Catálogo de colores' and Marca='Chevrolet'
Select Modelo as 'Dodge'into ##tmp2 from scOriginalMatriz where Caracteristica = 'Catálogo de colores' and Marca='Dodge'
select Modelo Ficha into ##tablesNames from ##tmp1,##tmp2 -- query que marca error 
GO
ROLLBACK TRANSACTION MyTransactionWithMark
GO


/* Ejemplo de una transaccion salvandola en cierto punto y luego con un roll back regresando a cierto punto */
BEGIN TRANSACTION MyTransaction
GO
	USE Tesis
	Select Modelo as 'Chevrolet' into ##tmp1 from scOriginalMatriz where Caracteristica = 'Catálogo de colores' and Marca='Chevrolet'
SAVE TRANSACTION onepoint
GO
	Select Modelo as 'Dodge'into ##tmp2 from scOriginalMatriz where Caracteristica = 'Catálogo de colores' and Marca='Dodge'
	select Modelo Ficha into ##tablesNames from ##tmp1,##tmp2 -- query que marca error 
/* The transaction is rolled back to the savepoint with the ROLLBACK TRANSACTION statement. */
GO
ROLLBACK TRANSACTION onepoint
GO
COMMIT TRANSACTION
GO


/* Ejemplo de una transaccion y usando un roll back */
DECLARE @TranName VARCHAR(20)
SELECT @TranName = 'MyTransaction'


BEGIN TRANSACTION MyTransaction
GO
	USE Tesis
SAVE TRANSACTION onepoint
GO
	select Modelo as 'Chevrolet' into ##tmp1from scOriginalMatriz where Caracteristica = 'Catálogo de colores' and Marca='Chevrolet'
	Select Modelo as 'Dodge'into ##tmp2 from scOriginalMatriz where Caracteristica = 'Catálogo de colores' and Marca='Dodge'
	select Chevrolet,Dodge into ##tablesNames from ##tmp1,##tmp2 -- query que marca error 
/* The transaction is rolled back to the savepoint with the ROLLBACK TRANSACTION statement. */
GO
ROLLBACK TRANSACTION onepoint
GO
COMMIT TRANSACTION
GO






select Modelo as 'Chevrolet' into ##tmp1 from scOriginalMatriz where Caracteristica = 'Catálogo de colores' and Marca='Chevrolet'

DECLARE @maxid int
select @maxid=count(*) from ##tmp1

DECLARE @ACounterVariable int
SET @ACounterVariable=0
WHILE (@ACounterVariable < @maxid)
BEGIN
	SET @ACounterVariable = @ACounterVariable + 1
	select @ACounterVariable as 'id',Chevrolet from ##tmp1
END

select * from ##tmp1
select * from ##tmp2
select * from ##tablesNames
	
drop table ##tmp1
drop table ##tmp2
drop table ##tablesNames
