<? 
	class conEstacion{
		//atributos
		var $servidor,$loginServidor,$passServidor,$baseDatos;
	
		//Constructor por Omisión
		function conEstacion(){
			$this->servidor = "localHost";
			$this->loginServidor = "user";
			$this->passServidor = "";
			$this->baseDatos = "temp";
		} //fin de constructor por omisión
	
		function ejecutarQuerySQL($sentencia){
			$conexion = mysql_connect($this->servidor,$this->loginServidor,$this->passServidor) 
			or die("Error en la conexión");
			$baseDatos = mysql_select_db($this->baseDatos,$conexion) or die("No se encuentra la base de Datos");
			$resultado = mysql_query($sentencia) or die("Error en la sentencia: ".$sentencia);
			$arregloRespuesta = null;
			//$conexion=getConexion($this->servidor,$this->loginServidor,$this->passServidor,$this->baseDatos)
		
			while ($arreglo = mysql_fetch_array($resultado)){
				$arregloRespuesta[] = $arreglo;
			} //fin de while
			return $arregloRespuesta;//$arreglo [0],["Matricula"] , $arreglo [0][0]
			mysql_close($conexion);
		} //fin de function
		
		function ejecutarComandoSQL($sentencia){
			//connexion devueleve un resource ()
			//mysql_connect realiza la conexion con el servidor y por medio de login y password
			// die mata la conexion y puede ser con los contructores die(), die("") o die(conexion)
 			$conexion = mysql_connect($this->servidor,$this->loginServidor,$this->passServidor) 
			or die("Error en la conexión");
	
			//mysql_select_db realiza la conexion con la  bd
			$baseDatos = mysql_select_db($this->baseDatos,$conexion) or die("No se encuentra la base de Datos");
			
			//el resultado que devuelve el select
	 	      	$resultado = mysql_query($sentencia) or die($sentencia); 
			
			//cierro la conexion
		   	mysql_close ($conexion);   
			return $resultado;
		}//fin de function
	
		function getNotasPorSeccionesPorPagina($parFechaReporte){
			$conexion = mysql_connect($this->servidor,$this->loginServidor,$this->passServidor) 
			or die("Error en la conexion");
			$baseDatos = mysql_select_db($this->baseDatos,$conexion) or die("Error en la conexion");
			$stmt = mysql_init("notasGN",$conexion);
		
			mysql_bind($stmt,"@FechaHoy",&$parFechaReporte,SQLVARCHAR);
			$arregloRespuesta = null;
			$resultado = mysql_execute($stmt);
		
			if ($resultado!=1){
				while ($arreglo = mysql_fetch_array($resultado)){
					$arregloRespuesta[] = $arreglo;
				} //fin de while
			} //fin de if
		
			return $arregloRespuesta;
			mysql_close($conexion);
		} //fin de function

		function getConexion($servidor,$login,$password,$BD){
			$conexion = mysql_connect($servidor,$login,$password) 
			or die("Error en la conexión");
			$baseDatos = mysql_select_db($BD,$conexion) or die("No se encuentra la base de Datos");
			return $conexion;
		} //fin de funtcion

		function setDesconectar($parConexion){
			mysql_close($parConexion);
		} //fin de function

	}//fin de class	
?>	