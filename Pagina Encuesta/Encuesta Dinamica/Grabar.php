<html>
<head>
	<title>Grabar</title>
</head>
<?
//    error_reporting(E_ALL);
    error_reporting(0);
	include("Class/conEstacion.php");
	$conex = new conEstacion();
	
	//$Fecha = $txtAnio."/".$txtMes."/".$txtDia;
	$Fecha = $txtAnio."-".$txtMes."-".$txtDia." 00:00:00";
/*
	$SQL="INSERT into Encuesta(INSERT INTO Encuesta (Compra4Anios, Fecha, TiempoDeCompra, IdMotivo, Nuevo, IdMedioPago, IdAutomovil, Costo";
	$SQL.=",Seguro, IdPunto, InfluenciaVendedor, IdComoSupo,IdUsoPrimario, RangoEdad, IdEstadoCivil, Sexo, IdLugar, IdEntrevistador)";
	$SQL="values('$radComprado','$Fecha','$txtTiempo','$comMotivoDeC','$radEstado','$comMedio','$comAutomovil','$txtCosto','$radSeguro',";
	$SQL="'$comPuntos','$radInfluyo','$comComoSupo','$comUsoPrimario','$comEdad','$comEstadoCivil','$radSexo','$comLugares','$comEntrevistadores')";
*/
	$SQL="INSERT into Encuesta(Compra4Anios, Fecha, TiempoDeCompra, IdMotivo, Nuevo, IdMedioPago, IdAutomovil, Costo";
	$SQL.=",Seguro, IdPunto, InfluenciaVendedor, IdComoSupo,IdUsoPrimario, RangoEdad, IdEstadoCivil, Sexo, IdLugar, IdEntrevistador)";
	$SQL.="values($radComprado,CONVERT(DATETIME,'$Fecha',102),$txtTiempo,$comMotivoDeC,$radEstado,$comMedio,$comAutomovil,$txtCosto,$radSeguro,";
	$SQL.="$comPuntos,$radInfluyo,$comComoSupo,$comUsoPrimario,$comEdad,$comEstadoCivil,$radSexo,$comLugares,$comEntrevistadores)";
	$datos=$conex->ejecutarQuerySQL($SQL);
?>
<body>
	<P> <font size="+7">GRACIAS </font></P>
	<p align="left"><a href="Encuesta.php"><font face="Courier New, Courier, mono">Regresar</font></a></p>
</body>
</html>
