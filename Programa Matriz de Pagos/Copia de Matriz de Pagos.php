<?php
//        error_reporting(E_ALL);
        error_reporting(0);
        include("Class/conEstacion.php");
        $conex = new conEstacion();
?>
<body bgcolor="#D0D0D0" background="">
    <form name="form" method="get" action="">
<!--    <input type="hidden" name="muestraClientes" value="no">-->
    <table width="100%" border="1" cellpadding="0" cellspacing="0"  bgcolor="" background="">
        <tr>    
            <td align="center" bgcolor="#D0D0D0" valign="middle">
                <font face="Courier New, Courier, mono" color="#000020"><h4>MATRIZ DE PAGOS</h4></font>
            </td>
            <?
            $SQL="Select idFamilia,Familia,idCaracteristica,Caracteristica from scOriginalMatriz ";
            $SQL.="group by idFamilia,Familia,idCaracteristica,Caracteristica ";
            $SQL.="Order by Caracteristica,idCaracteristica asc";
            $query = $conex->ejecutarQuerySQL($SQL); 
            for($i=0;$i<count($query);$i++){
                if($i%2==0){
                    $color="#3399FF";
                    $color2="#FFFFFF";
                }
                else
                {
                    $color="#FFFFFF";
                    $color2="#0000FF";
                }
            ?>
                <td align="center" colspan="3" bgcolor="<?=$color;?>">
                    <font face="Courier New, Courier, mono" color="<?=$color2;?>"><h4><?=$query[$i]["Caracteristica"];?></h4></font>
                </td>      
            <? } ?>   
            <td align="center" colspan="3">
                <font face="Courier New, Courier, mono" color="#3399FF"><h4>Ranking</h4></font>
<!--                        <a href="javascript:mostrarClientes()"><font face="Courier New, Courier, mono" color="#3399FF"><?=$query[$i]["Caracteristica"];?></font></a> -->
            </td>      
        </tr>    
        <?
        $SQL="Select Marca, Modelo from scOriginalMatriz ";
        $SQL.="group by Marca, Modelo ";
        $SQL.="Order by Marca, Modelo asc";
        $query2 = $conex->ejecutarQuerySQL($SQL); 
        ?>
        <tr>    
            <td>    
                &nbsp;
            </td>
        </tr>    
        <?
        for($i=0;$i<count($query2);$i++){?>
        <tr>    
            <td bgcolor="#FFFFFF">
                <font face="Courier New, Courier, mono" color="#0000FF"><h4><?=$query2[$i]["Modelo"];?></h4></font>
            </td>
            <?                       
            $SQL="select Marca,Modelo,idFamilia,Familia,Caracteristica,idCaracteristica,Proporcion,Peso,Factor ";
            $SQL.="from scOriginalMatriz c ";
            $SQL.="where Modelo='".$query2[$i]["Modelo"]."' ";
            $SQL.="group by Marca,Modelo,idFamilia,Familia,Caracteristica,idCaracteristica,Proporcion,Peso,Factor ";
            $SQL.="order by Marca,Modelo,Caracteristica,idCaracteristica asc";
            $query3 = $conex->ejecutarQuerySQL($SQL); 

            $SQL="select Marca,Modelo,sum(factor) as 'Ranking'";
            $SQL.="from scOriginalMatriz c ";
            $SQL.="where Modelo='".$query2[$i]["Modelo"]."' ";
            $SQL.="group by Marca,Modelo ";
            $SQL.="order by Marca,Modelo asc ";
            $query4 = $conex->ejecutarQuerySQL($SQL); 
            
            for($k=0;$k<count($query3);$k++){
            ?>
                <td align="center" bgcolor="#C0C0FF">
                    <font face="Courier New, Courier, mono" color="#800000"><h4><?=$query3[$k]["Proporcion"];?></h4></font>
                </td>
                <td align="center" bgcolor="#00FF00">
                    <font face="Courier New, Courier, mono" color="#800000"><h4><?=$query3[$k]["Peso"];?></h4></font>
                </td>
                <td align="center" bgcolor="#FFFFC0">
                    <font face="Courier New, Courier, mono" color="#800000"><h4><?=$query3[$k]["Factor"];?></h4></font>
                </td>
            <? } ?>
            <td align="center" bgcolor="#80FFFF">
                <font face="Courier New, Courier, mono" color="#800000"><h4><?=$query4[0]["Ranking"];?><h4></font>
            </td>
        </tr>
        <? } ?>
    </table>
    <?
    ?>
    <p>&nbsp;</p>
    </form>    
</body>
</html>
