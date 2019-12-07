/*
Bring Online (Missing Transaction Log)

Hi,

Start the database in Emergency mode. So that Database will be started with

out transaction log. After that you can use DTS to transfer the data

and objects to a new database.

How to start the database in Emergency Mode:
*/

Sp_configure "allow updates", 1
go

Reconfigure with override
GO

Update sysdatabases set status = 32768

where name = "BadDbName"
go
Sp_configure "allow updates", 0
go
Reconfigure with override