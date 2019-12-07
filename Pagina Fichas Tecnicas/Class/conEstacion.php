<? 
	class conEstacion{
	//atributos
	var $servidor, $loginServidor, $passServidor;
	var $baseDatos;

	//Constructor por Omisión
	function conEstacion(){
		$this->servidor = "127.0.0.1";
		$this->loginServidor = "sa";
		$this->passServidor = "";
		$this->baseDatos = "Tesis";
	} //fin de constructor por omisión
	
	function ejecutarQuerySQL($sentencia){
		$conexion = mssql_connect($this->servidor,$this->loginServidor,$this->passServidor) or die("Error en la conexión");
		$baseDatos = mssql_select_db($this->baseDatos,$conexion) or die("No se encuentra la base de Datos");
		$resultado = mssql_query($sentencia) or die("Error en la sentencia: ".$sentencia);
		$arregloRespuesta = null;

		while ($arreglo = mssql_fetch_array($resultado)){
			$arregloRespuesta[] = $arreglo;
		} //fin de while
		return $arregloRespuesta;//$arreglo [0],["Matricula"] , $arreglo [0][0]
		mssql_close($conexion);
	} //fin de function
		
	function ejecutarComandoSQL($sentencia){
//connexion devueleve un resource ()
//mssql_connect realiza la conexion con el servidor y por medio de login y password
// die mata la conexion y puede ser con los contructores die(), die("") o die(conexion)
	   $conexion	= mssql_connect($this->servidor,$this->loginServidor,$this->passServidor) or die("Error en la conexión");
//mssql_select_db realiza la conexion con la  bd
	   $baseDatos	= mssql_select_db($this->baseDatos,$conexion) or die("No se encuentra la base de Datos");
//el resultado que devuelve el select
       $resultado	= mssql_query($sentencia) or die($sentencia); 
//cierro la conexion
	   	mssql_close ($conexion);   
		return $resultado;
	}//fin de function
	
	function getNotasPorSeccionesPorPagina($parFechaReporte){
		$conexion = mssql_connect($this->servidor,$this->loginServidor,$this->passServidor) or die("Error en la conexion");
		$baseDatos = mssql_select_db($this->baseDatos,$conexion) or die("Error en la conexion");
		$stmt = mssql_init("notasGN",$conexion);
		
		mssql_bind($stmt,"@FechaHoy",&$parFechaReporte,SQLVARCHAR);
		$arregloRespuesta = null;
		$resultado = mssql_execute($stmt);
		if ($resultado!=1){
			while ($arreglo = mssql_fetch_array($resultado)){
				$arregloRespuesta[] = $arreglo;
			} //fin de while
		} //fin de if
		return $arregloRespuesta;
		mssql_close($conexion);
	} //fin de function


	function getConexion(){
		$conexion	= mssql_connect($this->servidor,$this->loginServidor,$this->passServidor) or die("Error en la conexión");
		$baseDatos	= mssql_select_db($this->baseDatos,$conexion) or die("No se encuentra la base de Datos");
		return $conexion;
	} //fin de funtcion

	function setDesconectar($parConexion){
		mssql_close($parConexion);
	} //fin de function
}//fin de class	
?>	