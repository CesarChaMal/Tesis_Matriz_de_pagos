<?php
//        error_reporting(E_ALL);
        error_reporting(0);
        include("Class/conEstacion.php");
        $conex = new conEstacion();

        $SQL="Select idFamilia,Familia,Marca,Modelo,idCaracteristica,Caracteristica,Proporcion,Peso,Factor";
        $SQL.=" from scOriginalMatriz";
        $SQL.=" order by Marca,Modelo,Caracteristica,idCaracteristica asc";
        $query = $conex->ejecutarQuerySQL($SQL); 
        for($i=0;$i<count($query);$i++){
            echo $query[$i]["Modelo"]."<br>";
            echo $query[$i]["Caracteristica"]."<br>";
        }
?>
                                      
