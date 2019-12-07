<html>
<head>
	<title>Grabar</title>
</head>
<?
//	error_reporting(E_ALL);
    error_reporting(0);
	include("Class/conEstacion.php");
	$conex = new conEstacion();
	
	//$Fecha = $txtAnio."/".$txtMes."/".$txtDia;
	$Fecha = $txtAnio."-".$txtMes."-".$txtDia." 00:00:00";

	$SQL="INSERT into Encuesta(Compra4Anios, Fecha, TiempoDeCompra, IdMotivo, Nuevo, IdMedioPago, IdAutomovil, Costo";
	$SQL.=",Seguro, InfluenciaVendedor, IdComoSupo,IdUsoPrimario, RangoEdad, IdEstadoCivil, Sexo, IdLugar, IdEntrevistador)";
	$SQL.="values($radComprado,CONVERT(DATETIME,'$Fecha',102),$txtTiempo,$comMotivoDeC,$radEstado,$comMedio,$comAutomovil,$txtCosto,";
	$SQL.="$radSeguro,$radInfluyo,$comComoSupo,$comUsoPrimario,$comEdad,$comEstadoCivil,$radSexo,$comLugares,$comEntrevistadores)";
	$datos=$conex->ejecutarQuerySQL($SQL);

	$SQL="SELECT @@identity as IdEncuesta";
	$Encuesta=$conex->ejecutarQuerySQL($SQL);
	$IdEncuesta=$Encuesta[0]["IdEncuesta"];
	
	$orden=0;
	if ($comComparaOrden1!=0){
		$SQL="INSERT into ComparacionAutomovil(IdAutomovil,IdEncuesta,Orden) values ($comComparaOrden1,$IdEncuesta,$orden+1)";
		$comparacionAutos1=$conex->ejecutarQuerySQL($SQL);
	}

	if ($comComparaOrden2!=0){
		$SQL="INSERT into ComparacionAutomovil(IdAutomovil,IdEncuesta,Orden) values ($comComparaOrden2,$IdEncuesta,$orden+2)";
		$comparacionAutos2=$conex->ejecutarQuerySQL($SQL);
	}

	if ($comComparaOrden3!=0){
		$SQL="INSERT into ComparacionAutomovil(IdAutomovil,IdEncuesta,Orden) values ($comComparaOrden3,$IdEncuesta,$orden+3)";
		$comparacionAutos3=$conex->ejecutarQuerySQL($SQL);
	}

	if ($comComparaOrden4!=0){
		$SQL="INSERT into ComparacionAutomovil(IdAutomovil,IdEncuesta,Orden) values ($comComparaOrden4,$IdEncuesta,$orden+4)";
		$comparacionAutos4=$conex->ejecutarQuerySQL($SQL);
	}

	if ($comComparaOrden5!=0){
		$SQL="INSERT into ComparacionAutomovil(IdAutomovil,IdEncuesta,Orden) values ($comComparaOrden5,$IdEncuesta,$orden+5)";
		$comparacionAutos5=$conex->ejecutarQuerySQL($SQL);
	}
	
	$orden=0;
	if ($comPuntosOrden1!=0){
		$SQL="INSERT into PuntoAdquisicion(IdPunto,IdEncuesta,Orden) values ($comPuntosOrden1,$IdEncuesta,$orden+1)";
		$puntosAdquisicion1=$conex->ejecutarQuerySQL($SQL);
	}

	if ($comPuntosOrden2!=0){
		$SQL="INSERT into PuntoAdquisicion(IdPunto,IdEncuesta,Orden) values ($comPuntosOrden2,$IdEncuesta,$orden+2)";
		$puntosAdquisicion2=$conex->ejecutarQuerySQL($SQL);
	}
	
	if ($comPuntosOrden3!=0){
		$SQL="INSERT into PuntoAdquisicion(IdPunto,IdEncuesta,Orden) values ($comPuntosOrden3,$IdEncuesta,$orden+3)";
		$puntosAdquisicion3=$conex->ejecutarQuerySQL($SQL);
	}

	if ($comPuntosOrden4!=0){
		$SQL="INSERT into PuntoAdquisicion(IdPunto,IdEncuesta,Orden) values ($comPuntosOrden4,$IdEncuesta,$orden+4)";
		$puntosAdquisicion4=$conex->ejecutarQuerySQL($SQL);
	}
	
	if ($comPuntosOrden5!=0){
		$SQL="INSERT into PuntoAdquisicion(IdPunto,IdEncuesta,Orden) values ($comPuntosOrden5,$IdEncuesta,$orden+5)";
		$puntosAdquisicion5=$conex->ejecutarQuerySQL($SQL);
	}
?>
<body>
	<P> <font size="+7">GRACIAS </font></P>
	<p align="left"><a href="Encuesta.php"><font face="Courier New, Courier, mono">Regresar</font></a></p>
	<P> <font size="+2">Apunta este folio en la encuesta : <? echo $IdEncuesta ?> </font></P>
</body>
</html>
