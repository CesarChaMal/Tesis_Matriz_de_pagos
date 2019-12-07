<?
    error_reporting(E_ALL);

	if(!(isset($comMarcas))){
		$comMarcas="";
	}
	if(!(isset($checa))){
		$checa="";
	}
	if(!(isset($radComprado))){
		$radComprado="si";
	}
/*
	if(!(isset($variable))){
		$variable="";
	}

	if($comMarcas!=""){
		$comMarcas="";
	}
*/
//    error_reporting(0);

	include("Class/conEstacion.php");
	$conex = new conEstacion();

	$SQL="SELECT * FROM catMotivos";
	$catMotivos = $conex->ejecutarQuerySQL($SQL);

	$SQL="SELECT * FROM catMedioPago";
	$catMedioPago = $conex->ejecutarQuerySQL($SQL);

	$SQL="SELECT * FROM catMarcas";
	$catMarcas = $conex->ejecutarQuerySQL($SQL);

	$SQL="SELECT * FROM catPuntosAdquisicion";
	$catPuntos = $conex->ejecutarQuerySQL($SQL);
	
	$SQL="SELECT * FROM catComoSupo";
	$catComoSupo = $conex->ejecutarQuerySQL($SQL);

	$SQL="SELECT * FROM catUsoPrimario";
	$catUsoPrimario = $conex->ejecutarQuerySQL($SQL);

	$SQL="SELECT * FROM catEstadoCivil";
	$catEstadoCivil = $conex->ejecutarQuerySQL($SQL);

	$SQL="SELECT * FROM catEntrevistadores";
	$catEntrevistadores = $conex->ejecutarQuerySQL($SQL);

	$SQL="SELECT * FROM catLugares";
	$catLugares = $conex->ejecutarQuerySQL($SQL);
/*
	if ($checa=="si"){
		$parametro="Grabar.php";
	}else{
		$parametro="Encuesta.php";
	}*/
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Encuesta</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
.Estilo1 {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-weight: bold;
	font-size: 18px;
}
.Estilo6 {font-size: 12px}
-->
</style>
</head>
<script language="JavaScript">
	function Empezar(pagina){
		var f=document.form;
		if (pagina=="Grabar.php"){
			f.action="Grabar.php";
			f.submit();
		}
	}	

	function Actualiza(){
		var f=document.form;
	    //var Marca;
		//Marca = document.form.Marcas[document.form.Marcas.selectedIndex].value;
		//f.comMarcas.options[f.comMarcas.selectedIndex].value;
		//if(variable == Marca){
			//f.comMarcas.options[f.pais.selectedIndex];			
		//}
		f.submit;
	}
	
	function checarDia(){
		var f=document.form;
		if ((isNaN (f.txtDia.value)) || ((f.txtDia.value<1) || (f.txtDia.value>31))){
			f.txtDia.value="";
		}
	}

	function checarMes(){
		var f=document.form;
		if ((isNaN (f.txtMes.value)) || ((f.txtMes.value<1) || (f.txtMes.value>12))){
			f.txtMes.value="";
		}
	}

	function checarAnio(){
		var f=document.form;
		if ((isNaN (f.txtAnio.value)) || ((f.txtAnio.value<1900) || (f.txtAnio.value>2006))){
			f.txtAnio.value="";
		}
	}

	function checarNumero(f){
		if (isNaN (f.value)){//IsNaN Is Not a Numeric si no es numero
			f.value="";
		}
	}
	
	function storage(){
		var f=document.form;
		$f.varstorage=f.comMarcas.options[f.comMarcas.selectedIndex].value;
	}	

	function validar(){
		var f=document.form,a="",band=0,band1=0,band3=0,band4=0,band5=0,i,resp;
		resp=confirm("Esta seguro de grabar");
		if(resp){
// validando radComprado
			for (i=0;i<f.radComprado.length;i++)
				if(f.radComprado[i].checked)
					band=1;
			if(band==0)
				a+="\nProporciona una respuesta a si ha adquirido un automovil en los ultimos 4 años";
// validando el Dia
			if(f.txtDia.value=="")
				a+="\nProporciona el Dia";
// validando el Mes
			if(f.txtMes.value=="")
				a+="\nProporciona el Mes";
// validando el Año
			if(f.txtAnio.value=="")
				a+="\nProporciona el Año";
// validando el tiempo transcurrido
			if(f.txtTiempo.value=="")
				a+="\nProporciona el Tiempo transcurrido";
// validando el motivo de la compra del automovil
			if(f.comMotivoDeC.options[f.comMotivoDeC.selectedIndex].value==0)
				a+="\nProporciona un motivo para haber comprado un Automovil";
// validando si es nuevo o usado
			for (i=0;i<f.radEstado.length;i++)
				if(f.radEstado[i].checked)
					band1=1;
			if(band1==0)
				a+="\nProporciona si es nuevo o usado";
// validando medio por el cual adquirio el automovil
			if(f.comMedio.options[f.comMedio.selectedIndex].value==0)
				a+="\nProporciona el medio por el cual adquiriste el automovil";
// validando la marca
			if(f.comMarcas.options[f.comMarcas.selectedIndex].value==0)
				a+="\nProporciona el marca del automovil comprado";
// validando el modelo del auto comprado
			if(f.comAutomovil.options[f.comAutomovil.selectedIndex].value==0)
				a+="\nProporciona un modelo para el automovil comprado";
// validando el costo aproximado
			if(f.txtCosto.value=="")
				a+="\nProporciona el costo aproximado";
// validando si tiene seguro o no
			for (i=0;i<f.radSeguro.length;i++)
				if(f.radSeguro[i].checked)
					band3=1;
			if(band3==0)
				a+="\nProporciona si tiene seguro o no";
// validando la marca del auto con el que comparaste
			if(f.comComparaMarcas.options[f.comComparaMarcas.selectedIndex].value==0)
				a+="\nProporciona el modelo con el cual comparaste el automovil comprado";
// validando comparar con otro modelo el auto comprado
			if(f.comComparaAutomovil.options[f.comComparaAutomovil.selectedIndex].value==0)
				a+="\nProporciona el modelo con el cual comparaste el automovil comprado";
// validando los 5 puntos por el que se decididio comprar el automovil
			if(f.comPuntos.options[f.comPuntos.selectedIndex].value==0)
				a+="\nProporciona los 5 principales puntos que te hicieron decidir comprar el auto";
// validando si el vendedor influyo en la decision de la compra del automovil
			for (i=0;i<f.radInfluyo.length;i++)
				if(f.radInfluyo[i].checked)
					band4=1;
			if(band4==0)
				a+="\nProporciona si el vendedor influyo en la compra";
// validando como supo de la marca y modelo que compro
			if(f.comComoSupo.options[f.comComoSupo.selectedIndex].value==0)
				a+="\nProporciona como supo de la marca y modelo adquiridos";
// validando el uso primario del auto adquirido
			if(f.comUsoPrimario.options[f.comUsoPrimario.selectedIndex].value==0)
				a+="\nProporciona el uso primario del auto adquirido";
// validando el rango de la edad al momento de la compra
			if(f.comEdad.options[f.comEdad.selectedIndex].value==0)
				a+="\nProporciona el rango de la edad al momento de la compra";
// validando el estado civil al momento de la compra
			if(f.comEstadoCivil.options[f.comEstadoCivil.selectedIndex].value==0)
				a+="\nProporciona el estado civil al momento de la compra";
// validando el sexo
			for (i=0;i<f.radSexo.length;i++)
				if(f.radSexo[i].checked)
					band5=1;
			if(band5==0)
				a+="\nProporciona el sexo";
// validando el entrevistador
			if(f.comEntrevistadores.options[f.comEntrevistadores.selectedIndex].value==0)
				a+="\nProporciona el nombre del entrevistador";
// validando el lugar de la entrevista
			if(f.comLugares.options[f.comLugares.selectedIndex].value==0)
				a+="\nProporciona el lugar donde se llevo a cabo la entrevista";
// validando si todo sale bien se activa el action de la form
			if(a=="")
				f.submit();
			else
				alert(a);
		}
	}	
</script>
<!-- <body onLoad="Empezar('<?=// $parametro; ?>')"> -->
<body>
	<form name="form" method="get" action="">
	<? if ($checa==""){ ?>
		<input type="hidden" name="checa" value="no"> 
	<? }else{	?>
		<input type="hidden" name="checa" value="si">
	<?	}	?>
	<center>
		<p>&nbsp;</p>
		<table border="0">
			<tr>
    			<td height="10" align="left">
						<table>
							<tr>
								<td>
					  				<img src="cel.jpg" width="30" height="50"> 
								</td>
								<td>
<!--					<center> -->
									<h2 class="Estilo1 Estilo6">Esta encuesta es parte del proceso de investigaci&oacute;n de una tesis recepcional.</h2>
									<h2 class="Estilo1 Estilo6">Gracias por su apoyo</h2>
								</td>
							</tr>
						</table>
<!--					</center> -->			 
 				</td>
  			</tr>
  			<tr>
				<td align="left">
					<table>
						<tr>
							<td align="left">
			<!--				<blockquote> -->
								1.- ¿ Ha comprado un autom&oacute;vil en los &uacute;ltimos 4 a&ntilde;os ? 
			<!--				</blockquote> -->
							</td>
							<td>
								<table>
									<tr>
										<? if ($checa=="")?>
											<?	if ($radComprado==1){ ?>
												<td align="center">
													<input type="radio" name="radComprado" value="1" checked>
													Si
												</td>
												<td align="center">
													<input type="radio" name="radComprado" value="0">
													No
												</td>
											<?	}else{	
													if ($radComprado==0){?>
														<td align="center">
															<input type="radio" name="radComprado" value="1">
															Si
														</td>
														<td align="center">
															<input type="radio" name="radComprado" value="0" checked>
															No
														</td>
													<? }else{	?>
														<td align="center">
															<input type="radio" name="radComprado" value="1">
															Si
														</td>
														<td align="center">
															<input type="radio" name="radComprado" value="0">
															No
														</td>
													<?	}	?>
											<?	}	?>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>	
				<td>&nbsp;</td>
			</tr>
  			<tr>
    			<td align="left">
					2.- Fecha aproximada de compra.
					  <input type="text" name="txtDia" size="2" onBlur="checarDia()">
					/ <input type="text" name="txtMes" size="2" onBlur="checarMes()">
					/ <input type="text" name="txtAnio" size="4" onBlur="checarAnio()">
					(dd/mm/aaaa)
				</td>
  			</tr>
			<tr>	
				<td>&nbsp;</td>
			</tr>
  			<tr>
   				<td align="left">
					3.- ¿ Cu&aacute;nto tiempo transcurri&oacute; entre tomar la desici&oacute;n y adquirir la unidad ? 
					<input type="text" name="txtTiempo" size="2" onBlur="checarNumero(txtTiempo)"> 
				  	meses
				</td>
  			</tr>
			<tr>	
				<td>&nbsp;</td>
			</tr>
  			<tr>
				<td>
					<table>
						<tr>
							<td align="left">
								4.- ¿ Qu&eacute; le hizo adquirir un auto ?
							</td>
							<td align="center">
								<? 
									if(count($catMotivos)!=0){?>
										<select name="comMotivoDeC">
											<option value="0" selected>Seleccione...</option>
											<? for($i=0;$i<count($catMotivos);$i++){?>
													<option value="<?=$i+1 ?>"><? echo $catMotivos[$i]["Descripcion"]; ?></option>
											<? } ?>
										</select>
								<?  } ?>
							</td>
						</tr>
					</table>
				</td>
  			</tr>
			<tr>	
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>
					<table>
						<tr>
							<td colspan="1" align="left">
								5.- ¿ El autom&oacute;vil fue nuevo o usado ?
							</td>
							<td align="left">
								<table>
									<tr>
										<td align="center">
											<input type="radio" name="radEstado" value="1">
											Nuevo
										</td>
										<td align="center">
											<input type="radio" name="radEstado" value="0">
											Usado
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>	
			<tr>
				<td>&nbsp;</td>
			</tr>
  			<tr>
				<td>
					<table>
						<tr>
							<td align="left">
								6.- ¿ Por qu&eacute; medio adquir&iacute;o la unidad ?
							</td>
							<td align="center">
								<? 
									if(count($catMedioPago)!=0){?>
										<select name="comMedio">
											<option value="0" selected>Seleccione...</option>
											<? for($i=0;$i<count($catMedioPago);$i++){?>
													<option value="<?=$i+1 ?>"><? echo $catMedioPago[$i]["Descripcion"]; ?></option>
											<? } ?>
										</select>
								<?  } ?>
							</td>
						</tr>
					</table>
				</td>
  			</tr>
			<tr>	
				<td>&nbsp;</td>
			</tr>
  			<tr>
				<td>
					<table>
						<tr>
							<td align="left">
								7.- ¿ Qu&eacute; marca lo comercializa y que modelo es ?
							</td>
							<td align="left">
								Marca : 
								<? 
									if(count($catMarcas)!=0){?>
<!--										<select name="comMarcas" onChange="<script> document.form.submit() </script>">-->
										<select name="comMarcas" id="comMarcas" onChange="this.form.submit()">
											<option value="0" selected>Seleccione...</option>
											<? for($i=0;$i<count($catMarcas);$i++){?>
													<option value="<?=$i+1?>"><? echo $catMarcas[$i]["Marca"]; ?></option>
											<? } ?>
										</select>
							</td>
							<td align="center">
								Modelo :
										<? 
											$SQL="SELECT * FROM catAutomovil WHERE IdMarca = '$comMarcas'";
											//$SQL="SELECT * IdAutomovil,a.nombre AS Modelo FROM catMarcas m, catAutomovil a WHERE m.IdMarca=a.IdMarca and a.IdMarca='$comMarcas' and a.Activo=1";

											$catAutomovil = $conex->ejecutarQuerySQL($SQL);
											//if(count($catAutomovil)!=0){?>
												<select name="comAutomovil" id="comAutomovil" >
													<option value="0" selected>Seleccione...</option>
													<? for($i=0;$i<count($catAutomovil);$i++){?>
														<option value="<?=$i+1?>"><? echo $catAutomovil[$i]["Modelo"]; ?></option>
													<? } ?>
												</select>
										<? // } ?>
							</td>
								<?  } ?>
						</tr>
					</table>
				</td>
  			</tr>
			<tr>	
				<td>&nbsp;</td>
			</tr>
  			<tr>
				<td>
					<table>
						<tr>
							<td align="left">
								8.- Costo total aproximado de la unidad
								<input type="text" name="txtCosto" size="10"  onBlur="checarNumero(txtCosto)">.
								Incluye seguro
							</td>
							<td align="left">
								<table>
									<tr>
										<td align="center">
											<input type="radio" name="radSeguro" value="1">
											Si
										</td>
										<td align="center">
											<input type="radio" name="radSeguro" value="0">
											No
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
  			</tr>
			<tr>	
				<td>&nbsp;</td>
			</tr>
  			<tr>
				<td>
					<table>
						<tr>
							<td align="left">
								9.- ¿ Compar&oacute; con otras marcas/modelos ? Indicar cuales.
							</td>
							<td align="left">
								Marca : 
								<? 
									if(count($catMarcas)!=0){?>
										<select name="comComparaMarcas">
											<option value="0" selected>Seleccione...</option>
											<? for($i=0;$i<count($catMarcas);$i++){?>
													<option value="<?=$i+1?>"><? echo $catMarcas[$i]["Marca"]; ?></option>
											<? } ?>
										</select>
							</td>
							<td align="center">
								Modelo :
										<? 
											//$SQL="SELECT * FROM catAutomovil WHERE IdMarca = '$categoria'";
											$SQL="SELECT * FROM catAutomovil";
											$catAutomovil = $conex->ejecutarQuerySQL($SQL);
											if(count($catAutomovil)!=0){?>
												<select name="comComparaAutomovil">
													<option value="0" selected>Seleccione...</option>
													<? for($i=0;$i<count($catAutomovil);$i++){?>
														<option value="<?=$i+1?>"><? echo $catAutomovil[$i]["Modelo"]; ?></option>
													<? } ?>
												</select>
										<?  } ?>
							</td>
								<?  } ?>
						</tr>
					</table>
				</td>
  			</tr>
			<tr>	
				<td>&nbsp;</td>
			</tr>
  			<tr>
				<td>
					<table>
						<tr>
							<td align="left">
								10.- Indique los 5 principales puntos que le decidieron por el autom&oacute;vil adquirido.
							</td>
							<td align="center">
									Puntos:
									<? 
										if(count($catPuntos)!=0){?>
											<select name="comPuntos">
												<option value="0" selected>Seleccione...</option>
												<? for($i=0;$i<count($catPuntos);$i++){?>
														<option value="<?=$i+1 ?>"><? echo $catPuntos[$i]["Descripcion"]; ?></option>
												<? } ?>
											</select>
									<?  } ?>
							</td>
						</tr>
					</table>
				</td>
  			</tr>
  			<tr>
  			</tr>
			<tr>	
				<td>&nbsp;</td>
			</tr>
  			<tr>
				<td>
					<table>
						<tr>
							<td align="left">
								11.- ¿ Influy&oacute; el vendedor en su decisi&oacute;n ? 
							</td>
							<td align="left">
								<table>
									<tr>
										<td align="center">
											<input type="radio" name="radInfluyo" value="1">
											Si
										</td>
										<td align="center">
											<input type="radio" name="radInfluyo" value="0">
											No
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>	
				<td>&nbsp;</td>
			</tr>
  			<tr>
				<td>
					<table>
						<tr>
							<td align="left">
								12.- ¿ C&oacute;mo supo de acerca de la marca/modelo adquirida ?
							</td>
							<td align="center">
									<? 
										if(count($catComoSupo)!=0){?>
											<select name="comComoSupo">
												<option value="0" selected>Seleccione...</option>
												<? for($i=0;$i<count($catComoSupo);$i++){?>
														<option value="<?=$i+1 ?>"><? echo $catComoSupo[$i]["Descripcion"]; ?></option>
												<? } ?>
											</select>
									<?  } ?>
							</td>
			  			</tr>
					</table>
				</td>
			</tr>
			<tr>	
				<td>&nbsp;</td>
			</tr>
  			<tr>
				<td>
					<table>
						<tr>
							<td align="left">
								13.- ¿ Uso primario para el que fue adquirido el autom&oacute;vil?
							</td>
							<td align="center">
									<? 
										if(count($catUsoPrimario)!=0){?>
											<select name="comUsoPrimario">
												<option value="0" selected>Seleccione...</option>
												<? for($i=0;$i<count($catUsoPrimario);$i++){?>
														<option value="<?=$i+1 ?>"><? echo $catUsoPrimario[$i]["Descripcion"]; ?></option>
												<? } ?>
											</select>
									<?  } ?>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>	
				<td>&nbsp;</td>
			</tr>
  			<tr>
				<td>
					<table>
						<tr>
							<td align="left">
								14.- Rango de edad al momento de la compra.
							</td>
							<td align="center">
									<select name="comEdad">
										<option value="0" selected>Seleccione...</option>
										<option value="1">Menor a 26 a&ntilde;os</option>
										<option value="2">De 26 a 50 a&ntilde;os</option>
										<option value="3">Mayor a 50 a&ntilde;os</option>
									</select>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>	
				<td>&nbsp;</td>
			</tr>
  			<tr>
				<td>
					<table>
						<tr>
							<td align="left">
								15.- Estado civil al momento de la compra.
							</td>
							<td align="center">
									<? 
										if(count($catEstadoCivil)!=0){?>
											<select name="comEstadoCivil">
												<option value="0" selected>Seleccione...</option>
												<? for($i=0;$i<count($catEstadoCivil);$i++){?>
														<option value="<?=$i+1 ?>"><? echo $catEstadoCivil[$i]["Descripcion"]; ?></option>
												<? } ?>
											</select>
									<?  } ?>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>	
				<td>&nbsp;</td>
			</tr>
  			<tr>
				<td>
					<table>
						<tr>
							<td align="left">
								16.- Indique su Sexo.
							</td>
							<td align="left">
								<table>
									<tr>
										<td align="center">
											<input type="radio" name="radSexo" value="1">
											Hombre
										</td>
										<td align="center">
											<input type="radio" name="radSexo" value="0">
											Mujer
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>	
				<td>&nbsp;</td>
			</tr>
  			<tr>
				<td>
					<table>
						<tr>
							<td align="left">
								17.- Lugar de la Entrevista.
							</td>
							<td align="center">
									<? 
										if(count($catLugares)!=0){?>
											<select name="comLugares">
												<option value="0" selected>Seleccione...</option>
												<? for($i=0;$i<count($catLugares);$i++){?>
														<option value="<?=$i+1 ?>"><? echo $catLugares[$i]["Descripcion"]; ?></option>
												<? } ?>
											</select>
									<?  } ?>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>	
				<td>&nbsp;</td>
			</tr>
  			<tr>
				<td>
					<table>
						<tr>
							<td align="left">
								18.- Entrevistador.
							</td>
							<td align="center">
									<? 
										if(count($catEntrevistadores)!=0){?>
											<select name="comEntrevistadores">
												<option value="0" selected>Seleccione...</option>
												<? for($i=0;$i<count($catEntrevistadores);$i++){?>
														<option value="<?=$i+1 ?>"><? echo $catEntrevistadores[$i]["Descripcion"]; ?></option>
												<? } ?>
											</select>
									<?  } ?>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>	
				<td>&nbsp;</td>
			</tr>
  			<tr>
    			<td align="left" colspan="3">
					<center> 
						<input type="button" name="btnAceptar" value="    Grabar    " onClick="validar()">
					</center>
				</td>
  			</tr>
		</table>
	</center>
	</form>
</body>
</html>
