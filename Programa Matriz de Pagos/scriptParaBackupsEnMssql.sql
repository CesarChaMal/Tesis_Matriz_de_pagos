-- Generando un Backup
----------------------------------------------------------------------------------------------------------------------------------
-- Respaldo FULL de la base de datos
BackUp DataBase Aztlan to Disk =
'c:\DataBackUp\Aztlan070620.bak'

-- Despliega los nombres lógicos de los archivos de la base para poder restaurarla (en caso de no conocerlos)
RESTORE FILELISTONLY 
FROM DISK = 'c:\DataBackUp\Aztlan070620.bak'

-- Restauración FULL de la base de datos
RESTORE DATABASE Prueba
   FROM DISK = 'c:\DataBackUp\Aztlan070620.bak'
   WITH MOVE 'Aztlan_data' TO
'C:\Prueba\Prueba_Data.mdf',
   MOVE 'Aztlan_log' TO 'C:\Prueba\Prueba_Log.ldf'

----------------------------------------------------------------------------------------------------------------------------------

BACKUP DATABASE Tesis TO DISK = 'C:\Archivos de programa\xampp\htdocs\Tesis Matriz de pagos\Tesis backup 08-07-2007.bak'
RESTORE FILELISTONLY FROM DISK = 'C:\Archivos de programa\xampp\htdocs\Tesis Matriz de pagos\Tesis backup 08-07-2007.bak'
RESTORE DATABASE Tesis2 
   FROM DISK = 'C:\Archivos de programa\xampp\htdocs\Tesis Matriz de pagos\Tesis backup 08-07-2007.bak'
   WITH MOVE 'Encuesta_Data' TO
	'C:\Archivos de programa\xampp\htdocs\Tesis Matriz de pagos\Tesis2_Data.MDF',
   MOVE 'Encuesta_Log' TO 
	'C:\Archivos de programa\xampp\htdocs\Tesis Matriz de pagos\Tesis2_Log.LDF'










-- Separando y Adjuntando una base de datos
----------------------------------------------------------------------------------------------------------------------------------

/**
Return Code Values
0 (success) or 1 (failure)
*/

-- Detach de una base de datos
EXEC sp_detach_db 'Tesis', 'true'
EXEC sp_detach_db @dbname = 'Tesis' ,@skipchecks = 'true'
EXEC sp_detach_db 'Tesis', 'false'

-- Attach a una base de datos previamente detach
EXEC sp_attach_db @dbname = N'Tesis', 
   @filename1 = N'C:\Archivos de programa\xampp\htdocs\Tesis Matriz de pagos\Tesis_Data.MDF', 
   @filename2 = N'C:\Archivos de programa\xampp\htdocs\Tesis Matriz de pagos\Tesis_Log.LDF'

-- Attach a una base de datos previamente detach pero con un solo arhivo

EXEC sp_attach_single_file_db @dbname = 'Tesis', 
   @physname = 'C:\Archivos de programa\xampp\htdocs\Tesis Matriz de pagos\Tesis_Data.MDF'









--- Otros
----------------------------------------------------------------------------------------------------------------------------------
EXEC sp_helpdb
USE Tesis EXEC sp_help catAutomovil
USE Tesis EXEC sp_help
EXEC sp_help
EXEC sp_helpfile
EXEC sp_helpgroup
EXEC sp_helprotect
EXEC sp_helpserver
EXEC sp_helptrigger catAutomovil
EXEC sp_helpuser

