<?
//	error_reporting(E_ALL);
    error_reporting(0);
	include("Class/conEstacion.php");
	$conex = new conEstacion();

	$SQLCaracteristicas="SELECT a.IdCaracteristica, a.Descripcion as Caracteristica, a.Tipo, b.IdFamilia, b.Descripcion as Familia FROM catCaracteristicas a,";
	$SQLCaracteristicas.=" catFamilias b WHERE a.IdFamilia=b.IdFamilia and a.Activo=1 and b.Activo=1 order by Caracteristica";
	$catCaracteristicas = $conex->ejecutarQuerySQL($SQLCaracteristicas);

	//LLENAR EL COMBO DE MARCA Y MODELO
	$SQL="SELECT * from catMarcas where Activo=1 order by Marca";
	$catMarcas = $conex->ejecutarQuerySQL($SQL);
	
	//LENAMOS EL COMBO DE MARCAS CON RELACION A MODELO
	if(isset($Marca)){
		$SQLM="SELECT * from catAutomovil where Activo=1 and  IdMarca='$Marca' order by Modelo";
		$catModelo = $conex->ejecutarQuerySQL($SQLM);
	}//fin de if
	
	if(isset($Anio)){
		if(!(isset($Grabar))){
			$Grabar="";
		}else{
			$SQLFicha="SELECT * from FichaTecnica where Activo=1 and IdAutomovil='$Modelo' and Anio='$Anio' Order by Anio";
			$datosFicha = $conex->ejecutarQuerySQL($SQLFicha);
			if ($Grabar=="si"){
				$SQLGrid="SELECT c.IdFicha, e.Modelo, f.Marca, c.Anio, a.IdCaracteristica, a.Descripcion as Caracteristica, a.Tipo, b.IdFamilia, b.Descripcion as Familia ,d.Valor";
				$SQLGrid.=" FROM catCaracteristicas a, catFamilias b ,FichaTecnica c, detFichaTecnica d, catAutomovil e, catMarcas f";
				$SQLGrid.=" WHERE a.IdFamilia=b.IdFamilia and a.IdCaracteristica=d.IdCaracteristica and c.IdFicha=d.IdFicha and c.IdAutomovil=e.IdAutomovil and e.IdMarca=f.IdMarca";
				$SQLGrid.=" and a.Activo=1 and b.Activo=1 and c.Activo=1 and e.Activo=1 and f.Activo=1 and c.IdFicha='".$datosFicha[0]["IdFicha"]."' and d.IdCaracteristica='$Caracteristicas' order by c.IdFicha";
				$Grid = $conex->ejecutarQuerySQL($SQLGrid);
				if(count($Grid)!=0){
					$SQL="UPDATE detFichaTecnica";
					$SQL.=" SET Valor='$Valor'";
					$SQL.=" WHERE idFicha='".$datosFicha[0]["IdFicha"]."' and idCaracteristica='$Caracteristicas'";					
					$FichaTecnica=$conex->ejecutarQuerySQL($SQL);
				}else{
					$SQLGrid2="SELECT c.IdFicha, e.Modelo, f.Marca, c.Anio, a.IdCaracteristica, a.Descripcion as Caracteristica, a.Tipo, b.IdFamilia, b.Descripcion as Familia ,d.Valor";
					$SQLGrid2.=" FROM catCaracteristicas a, catFamilias b ,FichaTecnica c, detFichaTecnica d, catAutomovil e, catMarcas f";
					$SQLGrid2.=" WHERE a.IdFamilia=b.IdFamilia and a.IdCaracteristica=d.IdCaracteristica and c.IdFicha=d.IdFicha and c.IdAutomovil=e.IdAutomovil and e.IdMarca=f.IdMarca";
					$SQLGrid2.=" and a.Activo=1 and b.Activo=1 and c.Activo=1 and e.Activo=1 and f.Activo=1 and c.IdFicha='".$datosFicha[0]["IdFicha"]."' order by c.IdFicha";
					$Grid2 = $conex->ejecutarQuerySQL($SQLGrid2);
	
					$SQL="SELECT * FROM Colores WHERE IdFicha='".$datosFicha[0]["IdFicha"]."'";
					$checaColor3=$conex->ejecutarQuerySQL($SQL);

					if( (count($Grid2)==0) && (count($checaColor3)==0) ){
						$SQL="INSERT into FichaTecnica(IdAutomovil,Anio) values ($Modelo,$Anio)";
						$FichaTecnica=$conex->ejecutarQuerySQL($SQL);
	
						$SQL="SELECT @@identity as IdFicha";
						$Ficha=$conex->ejecutarQuerySQL($SQL);

						$SQL="INSERT into detFichaTecnica(IdFicha,IdCaracteristica,Valor) values ('".$Ficha[0]["IdFicha"]."',$Caracteristicas,$Valor)";
						$detFichaTecnica=$conex->ejecutarQuerySQL($SQL);
					}else{
						$SQL="INSERT into detFichaTecnica(IdFicha,IdCaracteristica,Valor) values ('".$datosFicha[0]["IdFicha"]."',$Caracteristicas,$Valor)";
						$detFichaTecnica=$conex->ejecutarQuerySQL($SQL);
					}
				}
			}else{
				$Grabar="no";
			}

			if(!(isset($GrabarColor))){
				$GrabarColor="";
			}else{
				if ($GrabarColor=="si"){
					$SQL="SELECT * FROM Colores WHERE Color='$Color' and IdFicha='".$datosFicha[0]["IdFicha"]."'";
					$checaColor=$conex->ejecutarQuerySQL($SQL);
					if(count($checaColor)==0){
						$SQLGrid4="SELECT c.IdFicha, e.Modelo, f.Marca, c.Anio, a.IdCaracteristica, a.Descripcion as Caracteristica, a.Tipo, b.IdFamilia, b.Descripcion as Familia ,d.Valor";
						$SQLGrid4.=" FROM catCaracteristicas a, catFamilias b ,FichaTecnica c, detFichaTecnica d, catAutomovil e, catMarcas f";
						$SQLGrid4.=" WHERE a.IdFamilia=b.IdFamilia and a.IdCaracteristica=d.IdCaracteristica and c.IdFicha=d.IdFicha and c.IdAutomovil=e.IdAutomovil and e.IdMarca=f.IdMarca";
						$SQLGrid4.=" and a.Activo=1 and b.Activo=1 and c.Activo=1 and e.Activo=1 and f.Activo=1 and c.IdFicha='".$datosFicha[0]["IdFicha"]."' order by c.IdFicha";
						$Grid4 = $conex->ejecutarQuerySQL($SQLGrid4);

						if(count($Grid4)!=0){
							$SQL="INSERT into Colores(IdFicha,Color) values ('".$datosFicha[0]["IdFicha"]."','$Color')";
							$grabaColor=$conex->ejecutarQuerySQL($SQL);
						}
					}
				}else{
					$GrabarColor="no";	
				}
			}

			if(!(isset($Eliminar))){
				$Eliminar="";
			}else{
				if ($Eliminar=="si"){
					$SQLGrid5="SELECT c.IdFicha, e.Modelo, f.Marca, c.Anio, a.IdCaracteristica, a.Descripcion as Caracteristica, a.Tipo, b.IdFamilia, b.Descripcion as Familia ,d.Valor";
					$SQLGrid5.=" FROM catCaracteristicas a, catFamilias b ,FichaTecnica c, detFichaTecnica d, catAutomovil e, catMarcas f";
					$SQLGrid5.=" WHERE a.IdFamilia=b.IdFamilia and a.IdCaracteristica=d.IdCaracteristica and c.IdFicha=d.IdFicha and c.IdAutomovil=e.IdAutomovil and e.IdMarca=f.IdMarca";
					$SQLGrid5.=" and a.Activo=1 and b.Activo=1 and c.Activo=1 and e.Activo=1 and f.Activo=1 and c.IdFicha='".$datosFicha[0]["IdFicha"]."' order by c.IdFicha";
					$Grid5 = $conex->ejecutarQuerySQL($SQLGrid5);
					if(count($Grid5)!=0){
						//quiere decir que por lo menos le dieron clic a un check box
						if(count($datosGrid)>0){
						  for($i=0;$i<count($datosGrid);$i++){
							$valores=split("_",$datosGrid[$i]);
							//la posicion 0 tiene la parte que corresponde a el id de la ficha
							$ficha=$valores[0];
							//la posicion 1 tiene los id caracteristicas
							$caracteristica=$valores[1];
							//borro el registro
							$SQL="DELETE FROM detFichaTecnica WHERE idFicha=$ficha and idCaracteristica=$caracteristica";	
							$Elimina=$conex->ejecutarQuerySQL($SQL);
						  }//fin de for
						}//fin de if
						
						$SQLGrid6="SELECT c.IdFicha, e.Modelo, f.Marca, c.Anio, a.IdCaracteristica, a.Descripcion as Caracteristica, a.Tipo, b.IdFamilia, b.Descripcion as Familia ,d.Valor";
						$SQLGrid6.=" FROM catCaracteristicas a, catFamilias b ,FichaTecnica c, detFichaTecnica d, catAutomovil e, catMarcas f";
						$SQLGrid6.=" WHERE a.IdFamilia=b.IdFamilia and a.IdCaracteristica=d.IdCaracteristica and c.IdFicha=d.IdFicha and c.IdAutomovil=e.IdAutomovil and e.IdMarca=f.IdMarca";
						$SQLGrid6.=" and a.Activo=1 and b.Activo=1 and c.Activo=1 and e.Activo=1 and f.Activo=1 and c.IdFicha='".$datosFicha[0]["IdFicha"]."' order by c.IdFicha";
						$Grid6 = $conex->ejecutarQuerySQL($SQLGrid6);

						$SQL="SELECT * FROM Colores WHERE IdFicha='".$datosFicha[0]["IdFicha"]."'";
						$checaColor2=$conex->ejecutarQuerySQL($SQL);

						if( (count($Grid6)==0) && ($checaColor2)==0){
							$SQL="DELETE FROM FichaTecnica";
							$SQL.=" WHERE idFicha='".$datosFicha[0]["IdFicha"]."'";					
							$EliminaFichaTecnica=$conex->ejecutarQuerySQL($SQL);
						}
					}
				}
				$Eliminar="no";	
			}
			
			if(!(isset($EliminarColor))){
				$EliminarColor="";
			}else{
				if ($EliminarColor=="si"){
					$SQL="SELECT * FROM Colores WHERE IdFicha='".$datosFicha[0]["IdFicha"]."'";
					$checaColor=$conex->ejecutarQuerySQL($SQL);
					
					if(count($checaColor)!=0){
						if(count($colores)>0){
						  for($i=0;$i<count($colores);$i++){
							$valores=split("_",$colores[$i]);
							$ficha=$valores[0];
							$color=$valores[1];
							$SQL="DELETE FROM Colores WHERE IdFicha=$ficha and Color='$color'";
							$EliminaColor=$conex->ejecutarQuerySQL($SQL);
						  }
						}
					}
				}
				$EliminarColor="no";	
			}
		}
	}
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Fichas Tecnicas</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
.Estilo1 {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-weight: bold;
	font-size: 18px;
}
.Estilo7 {font-size: 36px}
-->
</style>
</head>
<script language="JavaScript">
	function checarNumero(f){
		if (isNaN (f.value)){//IsNaN Is Not a Numeric si no es numero
			f.value="";
		}
	}

	function validarEliminarColor(){
		var f=document.form;
		f.EliminarColor.value="si";
		f.submit();
	}

	function validarEliminar(){
		var f=document.form;
		f.Eliminar.value="si";
		f.submit();
	}
	
/*
	function validarEliminar(){
		var f=document.form,a="",i=0,cuentaChecked=0;
		f.hdElementos.value = "";
		for (i=0;i<f.datosGrid.length;i++)
		{
		  var elemento=f.datosGrid[i];
		  if(elemento.type == 'checkbox' && elemento.checked)
		  {
			f.hdElementos.value = f.hdElementos.value + elemento.value + ",";
		  }//fin de if
		}//fin de for
		f.hdElementos.value = f.hdElementos.value.slice(0,f.hdElementos.value.length - 1);    
		f.submit();
	}
*/
	function validar(){
		var f=document.form,a="";
/*
		if (isNaN (f.Valor.value)){//IsNaN Is Not a Numeric si no es numero
			f.Valor.value="";
			a+="\nNo es numero";
		}
*/		
		if(f.Valor.value=="")
			a+="\nProporciona un valor a la caracteristica";
		if(a==""){
			f.Grabar.value="si";
			f.submit();
		}else
			alert(a);
	}
	
	function validarColores(){
		var f=document.form,a="";
		if(f.Color.value.toUpperCase()=="")
			a+="\nProporciona un color";
		if(a==""){
			f.GrabarColor.value="si";
			f.submit();
		}else
			alert(a);
	}

	function MostarFicha(){
	    var f= document.form;
		f.submit();
	}//fin de function
	
	function MostarModelo(){
	    var f= document.form;
		f.submit();
	}//fin de function
</script>
<body>
	<form name="form" method="get" action="">
	<input type="hidden" name="Grabar" value="">
	<input type="hidden" name="GrabarColor" value="">
	<input type="hidden" name="Eliminar" value="">
	<input type="hidden" name="EliminarColor" value="">
	<input type="hidden" name="hdElementos" value="">
	<center>
		<p>&nbsp;</p>
		<table width="90%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td height="10" align="left">
					<table width="90%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td height="10" align="left">
								<table  width="100%" border="0" cellpadding="0" cellspacing="0">
									<tr>
										<td align="center"> 
											<div align="center">
												<img src="cel.jpg" width="73" height="40"> 
											</div>
										</td>
										<td align="left">
											<h6 class="Estilo1 Estilo7">Fichas Tecnicas</h6>
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
								<table width="100%" border="0" cellpadding="0" cellspacing="0">
									<tr> 
										<td align="left">										  
											<div align="left">Marca: 
												<select name="Marca" onChange="MostarModelo()">
													<option value="0" selected>Seleccione...</option>
													<? for($i=0;$i<count($catMarcas);$i++){?>
														<option value="<?=$catMarcas[$i]["IdMarca"];?>"<?=($Marca==$catMarcas[$i]["IdMarca"])?"selected":"";?>>
														<?=$catMarcas[$i]["Marca"];?>
														</option>
													<? } ?>
												</select>
											</div>
										</td>
										<td align="left">
											<div align="left">Modelo: 
												<select name="Modelo" onChange="MostarFicha()">
													<option value="0" selected>Seleccione...</option>
													<? for($i=0;$i<count($catModelo);$i++){?>
														<option value="<?=$catModelo[$i]["IdAutomovil"];?>" <?=($Modelo==$catModelo[$i]["IdAutomovil"])?"selected":"";?>>
														<?=$catModelo[$i]["Modelo"];?>
														</option>
													<? } ?>
												</select>
											</div>
										</td>
									</tr>
									<tr>	
										<td>&nbsp;</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td align="left">
								<table width="100%" border="0" cellpadding="0" cellspacing="0">
									<tr>
										<td align="left">A&ntilde;o:
											<select name="Anio" onChange="MostarFicha()">
												<option value="0" selected>Seleccione...</option>
												<option value="2006"<?=($Anio==2006)?"selected":"";?>>2006</option>
												<option value="2007"<?=($Anio==2007)?"selected":"";?>>2007</option>
												<option value="2008"<?=($Anio==2008)?"selected":"";?>>2008</option>
											</select>
										</td>
										<?
											$SQLFicha="SELECT * from FichaTecnica where Activo=1 and IdAutomovil='$Modelo' and Anio='$Anio' Order by Anio";
											$datosFicha = $conex->ejecutarQuerySQL($SQLFicha);
/*											
											$SQLFichaT="SELECT * from detFichaTecnica where IdFicha='".$datosFicha[0]["IdFicha"]."'";
											$datosDetFicha = $conex->ejecutarQuerySQL($SQLFichaT);
*/
											if (count($datosFicha)){
										?>
										<td align="justify"> IdFicha: 
                                          <input type="text" name="IdFicha2" size="4" value="<?=$datosFicha[0]["IdFicha"];?>" disabled>
										</td>
										<? } ?>
									</tr>
								</table>
							</td>
						</tr>
						<tr>	
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td>
								<table width="100%" border="0" cellpadding="0" cellspacing="0">
									<tr>
										<td align="left">Caracteristicas:
											<select name="Caracteristicas" onChange="MostarFicha()">
												<option value="0" selected>Seleccione...</option>
												<? for($i=0;$i<count($catCaracteristicas);$i++){?>
													<option value="<?=$catCaracteristicas[$i]["IdCaracteristica"];?>" 
														<?=($Caracteristicas==$catCaracteristicas[$i]["IdCaracteristica"])?"selected":"";?>>
														<?=$catCaracteristicas[$i]["Caracteristica"];?>
													</option>
												<? } ?>
											</select>
										</td>
										<td align="left"> Valor: 
											<input type="text" name="Valor" size="8" value="" onBlur="checarNumero(Valor)">
										</td>
										<td align="left">
											<input type="button" name="btnGrabar" value="    Grabar    " onClick="validar()">
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
								<table width="100%" border="0" cellpadding="0" cellspacing="0">
									<tr>
									<?
										$SQLCaracteristicas="SELECT a.IdCaracteristica, a.Descripcion as Caracteristica, a.Tipo, b.IdFamilia, b.Descripcion as Familia FROM catCaracteristicas a,";
										$SQLCaracteristicas.=" catFamilias b WHERE a.IdFamilia=b.IdFamilia and a.Activo=1 and b.Activo=1  and IdCaracteristica='$Caracteristicas' order by Caracteristica";
										$datosCaracteristicas = $conex->ejecutarQuerySQL($SQLCaracteristicas);
										if ($datosCaracteristicas!=0){
									?>
										<td align="left"> Familia: 
<!--                                          <input type="text" name="Familia" size="22" value="<?//=$datosCaracteristicas[0]["Familia"];?>"<?//=($Familia==$datosCaracteristicas[0]["Familia"])?$Familia:"";?> disabled>-->
		                                    <input type="text" name="Familia" size="32" value="<?=$datosCaracteristicas[0]["Familia"];?>" disabled>
										</td>
										<?
											switch ($datosCaracteristicas[0]["Tipo"]){
												case 0:
													$des_tipo="Booleano";
													break;
												case 1:
													$des_tipo="Incremental";
													break;
												case 2:
													$des_tipo="Decremental";
													break;
											}		
										?>
										<td align="left"> Tipo: 
											<input type="text" name="Tipo" size="11" value="<?=$des_tipo;?>" disabled>
										</td>
										<? }else{ ?>
											<td align="left"> Familia: 
												<input type="text" name="Familia" size="32" value="" disabled>
											</td>
											<td align="left"> Tipo: 
												<input type="text" name="Tipo" size="11" value="" disabled>
											</td>
										<? } ?>
										<td align="left">
											<input type="button" name="btnEliminar" value="    Eliminar    " onClick="validarEliminar()">
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>	
							<td>&nbsp;</td>
						</tr>
					</table>
				</td>
				<td>
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>	
							<td>
								<table width="70%" border="0" cellpadding="0" cellspacing="0">
									<tr>
										<td align="left" rowspan="2"> Color : 
											<input type="text" name="Color" size="" value="">
										</td>
										<td align="left">
											<input type="button" name="btnGrabarColor" value=" Grabar " onClick="validarColores()">
										</td>
										<?
											if ($GrabarColor=="si"){
												if(count($checaColor)!=0){
													echo "Color Ya Existente";
												}else{
													if(count($Grid4)==0){
														echo "No Existe la ficha No puedes guardar colores";
													}
												} 
											}
										?>
									</tr>
									<tr>
										<td align="left">
											<input type="button" name="btnEliminarColor" value=" Eliminar " onClick="validarEliminarColor()">
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
								<table width="70%" border="1" cellpadding="0" cellspacing="0">
									<tr> 
										<td colspan="2"  bgcolor="yellow"><div align="center">Colores Capturados</div></td>
									</tr>
									<tr> 
										<td bgcolor="#669966">
											<div align="center">Color</div></td>
										<td bgcolor="#66CC66">
											<div align="center">&nbsp;</div></td>
									</tr>
									<? 
									$SQLC="SELECT * from colores WHERE IdFicha='".$datosFicha[0]["IdFicha"]."'";
									$colores = $conex->ejecutarQuerySQL($SQLC);
									for($i=0;$i<count($colores);$i++){?>
									<? if($i%2==0){
											$color2="#cccccc";
									   }else{
											$color2="#ffffff";
										}
									?>
									<tr bgcolor="<? echo $color2 ?>"> 
										<td><? echo $colores[$i]["Color"];?></td>
										<td width="5%">
											<input name="colores[]" type="checkbox" value="<?=$colores[$i]["IdFicha"]; ?>_<?=$colores[$i]["Color"]; ?>">
										</td>
								  </tr>
									<? } //fin de for ?>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<? 
			$SQLGrid3="SELECT c.IdFicha, e.Modelo, f.Marca, c.Anio, a.IdCaracteristica, a.Descripcion as Caracteristica, a.Tipo, b.IdFamilia, b.Descripcion as Familia ,d.Valor";
			$SQLGrid3.=" FROM catCaracteristicas a, catFamilias b ,FichaTecnica c, detFichaTecnica d, catAutomovil e, catMarcas f";
			$SQLGrid3.=" WHERE a.IdFamilia=b.IdFamilia and a.IdCaracteristica=d.IdCaracteristica and c.IdFicha=d.IdFicha and c.IdAutomovil=e.IdAutomovil and e.IdMarca=f.IdMarca";
			$SQLGrid3.=" and a.Activo=1 and b.Activo=1 and c.Activo=1 and e.Activo=1 and f.Activo=1 and c.IdFicha='".$datosFicha[0]["IdFicha"]."' order by Caracteristica";
			$Grid3 = $conex->ejecutarQuerySQL($SQLGrid3);
			if(count($Grid3)!=0){?>
			<tr>	
				<td colspan="2">
					<table width="90%" border="1" cellpadding="0" cellspacing="0">
						<tr> 
							<td colspan="6" bgcolor="yellow"><div align="center">Datos Capturados</div></td>
						</tr>
						<tr> 
							<td width="9%" bgcolor="#669966">
								<div align="center">IdFicha</div></td>
							<td width="33%" bgcolor="#66CC12">
								<div align="center">Caracteristica</div></td>
							<td width="21%" bgcolor="#669966">
								<div align="center">Familia</div></td>
							<td width="15%" bgcolor="#66CC12">
								<div align="center">Tipo</div></td>
							<td width="14%" bgcolor="#669966">
								<div align="center">Valor</div></td>
							<td bgcolor="#66CC12">
								<div align="center">Eliminar</div></td>
						</tr>
						<? 
						for($i=0;$i<count($Grid3);$i++){?>
						<? if($i%2==0){
								$color2="#cccccc";
						   }else{
								$color2="#ffffff";
							}
						?>
						<tr bgcolor="<? echo $color2 ?>"> 
							<td align="center"><? echo $Grid3[$i]["IdFicha"];?></td>
							<td><? echo $Grid3[$i]["Caracteristica"];?></td>
							<td><? echo $Grid3[$i]["Familia"];?></td>
							<?
								switch ($Grid3[$i]["Tipo"]){
									case 0:
										$des_tipo="Booleano";
										break;
									case 1:
										$des_tipo="Incremental";
										break;
									case 2:
										$des_tipo="Decremental";
										break;
								}		
							?>
							<td align="center"><? echo $des_tipo;?></td>
							<td align="center"><? echo $Grid3[$i]["Valor"];?></td>
							<td width="8%" align="center"> 
									<input name="datosGrid[]" type="checkbox" value="<?=$Grid3[$i]["IdFicha"]; ?>_<?=$Grid3[$i]["IdCaracteristica"]; ?>">
							</td>
						</tr>
						<? } //fin de for ?>
					</table>
				</td>
			</tr>
			<? }else{ ?>
			<tr>	
				<td colspan="2">
					<table width="90%" border="1" cellpadding="0" cellspacing="0">
						<tr> 
							<td colspan="6" bgcolor="yellow"><div align="center">Datos Capturados</div></td>
						</tr>
						<tr> 
							<td width="9%" bgcolor="#669966">
								<div align="center">IdFicha</div></td>
							<td width="33%" bgcolor="#66CC12">
								<div align="center">Caracteristica</div></td>
							<td width="21%" bgcolor="#669966">
								<div align="center">Familia</div></td>
							<td width="15%" bgcolor="#66CC12">
								<div align="center">Tipo</div></td>
							<td width="14%" bgcolor="#669966">
								<div align="center">Valor</div></td>
							<td width="8%" bgcolor="#66CC12">
								<div align="center">Eliminar</div></td>
						</tr>
					</table>
				</td>
			</tr>
			<? } ?>
		</table>
	</center>
	</form>
</body>
</html>
