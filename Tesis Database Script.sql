/****** Object:  Database Tesis    Script Date: 12/7/2007 1:54:36 ******/
IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'Tesis')
	DROP DATABASE [Tesis]
GO

CREATE DATABASE [Tesis]  ON (NAME = N'Encuesta_Data', FILENAME = N'F:\Tesis Matriz de pagos\Tesis_Data.MDF' , SIZE = 6, FILEGROWTH = 10%) LOG ON (NAME = N'Encuesta_Log', FILENAME = N'F:\Tesis Matriz de pagos\Tesis_Log.LDF' , SIZE = 1, FILEGROWTH = 10%)
GO

exec sp_dboption N'Tesis', N'autoclose', N'false'
GO

exec sp_dboption N'Tesis', N'bulkcopy', N'false'
GO

exec sp_dboption N'Tesis', N'trunc. log', N'true'
GO

exec sp_dboption N'Tesis', N'torn page detection', N'false'
GO

exec sp_dboption N'Tesis', N'read only', N'false'
GO

exec sp_dboption N'Tesis', N'dbo use', N'false'
GO

exec sp_dboption N'Tesis', N'single', N'false'
GO

exec sp_dboption N'Tesis', N'autoshrink', N'true'
GO

exec sp_dboption N'Tesis', N'ANSI null default', N'false'
GO

exec sp_dboption N'Tesis', N'recursive triggers', N'false'
GO

exec sp_dboption N'Tesis', N'ANSI nulls', N'false'
GO

exec sp_dboption N'Tesis', N'concat null yields null', N'false'
GO

exec sp_dboption N'Tesis', N'cursor close on commit', N'false'
GO

exec sp_dboption N'Tesis', N'default to local cursor', N'false'
GO

exec sp_dboption N'Tesis', N'quoted identifier', N'false'
GO

exec sp_dboption N'Tesis', N'ANSI warnings', N'false'
GO

exec sp_dboption N'Tesis', N'auto create statistics', N'true'
GO

exec sp_dboption N'Tesis', N'auto update statistics', N'true'
GO

use [Tesis]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Encuesta_catComoSupo]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Encuesta] DROP CONSTRAINT FK_Encuesta_catComoSupo
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Encuesta_catEntrevistadores]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Encuesta] DROP CONSTRAINT FK_Encuesta_catEntrevistadores
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Encuesta_catEstadoCivil]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Encuesta] DROP CONSTRAINT FK_Encuesta_catEstadoCivil
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_catCaracteristicas_catFamilias]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[catCaracteristicas] DROP CONSTRAINT FK_catCaracteristicas_catFamilias
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_relPuntoFamilia_catFamilias]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[relPuntoFamilia] DROP CONSTRAINT FK_relPuntoFamilia_catFamilias
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Encuesta_catLugares]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Encuesta] DROP CONSTRAINT FK_Encuesta_catLugares
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_catAutomovil_catMarcas1]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[catAutomovil] DROP CONSTRAINT FK_catAutomovil_catMarcas1
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Encuesta_catMedioPago]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Encuesta] DROP CONSTRAINT FK_Encuesta_catMedioPago
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Encuesta_catMotivos]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Encuesta] DROP CONSTRAINT FK_Encuesta_catMotivos
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Pareto_catPuntosAdquisicion]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Pareto] DROP CONSTRAINT FK_Pareto_catPuntosAdquisicion
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_PuntoAdquisicion_catPuntosAdquisicion]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[PuntoAdquisicion] DROP CONSTRAINT FK_PuntoAdquisicion_catPuntosAdquisicion
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_relPuntoFamilia_catPuntosAdquisicion]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[relPuntoFamilia] DROP CONSTRAINT FK_relPuntoFamilia_catPuntosAdquisicion
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Encuesta_catUsoPrimario]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Encuesta] DROP CONSTRAINT FK_Encuesta_catUsoPrimario
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_ComparacionAutomovil_catAutomovil]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[ComparacionAutomovil] DROP CONSTRAINT FK_ComparacionAutomovil_catAutomovil
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Encuesta_catAutomovil]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Encuesta] DROP CONSTRAINT FK_Encuesta_catAutomovil
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_FichaTecnica_catAutomovil]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[FichaTecnica] DROP CONSTRAINT FK_FichaTecnica_catAutomovil
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_detFichaTecnica_catCaracteristicas]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[detFichaTecnica] DROP CONSTRAINT FK_detFichaTecnica_catCaracteristicas
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_ComparacionAutomovil_Encuesta1]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[ComparacionAutomovil] DROP CONSTRAINT FK_ComparacionAutomovil_Encuesta1
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_PuntoAdquisicion_Encuesta]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[PuntoAdquisicion] DROP CONSTRAINT FK_PuntoAdquisicion_Encuesta
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Colores_FichaTecnica]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Colores] DROP CONSTRAINT FK_Colores_FichaTecnica
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_detFichaTecnica_FichaTecnica]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[detFichaTecnica] DROP CONSTRAINT FK_detFichaTecnica_FichaTecnica
GO

/****** Object:  Stored Procedure dbo.CalculaRenombre    Script Date: 12/7/2007 1:54:37 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CalculaRenombre]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[CalculaRenombre]
GO

/****** Object:  Stored Procedure dbo.CargaPareto    Script Date: 12/7/2007 1:54:37 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CargaPareto]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[CargaPareto]
GO

/****** Object:  Stored Procedure dbo.detFichaTecnicaPersonalizado    Script Date: 12/7/2007 1:54:37 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[detFichaTecnicaPersonalizado]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[detFichaTecnicaPersonalizado]
GO

/****** Object:  Stored Procedure dbo.ConsultaEncuesta    Script Date: 12/7/2007 1:54:37 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ConsultaEncuesta]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[ConsultaEncuesta]
GO

/****** Object:  Stored Procedure dbo.CargaMatrizPersonalizado    Script Date: 12/7/2007 1:54:37 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CargaMatrizPersonalizado]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[CargaMatrizPersonalizado]
GO

/****** Object:  Stored Procedure dbo.CargaPareto_Old    Script Date: 12/7/2007 1:54:37 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CargaPareto_Old]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[CargaPareto_Old]
GO

/****** Object:  Stored Procedure dbo.createMatrixTables    Script Date: 12/7/2007 1:54:37 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[createMatrixTables]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[createMatrixTables]
GO

/****** Object:  Stored Procedure dbo.deleteIfExists    Script Date: 12/7/2007 1:54:37 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[deleteIfExists]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[deleteIfExists]
GO

/****** Object:  Stored Procedure dbo.ifExists    Script Date: 12/7/2007 1:54:37 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ifExists]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[ifExists]
GO

/****** Object:  View dbo.BaseMatriz    Script Date: 12/7/2007 1:54:37 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BaseMatriz]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[BaseMatriz]
GO

/****** Object:  View dbo.view_pareto    Script Date: 12/7/2007 1:54:37 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[view_pareto]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[view_pareto]
GO

/****** Object:  Table [dbo].[Colores]    Script Date: 12/7/2007 1:54:37 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Colores]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Colores]
GO

/****** Object:  Table [dbo].[ComparacionAutomovil]    Script Date: 12/7/2007 1:54:37 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ComparacionAutomovil]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ComparacionAutomovil]
GO

/****** Object:  Table [dbo].[PuntoAdquisicion]    Script Date: 12/7/2007 1:54:37 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[PuntoAdquisicion]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[PuntoAdquisicion]
GO

/****** Object:  Table [dbo].[detFichaTecnica]    Script Date: 12/7/2007 1:54:37 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[detFichaTecnica]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[detFichaTecnica]
GO

/****** Object:  Table [dbo].[Encuesta]    Script Date: 12/7/2007 1:54:37 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Encuesta]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Encuesta]
GO

/****** Object:  Table [dbo].[FichaTecnica]    Script Date: 12/7/2007 1:54:37 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FichaTecnica]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[FichaTecnica]
GO

/****** Object:  Table [dbo].[Pareto]    Script Date: 12/7/2007 1:54:37 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Pareto]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Pareto]
GO

/****** Object:  Table [dbo].[catAutomovil]    Script Date: 12/7/2007 1:54:37 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[catAutomovil]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[catAutomovil]
GO

/****** Object:  Table [dbo].[catCaracteristicas]    Script Date: 12/7/2007 1:54:37 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[catCaracteristicas]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[catCaracteristicas]
GO

/****** Object:  Table [dbo].[relPuntoFamilia]    Script Date: 12/7/2007 1:54:37 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[relPuntoFamilia]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[relPuntoFamilia]
GO

/****** Object:  Table [dbo].[RenombreMarca]    Script Date: 12/7/2007 1:54:37 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[RenombreMarca]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[RenombreMarca]
GO

/****** Object:  Table [dbo].[catComoSupo]    Script Date: 12/7/2007 1:54:37 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[catComoSupo]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[catComoSupo]
GO

/****** Object:  Table [dbo].[catEntrevistadores]    Script Date: 12/7/2007 1:54:37 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[catEntrevistadores]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[catEntrevistadores]
GO

/****** Object:  Table [dbo].[catEstadoCivil]    Script Date: 12/7/2007 1:54:37 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[catEstadoCivil]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[catEstadoCivil]
GO

/****** Object:  Table [dbo].[catFamilias]    Script Date: 12/7/2007 1:54:37 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[catFamilias]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[catFamilias]
GO

/****** Object:  Table [dbo].[catLugares]    Script Date: 12/7/2007 1:54:37 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[catLugares]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[catLugares]
GO

/****** Object:  Table [dbo].[catMarcas]    Script Date: 12/7/2007 1:54:37 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[catMarcas]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[catMarcas]
GO

/****** Object:  Table [dbo].[catMedioPago]    Script Date: 12/7/2007 1:54:37 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[catMedioPago]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[catMedioPago]
GO

/****** Object:  Table [dbo].[catMotivos]    Script Date: 12/7/2007 1:54:37 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[catMotivos]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[catMotivos]
GO

/****** Object:  Table [dbo].[catPuntosAdquisicion]    Script Date: 12/7/2007 1:54:37 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[catPuntosAdquisicion]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[catPuntosAdquisicion]
GO

/****** Object:  Table [dbo].[catUsoPrimario]    Script Date: 12/7/2007 1:54:37 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[catUsoPrimario]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[catUsoPrimario]
GO

/****** Object:  Table [dbo].[scCesarFichaTecnica]    Script Date: 12/7/2007 1:54:37 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[scCesarFichaTecnica]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[scCesarFichaTecnica]
GO

/****** Object:  Table [dbo].[scCesarMatriz]    Script Date: 12/7/2007 1:54:37 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[scCesarMatriz]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[scCesarMatriz]
GO

/****** Object:  Table [dbo].[scOriginalFichaTecnica]    Script Date: 12/7/2007 1:54:37 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[scOriginalFichaTecnica]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[scOriginalFichaTecnica]
GO

/****** Object:  Table [dbo].[scOriginalMatriz]    Script Date: 12/7/2007 1:54:37 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[scOriginalMatriz]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[scOriginalMatriz]
GO

/****** Object:  Table [dbo].[zip_pareto]    Script Date: 12/7/2007 1:54:37 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zip_pareto]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zip_pareto]
GO

/****** Object:  Login BUILTIN\Administradores    Script Date: 12/7/2007 1:54:36 ******/
exec sp_addsrvrolemember N'BUILTIN\Administradores', sysadmin
GO

/****** Object:  User dbo    Script Date: 12/7/2007 1:54:36 ******/
/****** Object:  Table [dbo].[RenombreMarca]    Script Date: 12/7/2007 1:54:39 ******/
CREATE TABLE [dbo].[RenombreMarca] (
	[idMarca] [tinyint] NOT NULL ,
	[Consultado] [int] NULL 
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[catComoSupo]    Script Date: 12/7/2007 1:54:39 ******/
CREATE TABLE [dbo].[catComoSupo] (
	[IdComoSupo] [tinyint] IDENTITY (1, 1) NOT NULL ,
	[Descripcion] [varchar] (50) NOT NULL ,
	[Activo] [bit] NOT NULL 
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[catEntrevistadores]    Script Date: 12/7/2007 1:54:39 ******/
CREATE TABLE [dbo].[catEntrevistadores] (
	[IdEntrevistador] [tinyint] IDENTITY (1, 1) NOT NULL ,
	[Descripcion] [varchar] (50) NOT NULL ,
	[Activo] [bit] NOT NULL 
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[catEstadoCivil]    Script Date: 12/7/2007 1:54:39 ******/
CREATE TABLE [dbo].[catEstadoCivil] (
	[IdEstadoCivil] [tinyint] IDENTITY (1, 1) NOT NULL ,
	[Descripcion] [varchar] (30) NOT NULL ,
	[Activo] [bit] NOT NULL 
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[catFamilias]    Script Date: 12/7/2007 1:54:39 ******/
CREATE TABLE [dbo].[catFamilias] (
	[IdFamilia] [int] IDENTITY (1, 1) NOT NULL ,
	[Descripcion] [varchar] (50) NOT NULL ,
	[Activo] [bit] NOT NULL 
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[catLugares]    Script Date: 12/7/2007 1:54:39 ******/
CREATE TABLE [dbo].[catLugares] (
	[IdLugar] [tinyint] IDENTITY (1, 1) NOT NULL ,
	[Descripcion] [varchar] (50) NOT NULL ,
	[Activo] [bit] NOT NULL 
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[catMarcas]    Script Date: 12/7/2007 1:54:40 ******/
CREATE TABLE [dbo].[catMarcas] (
	[IdMarca] [tinyint] IDENTITY (1, 1) NOT NULL ,
	[Marca] [varchar] (30) NOT NULL ,
	[Activo] [bit] NOT NULL 
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[catMedioPago]    Script Date: 12/7/2007 1:54:40 ******/
CREATE TABLE [dbo].[catMedioPago] (
	[IdMedioPago] [tinyint] IDENTITY (1, 1) NOT NULL ,
	[Descripcion] [varchar] (30) NOT NULL ,
	[Activo] [bit] NOT NULL 
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[catMotivos]    Script Date: 12/7/2007 1:54:40 ******/
CREATE TABLE [dbo].[catMotivos] (
	[IdMotivo] [tinyint] IDENTITY (1, 1) NOT NULL ,
	[Descripcion] [varchar] (30) NOT NULL ,
	[Activo] [bit] NOT NULL 
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[catPuntosAdquisicion]    Script Date: 12/7/2007 1:54:40 ******/
CREATE TABLE [dbo].[catPuntosAdquisicion] (
	[IdPunto] [int] IDENTITY (1, 1) NOT NULL ,
	[Descripcion] [varchar] (30) NOT NULL ,
	[Activo] [bit] NOT NULL 
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[catUsoPrimario]    Script Date: 12/7/2007 1:54:40 ******/
CREATE TABLE [dbo].[catUsoPrimario] (
	[IdUsoPrimario] [tinyint] IDENTITY (1, 1) NOT NULL ,
	[Descripcion] [varchar] (30) NOT NULL ,
	[Activo] [bit] NOT NULL 
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[scCesarFichaTecnica]    Script Date: 12/7/2007 1:54:40 ******/
CREATE TABLE [dbo].[scCesarFichaTecnica] (
	[idFicha] [int] NOT NULL ,
	[idCaracteristica] [int] NOT NULL ,
	[Valor] [real] NOT NULL 
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[scCesarMatriz]    Script Date: 12/7/2007 1:54:40 ******/
CREATE TABLE [dbo].[scCesarMatriz] (
	[idFamilia] [int] NOT NULL ,
	[Familia] [varchar] (50) NOT NULL ,
	[Marca] [varchar] (30) NOT NULL ,
	[Modelo] [varchar] (80) NOT NULL ,
	[Caracteristica] [varchar] (50) NOT NULL ,
	[idCaracteristica] [int] NOT NULL ,
	[Proporcion] [float] NULL ,
	[Peso] [real] NOT NULL ,
	[Factor] [float] NULL 
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[scOriginalFichaTecnica]    Script Date: 12/7/2007 1:54:40 ******/
CREATE TABLE [dbo].[scOriginalFichaTecnica] (
	[idFicha] [int] NOT NULL ,
	[idCaracteristica] [int] NOT NULL ,
	[Valor] [real] NOT NULL 
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[scOriginalMatriz]    Script Date: 12/7/2007 1:54:41 ******/
CREATE TABLE [dbo].[scOriginalMatriz] (
	[idFamilia] [int] NOT NULL ,
	[Familia] [varchar] (50) NOT NULL ,
	[Marca] [varchar] (30) NOT NULL ,
	[Modelo] [varchar] (80) NOT NULL ,
	[Caracteristica] [varchar] (50) NOT NULL ,
	[idCaracteristica] [int] NOT NULL ,
	[Proporcion] [float] NULL ,
	[Peso] [real] NOT NULL ,
	[Factor] [float] NULL 
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[zip_pareto]    Script Date: 12/7/2007 1:54:41 ******/
CREATE TABLE [dbo].[zip_pareto] (
	[IdPunto] [int] NOT NULL ,
	[Descripcion] [varchar] (30) NULL ,
	[Peso] [real] NULL 
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Pareto]    Script Date: 12/7/2007 1:54:41 ******/
CREATE TABLE [dbo].[Pareto] (
	[IdPunto] [int] NOT NULL ,
	[Descripcion] [varchar] (30) NOT NULL ,
	[NumPareto] [real] NOT NULL ,
	[Peso] [real] NOT NULL 
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[catAutomovil]    Script Date: 12/7/2007 1:54:41 ******/
CREATE TABLE [dbo].[catAutomovil] (
	[IdAutomovil] [smallint] IDENTITY (1, 1) NOT NULL ,
	[IdMarca] [tinyint] NOT NULL ,
	[Modelo] [varchar] (80) NOT NULL ,
	[Activo] [bit] NOT NULL 
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[catCaracteristicas]    Script Date: 12/7/2007 1:54:41 ******/
CREATE TABLE [dbo].[catCaracteristicas] (
	[IdCaracteristica] [int] IDENTITY (1, 1) NOT NULL ,
	[IdFamilia] [int] NOT NULL ,
	[Descripcion] [varchar] (50) NOT NULL ,
	[Tipo] [tinyint] NOT NULL ,
	[Activo] [bit] NOT NULL 
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[relPuntoFamilia]    Script Date: 12/7/2007 1:54:41 ******/
CREATE TABLE [dbo].[relPuntoFamilia] (
	[IdFamilia] [int] NOT NULL ,
	[IdPunto] [int] NOT NULL 
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Encuesta]    Script Date: 12/7/2007 1:54:41 ******/
CREATE TABLE [dbo].[Encuesta] (
	[IdEncuesta] [int] IDENTITY (1, 1) NOT NULL ,
	[Compra4Anios] [bit] NOT NULL ,
	[Fecha] [datetime] NOT NULL ,
	[TiempoDeCompra] [tinyint] NOT NULL ,
	[IdMotivo] [tinyint] NOT NULL ,
	[Nuevo] [bit] NOT NULL ,
	[IdMedioPago] [tinyint] NOT NULL ,
	[IdAutomovil] [smallint] NOT NULL ,
	[Costo] [float] NOT NULL ,
	[Seguro] [bit] NOT NULL ,
	[InfluenciaVendedor] [bit] NOT NULL ,
	[IdComoSupo] [tinyint] NOT NULL ,
	[IdUsoPrimario] [tinyint] NOT NULL ,
	[RangoEdad] [tinyint] NOT NULL ,
	[IdEstadoCivil] [tinyint] NOT NULL ,
	[Sexo] [bit] NOT NULL ,
	[IdLugar] [tinyint] NOT NULL ,
	[FechaEncuesta] [datetime] NOT NULL ,
	[IdEntrevistador] [tinyint] NOT NULL ,
	[Activo] [bit] NOT NULL 
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[FichaTecnica]    Script Date: 12/7/2007 1:54:42 ******/
CREATE TABLE [dbo].[FichaTecnica] (
	[IdFicha] [int] IDENTITY (1, 1) NOT NULL ,
	[IdAutomovil] [smallint] NOT NULL ,
	[Anio] [int] NOT NULL ,
	[Activo] [bit] NOT NULL 
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Colores]    Script Date: 12/7/2007 1:54:42 ******/
CREATE TABLE [dbo].[Colores] (
	[IdFicha] [int] NOT NULL ,
	[Color] [varchar] (30) NOT NULL ,
	[Activo] [bit] NOT NULL 
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[ComparacionAutomovil]    Script Date: 12/7/2007 1:54:42 ******/
CREATE TABLE [dbo].[ComparacionAutomovil] (
	[IdAutomovil] [smallint] NOT NULL ,
	[IdEncuesta] [int] NOT NULL ,
	[Orden] [tinyint] NOT NULL 
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[PuntoAdquisicion]    Script Date: 12/7/2007 1:54:42 ******/
CREATE TABLE [dbo].[PuntoAdquisicion] (
	[IdEncuesta] [int] NOT NULL ,
	[IdPunto] [int] NOT NULL ,
	[Orden] [tinyint] NOT NULL 
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[detFichaTecnica]    Script Date: 12/7/2007 1:54:42 ******/
CREATE TABLE [dbo].[detFichaTecnica] (
	[idFicha] [int] NOT NULL ,
	[idCaracteristica] [int] NOT NULL ,
	[Valor] [real] NOT NULL 
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[catComoSupo] WITH NOCHECK ADD 
	CONSTRAINT [PK__catComoSupo__0B91BA14] PRIMARY KEY  CLUSTERED 
	(
		[IdComoSupo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[catEntrevistadores] WITH NOCHECK ADD 
	CONSTRAINT [PK_catEntrevistadores] PRIMARY KEY  CLUSTERED 
	(
		[IdEntrevistador]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[catEstadoCivil] WITH NOCHECK ADD 
	CONSTRAINT [PK_catEstadoCivil] PRIMARY KEY  CLUSTERED 
	(
		[IdEstadoCivil]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[catFamilias] WITH NOCHECK ADD 
	CONSTRAINT [PK_catFamilias] PRIMARY KEY  CLUSTERED 
	(
		[IdFamilia]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[catLugares] WITH NOCHECK ADD 
	CONSTRAINT [PK_catLugares] PRIMARY KEY  CLUSTERED 
	(
		[IdLugar]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[catMarcas] WITH NOCHECK ADD 
	CONSTRAINT [PK_catMarcas] PRIMARY KEY  CLUSTERED 
	(
		[IdMarca]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[catMedioPago] WITH NOCHECK ADD 
	CONSTRAINT [PK_catMedioPago] PRIMARY KEY  CLUSTERED 
	(
		[IdMedioPago]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[catMotivos] WITH NOCHECK ADD 
	CONSTRAINT [PK_catMotivos] PRIMARY KEY  CLUSTERED 
	(
		[IdMotivo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[catPuntosAdquisicion] WITH NOCHECK ADD 
	CONSTRAINT [PK__catPuntosAdquisi__7C4F7684] PRIMARY KEY  CLUSTERED 
	(
		[IdPunto]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[catUsoPrimario] WITH NOCHECK ADD 
	CONSTRAINT [PK__catUsoPrimario__0F624AF8] PRIMARY KEY  CLUSTERED 
	(
		[IdUsoPrimario]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[catAutomovil] WITH NOCHECK ADD 
	CONSTRAINT [PK__catAutomovil__04E4BC85] PRIMARY KEY  CLUSTERED 
	(
		[IdAutomovil]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[relPuntoFamilia] WITH NOCHECK ADD 
	CONSTRAINT [PK_relPuntoFamilia] PRIMARY KEY  CLUSTERED 
	(
		[IdFamilia]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Encuesta] WITH NOCHECK ADD 
	CONSTRAINT [PK__Encuesta__1EA48E88] PRIMARY KEY  CLUSTERED 
	(
		[IdEncuesta]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[FichaTecnica] WITH NOCHECK ADD 
	CONSTRAINT [PK_FichaTecnica] PRIMARY KEY  CLUSTERED 
	(
		[IdFicha]
	)  ON [PRIMARY] 
GO

 CREATE  CLUSTERED  INDEX [IX_Pareto] ON [dbo].[Pareto]([NumPareto]) ON [PRIMARY]
GO

ALTER TABLE [dbo].[catComoSupo] WITH NOCHECK ADD 
	CONSTRAINT [DF_catComoSupo_Activo] DEFAULT (1) FOR [Activo]
GO

ALTER TABLE [dbo].[catEntrevistadores] WITH NOCHECK ADD 
	CONSTRAINT [DF_catEntrevistadores_Activo] DEFAULT (1) FOR [Activo]
GO

ALTER TABLE [dbo].[catEstadoCivil] WITH NOCHECK ADD 
	CONSTRAINT [DF_catEstadoCivil_Activo] DEFAULT (1) FOR [Activo]
GO

ALTER TABLE [dbo].[catFamilias] WITH NOCHECK ADD 
	CONSTRAINT [DF_catFamilias_Activo] DEFAULT (1) FOR [Activo]
GO

ALTER TABLE [dbo].[catLugares] WITH NOCHECK ADD 
	CONSTRAINT [DF_catLugares_Activo] DEFAULT (1) FOR [Activo]
GO

ALTER TABLE [dbo].[catMarcas] WITH NOCHECK ADD 
	CONSTRAINT [DF_catMarcas_Activo] DEFAULT (1) FOR [Activo]
GO

ALTER TABLE [dbo].[catMedioPago] WITH NOCHECK ADD 
	CONSTRAINT [DF_catMedioPago_Activo] DEFAULT (1) FOR [Activo]
GO

ALTER TABLE [dbo].[catMotivos] WITH NOCHECK ADD 
	CONSTRAINT [DF_catMotivos_Activo] DEFAULT (1) FOR [Activo]
GO

ALTER TABLE [dbo].[catPuntosAdquisicion] WITH NOCHECK ADD 
	CONSTRAINT [DF_catPuntosAdquisicion_Activo] DEFAULT (1) FOR [Activo]
GO

ALTER TABLE [dbo].[catUsoPrimario] WITH NOCHECK ADD 
	CONSTRAINT [DF_catUsoPrimario_Activo] DEFAULT (1) FOR [Activo]
GO

ALTER TABLE [dbo].[Pareto] WITH NOCHECK ADD 
	CONSTRAINT [PK_Pareto] PRIMARY KEY  NONCLUSTERED 
	(
		[IdPunto]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[catAutomovil] WITH NOCHECK ADD 
	CONSTRAINT [DF_catAutomovil_Activo] DEFAULT (1) FOR [Activo],
	CONSTRAINT [IX_catAutomovil] UNIQUE  NONCLUSTERED 
	(
		[IdMarca],
		[Modelo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[catCaracteristicas] WITH NOCHECK ADD 
	CONSTRAINT [DF_catCaracteristicas_Activo] DEFAULT (1) FOR [Activo],
	CONSTRAINT [PK_catCaracteristicas] PRIMARY KEY  NONCLUSTERED 
	(
		[IdCaracteristica]
	)  ON [PRIMARY] ,
	CONSTRAINT [IX_catCaracteristicas] UNIQUE  NONCLUSTERED 
	(
		[IdFamilia],
		[Descripcion]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Encuesta] WITH NOCHECK ADD 
	CONSTRAINT [DF_Encuesta_FechaEncuesta] DEFAULT (getdate()) FOR [FechaEncuesta],
	CONSTRAINT [DF_Encuesta_Activo] DEFAULT (1) FOR [Activo]
GO

ALTER TABLE [dbo].[FichaTecnica] WITH NOCHECK ADD 
	CONSTRAINT [DF_FichaTecnica_Anio] DEFAULT (0) FOR [Anio],
	CONSTRAINT [DF_FichaTecnica_Activo] DEFAULT (1) FOR [Activo],
	CONSTRAINT [IX_FichaTecnica] UNIQUE  NONCLUSTERED 
	(
		[IdAutomovil],
		[Anio]
	)  ON [PRIMARY] ,
	CONSTRAINT [IX_FichaTecnica_1] UNIQUE  NONCLUSTERED 
	(
		[IdFicha],
		[IdAutomovil]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Colores] WITH NOCHECK ADD 
	CONSTRAINT [DF_Colores_Activo] DEFAULT (1) FOR [Activo],
	CONSTRAINT [IX_Colores] UNIQUE  NONCLUSTERED 
	(
		[IdFicha],
		[Color]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[ComparacionAutomovil] WITH NOCHECK ADD 
	CONSTRAINT [IX_ComparacionAutomovil] UNIQUE  NONCLUSTERED 
	(
		[IdAutomovil],
		[IdEncuesta]
	)  ON [PRIMARY] ,
	CONSTRAINT [IX_ComparacionAutomovil_1] UNIQUE  NONCLUSTERED 
	(
		[IdEncuesta],
		[Orden]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[PuntoAdquisicion] WITH NOCHECK ADD 
	CONSTRAINT [DF_PuntoAdquisicion_IdPunto] DEFAULT (0) FOR [IdPunto],
	CONSTRAINT [IX_PuntoAdquisicion] UNIQUE  NONCLUSTERED 
	(
		[IdEncuesta],
		[IdPunto]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[detFichaTecnica] WITH NOCHECK ADD 
	CONSTRAINT [IX_detFichaTecnica] UNIQUE  NONCLUSTERED 
	(
		[idFicha],
		[idCaracteristica]
	)  ON [PRIMARY] 
GO

 CREATE  UNIQUE  INDEX [IX_PuntoAdquisicion_1] ON [dbo].[PuntoAdquisicion]([IdEncuesta], [Orden]) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Pareto] ADD 
	CONSTRAINT [FK_Pareto_catPuntosAdquisicion] FOREIGN KEY 
	(
		[IdPunto]
	) REFERENCES [dbo].[catPuntosAdquisicion] (
		[IdPunto]
	)
GO

ALTER TABLE [dbo].[catAutomovil] ADD 
	CONSTRAINT [FK_catAutomovil_catMarcas1] FOREIGN KEY 
	(
		[IdMarca]
	) REFERENCES [dbo].[catMarcas] (
		[IdMarca]
	)
GO

ALTER TABLE [dbo].[catCaracteristicas] ADD 
	CONSTRAINT [FK_catCaracteristicas_catFamilias] FOREIGN KEY 
	(
		[IdFamilia]
	) REFERENCES [dbo].[catFamilias] (
		[IdFamilia]
	)
GO

ALTER TABLE [dbo].[relPuntoFamilia] ADD 
	CONSTRAINT [FK_relPuntoFamilia_catFamilias] FOREIGN KEY 
	(
		[IdFamilia]
	) REFERENCES [dbo].[catFamilias] (
		[IdFamilia]
	),
	CONSTRAINT [FK_relPuntoFamilia_catPuntosAdquisicion] FOREIGN KEY 
	(
		[IdPunto]
	) REFERENCES [dbo].[catPuntosAdquisicion] (
		[IdPunto]
	)
GO

ALTER TABLE [dbo].[Encuesta] ADD 
	CONSTRAINT [FK_Encuesta_catAutomovil] FOREIGN KEY 
	(
		[IdAutomovil]
	) REFERENCES [dbo].[catAutomovil] (
		[IdAutomovil]
	),
	CONSTRAINT [FK_Encuesta_catComoSupo] FOREIGN KEY 
	(
		[IdComoSupo]
	) REFERENCES [dbo].[catComoSupo] (
		[IdComoSupo]
	),
	CONSTRAINT [FK_Encuesta_catEntrevistadores] FOREIGN KEY 
	(
		[IdEntrevistador]
	) REFERENCES [dbo].[catEntrevistadores] (
		[IdEntrevistador]
	),
	CONSTRAINT [FK_Encuesta_catEstadoCivil] FOREIGN KEY 
	(
		[IdEstadoCivil]
	) REFERENCES [dbo].[catEstadoCivil] (
		[IdEstadoCivil]
	),
	CONSTRAINT [FK_Encuesta_catLugares] FOREIGN KEY 
	(
		[IdLugar]
	) REFERENCES [dbo].[catLugares] (
		[IdLugar]
	),
	CONSTRAINT [FK_Encuesta_catMedioPago] FOREIGN KEY 
	(
		[IdMedioPago]
	) REFERENCES [dbo].[catMedioPago] (
		[IdMedioPago]
	),
	CONSTRAINT [FK_Encuesta_catMotivos] FOREIGN KEY 
	(
		[IdMotivo]
	) REFERENCES [dbo].[catMotivos] (
		[IdMotivo]
	),
	CONSTRAINT [FK_Encuesta_catUsoPrimario] FOREIGN KEY 
	(
		[IdUsoPrimario]
	) REFERENCES [dbo].[catUsoPrimario] (
		[IdUsoPrimario]
	)
GO

ALTER TABLE [dbo].[FichaTecnica] ADD 
	CONSTRAINT [FK_FichaTecnica_catAutomovil] FOREIGN KEY 
	(
		[IdAutomovil]
	) REFERENCES [dbo].[catAutomovil] (
		[IdAutomovil]
	)
GO

ALTER TABLE [dbo].[Colores] ADD 
	CONSTRAINT [FK_Colores_FichaTecnica] FOREIGN KEY 
	(
		[IdFicha]
	) REFERENCES [dbo].[FichaTecnica] (
		[IdFicha]
	)
GO

ALTER TABLE [dbo].[ComparacionAutomovil] ADD 
	CONSTRAINT [FK_ComparacionAutomovil_catAutomovil] FOREIGN KEY 
	(
		[IdAutomovil]
	) REFERENCES [dbo].[catAutomovil] (
		[IdAutomovil]
	),
	CONSTRAINT [FK_ComparacionAutomovil_Encuesta1] FOREIGN KEY 
	(
		[IdEncuesta]
	) REFERENCES [dbo].[Encuesta] (
		[IdEncuesta]
	)
GO

ALTER TABLE [dbo].[PuntoAdquisicion] ADD 
	CONSTRAINT [FK_PuntoAdquisicion_catPuntosAdquisicion] FOREIGN KEY 
	(
		[IdPunto]
	) REFERENCES [dbo].[catPuntosAdquisicion] (
		[IdPunto]
	),
	CONSTRAINT [FK_PuntoAdquisicion_Encuesta] FOREIGN KEY 
	(
		[IdEncuesta]
	) REFERENCES [dbo].[Encuesta] (
		[IdEncuesta]
	)
GO

ALTER TABLE [dbo].[detFichaTecnica] ADD 
	CONSTRAINT [FK_detFichaTecnica_catCaracteristicas] FOREIGN KEY 
	(
		[idCaracteristica]
	) REFERENCES [dbo].[catCaracteristicas] (
		[IdCaracteristica]
	),
	CONSTRAINT [FK_detFichaTecnica_FichaTecnica] FOREIGN KEY 
	(
		[idFicha]
	) REFERENCES [dbo].[FichaTecnica] (
		[IdFicha]
	)
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  View dbo.view_pareto    Script Date: 12/7/2007 1:54:42 ******/
create view view_pareto as select *,Peso*100 as Porcentaje from Pareto

GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  View dbo.BaseMatriz    Script Date: 12/7/2007 1:54:42 ******/
Create view BaseMatriz as

select m.Marca, a.Modelo, f.Descripcion, Valor=sum(Valor)
from dbo.catAutomovil a, dbo.catMarcas m, dbo.FichaTecnica hf, 
	dbo.detFichaTecnica df, dbo.catCaracteristicas c, 
	dbo.catFamilias f
where a.idAutomovil=hf.idAutomovil and a.idMarca=m.idMarca and 
	hf.idFicha=df.idFicha and Anio=2007 and 
	df.idCaracteristica=c.idCaracteristica and 
	c.IdFamilia = f.IdFamilia and 
	a.Activo=1 and c.Activo=1 and f.Activo=1 and
	f.idFamilia=1 --Precio
Group by m.marca, a.Modelo, f.Descripcion

Union

select m.Marca, a.Modelo, f.Descripcion, sum(Valor)
from dbo.catAutomovil a, dbo.catMarcas m, dbo.FichaTecnica hf, 
	dbo.detFichaTecnica df, dbo.catCaracteristicas c, 
	dbo.catFamilias f
where a.idAutomovil=hf.idAutomovil and a.idMarca=m.idMarca and 
	hf.idFicha=df.idFicha and Anio=2007 and 
	df.idCaracteristica=c.idCaracteristica and 
	c.IdFamilia = f.IdFamilia and 
	a.Activo=1 and c.Activo=1 and f.Activo=1 and
	f.idFamilia=2 --Rendimiento de combustible
Group by m.marca, a.Modelo, f.Descripcion

Union

select m.Marca, a.Modelo, f.Descripcion, sum(Valor)
from dbo.catAutomovil a, dbo.catMarcas m, dbo.FichaTecnica hf, 
	dbo.detFichaTecnica df, dbo.catCaracteristicas c, 
	dbo.catFamilias f
where a.idAutomovil=hf.idAutomovil and a.idMarca=m.idMarca and 
	hf.idFicha=df.idFicha and Anio=2007 and 
	df.idCaracteristica=c.idCaracteristica and 
	c.IdFamilia = f.IdFamilia and 
	a.Activo=1 and c.Activo=1 and f.Activo=1 and
	f.idFamilia=3 and valor>0 --Comodidad
Group by m.marca, a.Modelo, f.Descripcion


Union

select m.Marca, a.Modelo, f.Descripcion, sum(Valor)
from dbo.catAutomovil a, dbo.catMarcas m, dbo.FichaTecnica hf, 
	dbo.detFichaTecnica df, dbo.catCaracteristicas c, 
	dbo.catFamilias f
where a.idAutomovil=hf.idAutomovil and a.idMarca=m.idMarca and 
	hf.idFicha=df.idFicha and Anio=2007 and 
	df.idCaracteristica=c.idCaracteristica and 
	c.IdFamilia = f.IdFamilia and 
	a.Activo=1 and c.Activo=1 and f.Activo=1 and
	f.idFamilia=5 --Bajo costo de mantenimiento
Group by m.marca, a.Modelo, f.Descripcion

Union

select m.Marca, a.Modelo, f.Descripcion, sum(Valor)
from dbo.catAutomovil a, dbo.catMarcas m, dbo.FichaTecnica hf, 
	dbo.detFichaTecnica df, dbo.catCaracteristicas c, 
	dbo.catFamilias f
where a.idAutomovil=hf.idAutomovil and a.idMarca=m.idMarca and 
	hf.idFicha=df.idFicha and Anio=2007 and 
	df.idCaracteristica=c.idCaracteristica and 
	c.IdFamilia = f.IdFamilia and 
	a.Activo=1 and c.Activo=1 and f.Activo=1 and
	f.idFamilia=6 and valor>0 --Seguridad
Group by m.marca, a.Modelo, f.Descripcion

Union

select m.Marca, a.Modelo, f.Descripcion, sum(Valor)
from dbo.catAutomovil a, dbo.catMarcas m, dbo.FichaTecnica hf, 
	dbo.detFichaTecnica df, dbo.catCaracteristicas c, 
	dbo.catFamilias f
where a.idAutomovil=hf.idAutomovil and a.idMarca=m.idMarca and 
	hf.idFicha=df.idFicha and Anio=2007 and 
	df.idCaracteristica=c.idCaracteristica and 
	c.IdFamilia = f.IdFamilia and 
	a.Activo=1 and c.Activo=1 and f.Activo=1 and
	f.idFamilia=7 --Potencia
Group by m.marca, a.Modelo, f.Descripcion

Union

select m.Marca, a.Modelo, f.Descripcion, count(co.Activo)
from dbo.catAutomovil a, dbo.catMarcas m, dbo.FichaTecnica hf, 
	dbo.detFichaTecnica df, dbo.catCaracteristicas c, 
	dbo.catFamilias f, dbo.Colores co
where a.idAutomovil=hf.idAutomovil and a.idMarca=m.idMarca and 
	hf.idFicha=df.idFicha and hf.idFicha=co.idFicha and Anio=2007 and 
	df.idCaracteristica=c.idCaracteristica and 
	c.IdFamilia = f.IdFamilia and 
	a.Activo=1 and c.Activo=1 and f.Activo=1 and co.Activo=1 and
	f.idFamilia=8 --Color
Group by m.marca, a.Modelo, f.Descripcion

Union

select m.Marca, a.Modelo, f.Descripcion, Count(Valor)
from dbo.catAutomovil a, dbo.catMarcas m, dbo.FichaTecnica hf, 
	dbo.detFichaTecnica df, dbo.catCaracteristicas c, 
	dbo.catFamilias f
where a.idAutomovil=hf.idAutomovil and a.idMarca=m.idMarca and 
	hf.idFicha=df.idFicha and Anio=2007 and 
	df.idCaracteristica=c.idCaracteristica and 
	c.IdFamilia = f.IdFamilia and 
	a.Activo=1 and c.Activo=1 and f.Activo=1 and
	f.idFamilia=9 and valor>0 --Equipamento
Group by m.marca, a.Modelo, f.Descripcion

Union

select m.Marca, a.Modelo, f.Descripcion, r.Consultado
from dbo.catAutomovil a, dbo.catMarcas m, dbo.FichaTecnica hf, 
	dbo.detFichaTecnica df, dbo.catCaracteristicas c, 
	dbo.catFamilias f, RenombreMarca r
where a.idAutomovil=hf.idAutomovil and a.idMarca=m.idMarca and 
	hf.idFicha=df.idFicha and Anio=2007 and 
	df.idCaracteristica=c.idCaracteristica and 
	c.IdFamilia = f.IdFamilia and m.idMarca=r.idMarca and
	a.Activo=1 and c.Activo=1 and f.Activo=1 and
	f.idFamilia=10 --Renombre de la marca

Union

select m.Marca, a.Modelo, f.Descripcion, Count(Valor)
from dbo.catAutomovil a, dbo.catMarcas m, dbo.FichaTecnica hf, 
	dbo.detFichaTecnica df, dbo.catCaracteristicas c, 
	dbo.catFamilias f
where a.idAutomovil=hf.idAutomovil and a.idMarca=m.idMarca and 
	hf.idFicha=df.idFicha and --Anio=2007 and 
	df.idCaracteristica=c.idCaracteristica and 
	c.IdFamilia = f.IdFamilia and 
	a.Activo=1 and c.Activo=1 and f.Activo=1 and
	f.idFamilia=11 --A/A
Group by m.marca, a.Modelo, f.Descripcion



GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.CargaMatrizPersonalizado    Script Date: 12/7/2007 1:54:42 ******/

Create Procedure CargaMatrizPersonalizado @NombreTabla VarChar(80),@NombreTablaDetalles VarChar(80) as
-- drop procedure CargaMatrizPersonalizado

-- Declare @NombreTabla VarChar(20)
-- set @NombreTabla = 'Matriz070524'

--Select Nombre=@NombreTabla into ##tmpAux

Declare @sql VarChar(1500)
--Declare @NombreTabla VarChar(20)
--select @NombreTabla = Nombre from ##tmpAux

/* Cálculo para tipo 2: Decremental */
Set @sql = 'Select c.idCaracteristica, Total=sum(df.valor) '+
'into ##tmpValores1 '+
'from CatMarcas m, catAutomovil a, FichaTecnica f, ' + @NombreTablaDetalles + ' df, catCaracteristicas c '+
'where m.idMarca=a.idMarca and f.idAutomovil=a.idautomovil and f.idFicha=df.idFicha and c.idCaracteristica=df.idCaracteristica and '+
'	f.Activo=1 and a.Activo=1 and c.Tipo=2 '+
'Group by c.idCaracteristica'
Exec (@sql)

Set @sql = 'Select m.Marca, a.Modelo, c.Descripcion as ''Caracteristica'', c.idCaracteristica, '+
'	Proporcion=1-(sum(df.valor)/t.Total) '+
'into ##tmpCargaMatriz1 '+
'from CatMarcas m, catAutomovil a, FichaTecnica f, ' + @NombreTablaDetalles + ' df, catCaracteristicas c, ##tmpValores1 t '+
'where m.idMarca=a.idMarca and f.idAutomovil=a.idautomovil and f.idFicha=df.idFicha and '+
'	c.idCaracteristica=df.idCaracteristica and t.idCaracteristica=c.idCaracteristica and '+
'	f.Activo=1 and a.Activo=1 and c.Tipo=2 '+
'Group by m.Marca, a.Modelo, c.Descripcion, c.idCaracteristica, t.Total '+
'order by c.Descripcion asc, proporcion asc'
Exec (@sql)

drop table ##tmpValores1

Select cf.idFamilia,cf.Descripcion as 'Familia',t.*, P.Peso, Factor = t.Proporcion * p.Peso * -1
	into ##tmpMatriz
from ##tmpCargaMatriz1 t,
	catCaracteristicas c, catFamilias cf, relPuntoFamilia r, catPuntosAdquisicion pa, Pareto p
where t.idCaracteristica=c.idCaracteristica and 
	c.idFamilia=cf.idFamilia and cf.idFamilia=r.idFamilia and pa.idPunto=r.idPunto and pa.idPunto=p.idPunto

drop table ##tmpCargaMatriz1

/* Cálculo para tipo 1 : Incremental */
Set @sql = 'Select c.idCaracteristica, Total=sum(df.valor) '+
'into ##tmpValores2 '+
'from CatMarcas m, catAutomovil a, FichaTecnica f, '+ @NombreTablaDetalles + ' df, catCaracteristicas c '+
'where m.idMarca=a.idMarca and f.idAutomovil=a.idautomovil and f.idFicha=df.idFicha and c.idCaracteristica=df.idCaracteristica and '+
'	f.Activo=1 and a.Activo=1 and c.Tipo=1 '+     -- <- Diferencia con tipo 2
'Group by c.idCaracteristica'
Exec (@sql)

Set @sql = 'Select m.Marca, a.Modelo, c.Descripcion as ''Caracteristica'', c.idCaracteristica, '+
'	Proporcion=(sum(df.valor)/t.Total) '+  	      -- <- Diferencia con tipo 2
'into ##tmpCargaMatriz2 '+
'from CatMarcas m, catAutomovil a, FichaTecnica f, ' + @NombreTablaDetalles + ' df, catCaracteristicas c, ##tmpValores2 t '+
'where m.idMarca=a.idMarca and f.idAutomovil=a.idautomovil and f.idFicha=df.idFicha and '+
'	c.idCaracteristica=df.idCaracteristica and t.idCaracteristica=c.idCaracteristica and '+
'	f.Activo=1 and a.Activo=1 and c.Tipo=1 '+     -- <- Diferencia con tipo 2
'Group by m.Marca, a.Modelo, c.Descripcion, c.idCaracteristica, t.Total '+
'order by c.Descripcion asc, proporcion asc'
Exec (@sql)

drop table ##tmpValores2

insert into ##tmpMatriz
Select cf.idFamilia,cf.Descripcion as 'Familia',t.*, P.Peso, Factor = t.Proporcion * p.Peso
from ##tmpCargaMatriz2 t, 
	catCaracteristicas c, catFamilias cf, relPuntoFamilia r, catPuntosAdquisicion pa, Pareto p
where t.idCaracteristica=c.idCaracteristica and
	c.idFamilia=cf.idFamilia and cf.idFamilia=r.idFamilia and pa.idPunto=r.idPunto and pa.idPunto=p.idPunto

drop table ##tmpCargaMatriz2

/* Cálculo para tipo 0 : Boleano */
Set @sql = 'Select m.Marca, a.Modelo, c.Descripcion as ''Caracteristica'', c.idCaracteristica, '+
'	Proporcion=df.Valor '+  			-- <- Diferencia con tipo 2
'into ##tmpCargaMatriz3 '+
'from CatMarcas m, catAutomovil a, FichaTecnica f, ' + @NombreTablaDetalles + ' df, catCaracteristicas c '+
'where m.idMarca=a.idMarca and f.idAutomovil=a.idautomovil and f.idFicha=df.idFicha and '+
'	c.idCaracteristica=df.idCaracteristica and '+
'	f.Activo=1 and a.Activo=1 and c.Tipo=0 '+ 	-- <- Diferencia con tipo 2
'order by c.Descripcion asc, proporcion asc'
Exec (@sql)

insert into ##tmpMatriz
Select cf.idFamilia,cf.Descripcion as 'Familia',t.*, P.Peso, Factor = t.Proporcion * p.Peso
from ##tmpCargaMatriz3 t, 
	catCaracteristicas c, catFamilias cf, relPuntoFamilia r, catPuntosAdquisicion pa, Pareto p
where t.idCaracteristica=c.idCaracteristica and
	c.idFamilia=cf.idFamilia and cf.idFamilia=r.idFamilia and pa.idPunto=r.idPunto and pa.idPunto=p.idPunto

drop table ##tmpCargaMatriz3

/* Graba la matriz de pagos en la tabla seleccionada */
-- Declare @sql VarChar(500)
-- Declare @NombreTabla VarChar(20)
-- select @NombreTabla = Nombre from ##tmpAux

Set @sql = 'Select * into ' + @NombreTabla + ' from ##tmpMatriz Order by Marca, Modelo'
Exec (@sql)

drop table ##tmpMatriz
--drop table ##tmpAux

/*
Declare @sql VarChar(1500)
Declare @nombre VarChar(150)

Set @nombre ='Cesar' 
Set @sql ='Exec detFichaTecnicaPersonalizado ''sc' + @nombre + 'FichaTecnica'''
select @sql as 'sql'
Exec (@sql)

Set @sql ='Exec CargaMatrizPersonalizado ''sc' + @nombre + 'Matriz'', ''sc' + @nombre + 'FichaTecnica'''
select @sql as 'sql'
Exec (@sql)
*/

/*
Declare @sql VarChar(1500)
Declare @nombre VarChar(150)

Set @nombre ='Cesar' 
Set @sql ='drop table sc' + @nombre + 'FichaTecnica'
select @sql as 'sql'
Exec (@sql)

Set @sql ='drop table sc' + @nombre + 'Matriz'
select @sql as 'sql'
Exec (@sql)
*/

/*
Exec detFichaTecnicaPersonalizado 'scCesarFichaTecnica'
select * from scCesarFichaTecnica

Exec CargaMatrizPersonalizado 'scCesarMatriz','scCesarFichaTecnica'
select * from scCesarMatriz

-- drop table scCesarFichaTecnica
-- drop table scCesarMatriz
*/


GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.CargaPareto_Old    Script Date: 12/7/2007 1:54:42 ******/
Create Procedure CargaPareto as

-- Elimina registros anteriores
Delete Pareto

-- Declaración de variables
Declare @Id int, @Descripcion VarChar(30), @Puntaje int, @Acumulador int, @Total int, @Peso real
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
    Set @Peso = Convert(real, @Acumulador)/Convert(real, @Total)
    --Select @Id, @Descripcion, @Puntaje, @Acumulador, @Peso

    Insert into Pareto (IdPunto, Descripcion, Peso) values (@Id, @Descripcion, @Peso)
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

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.createMatrixTables    Script Date: 12/7/2007 1:54:42 ******/
Create Procedure createMatrixTables @nombre varChar(80) as
declare @sql as varchar(1500)
set @sql = 'Exec detFichaTecnicaPersonalizado ''sc' + @nombre + 'FichaTecnica'' '
select @sql as 'sql'
Exec (@sql)
set @sql = 'select *  from sc' + @nombre + 'FichaTecnica order by idFicha,idCaracteristica'
select @sql as 'sql'
Exec (@sql)

set @sql = 'Exec CargaMatrizPersonalizado ''sc' + @nombre + 'Matriz'',''sc' + @nombre + 'FichaTecnica'' '
select @sql as 'sql'
-- 'select '+@sql+' as ''sql'' ' +
Exec (@sql)
set @sql = 'select *  from sc' + @nombre + 'Matriz order by Marca,Modelo,Caracteristica'
select @sql as 'sql'
Exec (@sql)


GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.deleteIfExists    Script Date: 12/7/2007 1:54:42 ******/
Create Procedure deleteIfExists @nombre varChar(80) as
declare @sql as varchar(1500)
-- declare @nombre as varchar(150)
-- set @nombre = 'Cesar'
set @sql = 'declare @checa as varchar(5) '+
'if exists (select * from dbo.sysobjects where '+
'id = object_id(N''[dbo].[sc' + @nombre + 'FichaTecnica]'') and OBJECTPROPERTY(id, N''IsUserTable'') = 1) '+
'BEGIN '+
'drop table [dbo].[sc' + @nombre + 'FichaTecnica] '+
'set @checa = 1 '+
' END '+
'ELSE '+
'BEGIN '+
'set @checa = 0 '+
'END '+
'select @checa as ''checa1'''
-- ' PRINT @checa'
Exec (@sql)

set @sql = 'declare @checa as varchar(5) '+
'if exists (select * from dbo.sysobjects where '+
'id = object_id(N''[dbo].[sc' + @nombre + 'Matriz]'') and OBJECTPROPERTY(id, N''IsUserTable'') = 1) '+
'BEGIN '+
'drop table [dbo].[sc' + @nombre + 'Matriz] '+
'set @checa = 1 '+
' END '+
'ELSE '+
'BEGIN '+
'set @checa = 0 '+
'END '+
'select @checa as ''checa2'''
-- ' PRINT @checa'
Exec (@sql)



GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.ifExists    Script Date: 12/7/2007 1:54:42 ******/
Create Procedure ifExists @nombre varChar(80) as
declare @sql as varchar(1500)
-- declare @nombre as varchar(150)
-- set @nombre = 'Original'
set @sql = 'declare @checa as varchar(5) '+
'if exists (select * from dbo.sysobjects where '+
'id = object_id(N''[dbo].[sc' + @nombre + 'FichaTecnica]'') and OBJECTPROPERTY(id, N''IsUserTable'') = 1) '+
'BEGIN '+
'set @checa = 1 '+
' END '+
'ELSE '+
'BEGIN '+
'set @checa = 0 '+
'END '+
'select @checa as ''checa1'''
-- ' PRINT @checa'
Exec (@sql)

set @sql = 'declare @checa as varchar(5) '+
'if exists (select * from dbo.sysobjects where '+
'id = object_id(N''[dbo].[sc' + @nombre + 'Matriz]'') and OBJECTPROPERTY(id, N''IsUserTable'') = 1) '+
'BEGIN '+
'set @checa = 1 '+
' END '+
'ELSE '+
'BEGIN '+
'set @checa = 0 '+
'END '+
'select @checa as ''checa2'''
-- ' PRINT @checa'
Exec (@sql)


GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.ConsultaEncuesta    Script Date: 12/7/2007 1:54:42 ******/
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

GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.CalculaRenombre    Script Date: 12/7/2007 1:54:42 ******/

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

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.CargaPareto    Script Date: 12/7/2007 1:54:42 ******/


Create Procedure CargaPareto as

-- Elimina registros anteriores
Delete Pareto

-- Declaración de variables
Declare @Id int, @Descripcion VarChar(30), @Puntaje int, @Calificacion int
Declare @Acumulador int, @Total int, @NumPareto real, @Peso real
Declare @Maximo int   -- Calificación global máxima que puede tener un punto 
Declare @CalifMax int -- Calificación máxima que puede tener un punto en una encuesta

Select @Total=count(*)
	from PuntoAdquisicion a, catPuntosAdquisicion b, Encuesta e
	Where a.idPunto=b.idPunto and b.Activo=1 and e.idEncuesta=a.idEncuesta and e.Activo=1

Select @CalifMax=max(Orden) 
from PuntoAdquisicion a, Encuesta e 
where a.idEncuesta=e.idEncuesta and e.Activo=1

Select @Maximo=count(*) * @CalifMax
	from Encuesta e
	Where e.activo=1

Set @Acumulador=0  --El set indica operación entre variables de memoria, NO CAMPOS

-- Creación del cursor
Declare Pareto Cursor For
-- Total Unto, al únicamente contar, considera el número de hits sin importar el peso para cada persona que tenga un punto determinado
Select b.IdPunto, b.Descripcion, count(a.IdPunto) as 'Total Punto', sum((@CalifMax-a.Orden)+1) as 'Calif Punto' 
from PuntoAdquisicion a, catPuntosAdquisicion b, Encuesta e
Where a.idPunto=b.idPunto and b.Activo=1 and e.idEncuesta=a.idEncuesta and e.Activo=1
group by b.IdPunto, b.Descripcion 
order by 'Total Punto' asc

-- Apertura del cursor
Open Pareto

-- Lee el registro actual y se posiciona en el siguiente registro
Fetch Next From Pareto into @Id, @Descripcion, @Puntaje, @Calificacion

-- Ciclo Do - While
While @@Fetch_Status=0
    Begin
    Set @Acumulador = @Acumulador + @Puntaje
    Set @NumPareto = Convert(real, @Acumulador)/Convert(real, @Total)
    Set @Peso = Convert(real,@Calificacion) / Convert(real,@Maximo)
    --Select @Id, @Descripcion, @Puntaje, @Acumulador, @NumPareto, @Calificacion, @Peso, @Total, @Maximo

    Insert into Pareto (IdPunto, Descripcion, NumPareto, Peso) values (@Id, @Descripcion, @NumPareto, @Peso)
    Fetch Next From Pareto into @Id, @Descripcion, @Puntaje, @Calificacion
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

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.detFichaTecnicaPersonalizado    Script Date: 12/7/2007 1:54:42 ******/
-- drop procedure detFichaTecnicaPersonalizado
Create Procedure detFichaTecnicaPersonalizado @NombreTabla VarChar(80) as

-- Declare @NombreTabla VarChar(20)
-- set @NombreTabla = 'Cesar'

--Select Nombre=@NombreTabla into ##tmpAux

Select * into ##tmpdetFichaTecnica from detFichaTecnica
/* Graba la matriz de pagos en la tabla seleccionada */
Declare @sql VarChar(500)
--Declare @NombreTabla VarChar(20)
--select @NombreTabla = Nombre from ##tmpAux

Set @sql = 'Select * into ' + @NombreTabla + ' from ##tmpdetFichaTecnica df Order by df.idFicha,df.idCaracteristica'
Exec (@sql)
drop table ##tmpdetFichaTecnica

/* Ejecucion del procedimiento
Exec detFichaTecnicaPersonalizado 'CargaMatrizDetalleFichaTecnica'
select * from CargaMatrizDetalleFichaTecnica
drop table CargaMatrizDetalleFichaTecnica
*/

GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

