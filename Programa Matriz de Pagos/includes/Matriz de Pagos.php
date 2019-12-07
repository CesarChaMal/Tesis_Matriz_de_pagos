<?php
//error_reporting(E_ALL);
error_reporting(0);
include("conEstacion.php");
class Matriz extends conEstacion
{
    var $dec;
    var $conex=NULL;

    function setdec($dec)
    {            
        $this->dec=$dec;
    }

    function Matriz($dec)
    {     
        $this->conex = new conEstacion("127.0.0.1","sa","","Tesis");
        //$conex = parent::conEstacion("127.0.0.1","sa","","Tesis");
        $this->setdec($dec);
        ?>
        <table width="100%" border="1" cellpadding="0" cellspacing="0"  bgcolor="" background="">
            <tr>    
                <td align="center" bgcolor="#D0D0D0" valign="middle" rowspan="2">
                    <font face="Courier New, Courier, mono" color="#000020"><h4>MATRIZ DE PAGOS</h4></font>
                </td>
                <?
                $SQL="Select idFamilia,Familia,idCaracteristica,Caracteristica from scOriginalMatriz ";
                $SQL.="group by idFamilia,Familia,idCaracteristica,Caracteristica ";
                $SQL.="Order by Caracteristica,idCaracteristica asc";
                $query = $this->conex->ejecutarQuerySQL($SQL); 
                for($i=0;$i<count($query);$i++){
                    if($i%2==0){
                        $color="#3399FF";
                        $color2="#FFFFFF";
                    }
                    else
                    {
                        $color="#D0D0D0";
                        $color2="#0000FF";
                    }
                ?>
                    <td align="center" colspan="3" bgcolor="<?=$color;?>">
                        <font face="Courier New, Courier, mono" color="<?=$color2;?>"><h4><?=$query[$i]["Caracteristica"];?></h4></font>
                    </td>      
                <? } ?>   
                <td align="center" colspan="3" rowspan="2" bgcolor="#FF7C3E">
                    <font face="Courier New, Courier, mono" color="#000020"><h4>Ranking</h4></font>
    <!--                        <a href="javascript:mostrarClientes()"><font face="Courier New, Courier, mono" color="#3399FF"><?=$query[$i]["Caracteristica"];?></font></a> -->
                </td>      
            </tr>    
            <?
            ?>
            <tr>    
                <?
                $SQL="select Marca,Modelo,idFamilia,Familia,Caracteristica,idCaracteristica,Proporcion,Peso,Factor ";
                $SQL.="from scOriginalMatriz c ";
                $SQL.="where Modelo='Astra Paq. C Comfort Manual 1.8L' ";
                $SQL.="group by Marca,Modelo,idFamilia,Familia,Caracteristica,idCaracteristica,Proporcion,Peso,Factor ";
                $SQL.="order by Marca,Modelo,Caracteristica,idCaracteristica asc";
                $query5 = $this->conex->ejecutarQuerySQL($SQL); 
                for($k=0;$k<count($query5);$k++){
                    if($k%2==0)
                    {
                        $color1="#B7C6FB";
                        $color2="#A0A7FA";
                        $color3="#819BF8";
                        $color4="#000000";
                    }
                    else
                    {
                        $color1="#F4F4F4";
                        $color2="#E5E5E5";
                        $color3="#E0E0E0";
                        $color4="#0000FF";
                    }
    /*
                        $color1="#969696";
                        $color2="#D0D0D0";
                        $color3="#FFFF00";
    */
                ?>
                    <td align="center" bgcolor="<?=$color1;?>">
                        <font face="Courier New, Courier, mono" color="<?=$color4;?>"><h4>Proporcion</h4></font>
                    </td>
                    <td align="center" bgcolor="<?=$color2;?>">
                        <font face="Courier New, Courier, mono" color="<?=$color4;?>"><h4>Factor</h4></font>
                    </td>
                    <td align="center" bgcolor="<?=$color3;?>">
                        <font face="Courier New, Courier, mono" color="<?=$color4;?>"><h4>Peso</h4></font>
                    </td>
                <? } ?>
            </tr>    
            <?
            $SQL="Select Marca, Modelo from scOriginalMatriz ";
            $SQL.="group by Marca, Modelo ";
            $SQL.="Order by Marca, Modelo asc";
            $query2 = $this->conex->ejecutarQuerySQL($SQL); 
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
                $query3 = $this->conex->ejecutarQuerySQL($SQL); 

                $SQL="select Marca,Modelo,sum(Peso) as 'Ranking'";
                $SQL.="from scOriginalMatriz c ";
                $SQL.="where Modelo='".$query2[$i]["Modelo"]."' ";
                $SQL.="group by Marca,Modelo ";
                $SQL.="order by Marca,Modelo asc ";
                $query4 = $this->conex->ejecutarQuerySQL($SQL); 
                
                for($k=0;$k<count($query3);$k++){
                    if($k%2==0)
                    {
                        $color1="#B7C6FB";
                        $color2="#A0A7FA";
                        $color3="#819BF8";
                        $color4="#000000";
                    }
                    else
                    {
                        $color1="#F4F4F4";
                        $color2="#E5E5E5";
                        $color3="#E0E0E0";
                        $color4="#0000FF";
                    }
                ?>
                    <td align="center" bgcolor="<?=$color1;?>">
                        <font face="Courier New, Courier, mono" color="<?=$color4;?>"><h4><?=number_format($query3[$k]["Proporcion"],$dec);?></h4></font>
                    </td>
                    <td align="center" bgcolor="<?=$color2;?>">
                        <font face="Courier New, Courier, mono" color="<?=$color4;?>"><h4><?=number_format($query3[$k]["Factor"],$dec);?></h4></font>
                    </td>
                    <td align="center" bgcolor="<?=$color3;?>">
                        <font face="Courier New, Courier, mono" color="<?=$color4;?>"><h4><?=number_format($query3[$k]["Peso"],$dec);?></h4></font>
                    </td>
                <? } ?>
                <td align="center" bgcolor="#FF9B6A">
                    <font face="Courier New, Courier, mono" color="<?=$color4;?>"><h4><?=number_format($query4[0]["Ranking"],$dec);?><h4></font>
                </td>
            </tr>
            <? } ?>
        </table>
        <p>&nbsp;</p>
        <?
    }
    
    function createScene($dec,$scene)
    {     
        $this->conex = new conEstacion("127.0.0.1","sa","","Tesis");
        //$conex = parent::conEstacion("127.0.0.1","sa","","Tesis");
        $this->setdec($dec);
        $SQL="Exec ifExists '".$scene."'";
        $ifExists = $this->conex->ejecutarQuerySQL($SQL); 
        if($ifExists[0]["checa1"]==1 && $ifExists[0]["checa2"]==1){
            return 0;
        }else{
/* 
            $SQL="Exec detFichaTecnicaPersonalizado '".$scene."'";
            $createFichaTecnica = $this->conex->ejecutarQuerySQL($SQL); 

            $SQL="Exec CargaMatrizPersonalizado '".$scene."'";
            $createMatriz = $this->conex->ejecutarQuerySQL($SQL); 

*/            
            $SQL="Exec createMatrizTables '".$scene."'";
            $createMatriz = $this->conex->ejecutarQuerySQL($SQL); 
            ?>
            <table width="100%" border="1" cellpadding="0" cellspacing="0"  bgcolor="" background="">
                <tr>    
                    <td align="center" bgcolor="#D0D0D0" valign="middle" rowspan="2">
                        <font face="Courier New, Courier, mono" color="#000020"><h4>MATRIZ DE PAGOS</h4></font>
                    </td>
                    <?
                    $SQL="Select idFamilia,Familia,idCaracteristica,Caracteristica from sc".$scene."Matriz ";
                    $SQL.="group by idFamilia,Familia,idCaracteristica,Caracteristica ";
                    $SQL.="Order by Caracteristica,idCaracteristica asc";
                    $query = $this->conex->ejecutarQuerySQL($SQL); 
                    for($i=0;$i<count($query);$i++){
                        if($i%2==0){
                            $color="#3399FF";
                            $color2="#FFFFFF";
                        }
                        else
                        {
                            $color="#D0D0D0";
                            $color2="#0000FF";
                        }
                    ?>
                        <td align="center" colspan="3" bgcolor="<?=$color;?>">
                            <font face="Courier New, Courier, mono" color="<?=$color2;?>"><h4><?=$query[$i]["Caracteristica"];?></h4></font>
                        </td>      
                    <? } ?>   
                    <td align="center" colspan="3" rowspan="2" bgcolor="#FF7C3E">
                        <font face="Courier New, Courier, mono" color="#000020"><h4>Ranking</h4></font>
        <!--                        <a href="javascript:mostrarClientes()"><font face="Courier New, Courier, mono" color="#3399FF"><?=$query[$i]["Caracteristica"];?></font></a> -->
                    </td>      
                </tr>    
                <?
                ?>
                <tr>    
                    <?
                    $SQL="select Marca,Modelo,idFamilia,Familia,Caracteristica,idCaracteristica,Proporcion,Peso,Factor ";
                    $SQL.="from sc".$scene."Matriz c ";
                    $SQL.="where Modelo='Astra Paq. C Comfort Manual 1.8L' ";
                    $SQL.="group by Marca,Modelo,idFamilia,Familia,Caracteristica,idCaracteristica,Proporcion,Peso,Factor ";
                    $SQL.="order by Marca,Modelo,Caracteristica,idCaracteristica asc";
                    $query5 = $this->conex->ejecutarQuerySQL($SQL); 
                    for($k=0;$k<count($query5);$k++){
                        if($k%2==0)
                        {
                            $color1="#B7C6FB";
                            $color2="#A0A7FA";
                            $color3="#819BF8";
                            $color4="#000000";
                        }
                        else
                        {
                            $color1="#F4F4F4";
                            $color2="#E5E5E5";
                            $color3="#E0E0E0";
                            $color4="#0000FF";
                        }
        /*
                            $color1="#969696";
                            $color2="#D0D0D0";
                            $color3="#FFFF00";
        */
                    ?>
                        <td align="center" bgcolor="<?=$color1;?>">
                            <font face="Courier New, Courier, mono" color="<?=$color4;?>"><h4>Proporcion</h4></font>
                        </td>
                        <td align="center" bgcolor="<?=$color2;?>">
                            <font face="Courier New, Courier, mono" color="<?=$color4;?>"><h4>Factor</h4></font>
                        </td>
                        <td align="center" bgcolor="<?=$color3;?>">
                            <font face="Courier New, Courier, mono" color="<?=$color4;?>"><h4>Peso</h4></font>
                        </td>
                    <? } ?>
                </tr>  
                <?
                $SQL="Select Marca, Modelo from sc".$scene."Matriz ";
                $SQL.="group by Marca, Modelo ";
                $SQL.="Order by Marca, Modelo asc";
                $query2 = $this->conex->ejecutarQuerySQL($SQL); 
                for($i=0;$i<count($query2);$i++){?>
                <tr>    
                    <td bgcolor="#FFFFFF">
                        <font face="Courier New, Courier, mono" color="#0000FF"><h4><?=$query2[$i]["Modelo"];?></h4></font>
                    </td>
                    <?                       
                    $SQL="select Marca,Modelo,idFamilia,Familia,Caracteristica,idCaracteristica,Proporcion,Peso,Factor ";
                    $SQL.="from sc".$scene."Matriz c ";
                    $SQL.="where Modelo='".$query2[$i]["Modelo"]."' ";
                    $SQL.="group by Marca,Modelo,idFamilia,Familia,Caracteristica,idCaracteristica,Proporcion,Peso,Factor ";
                    $SQL.="order by Marca,Modelo,Caracteristica,idCaracteristica asc";
                    $query3 = $this->conex->ejecutarQuerySQL($SQL); 

                    $SQL="select Marca,Modelo,sum(Peso) as 'Ranking'";
                    $SQL.="from sc".$scene."Matriz c ";
                    $SQL.="where Modelo='".$query2[$i]["Modelo"]."' ";
                    $SQL.="group by Marca,Modelo ";
                    $SQL.="order by Marca,Modelo asc ";
                    $query4 = $this->conex->ejecutarQuerySQL($SQL); 
                    
                    for($k=0;$k<count($query3);$k++){
                        if($k%2==0)
                        {
                            $color1="#B7C6FB";
                            $color2="#A0A7FA";
                            $color3="#819BF8";
                            $color4="#000000";
                        }
                        else
                        {
                            $color1="#F4F4F4";
                            $color2="#E5E5E5";
                            $color3="#E0E0E0";
                            $color4="#0000FF";
                        }
                    ?>
                        <td align="center" bgcolor="<?=$color1;?>">
                            <font face="Courier New, Courier, mono" color="<?=$color4;?>"><h4><?=number_format($query3[$k]["Proporcion"],$dec);?></h4></font>
                        </td>
                        <td align="center" bgcolor="<?=$color2;?>">
                            <font face="Courier New, Courier, mono" color="<?=$color4;?>"><h4><?=number_format($query3[$k]["Factor"],$dec);?></h4></font>
                        </td>
                        <td align="center" bgcolor="<?=$color3;?>">
                            <font face="Courier New, Courier, mono" color="<?=$color4;?>"><h4><?=number_format($query3[$k]["Peso"],$dec);?></h4></font>
                        </td>
                    <? } ?>
                    <td align="center" bgcolor="#FF9B6A">
                        <font face="Courier New, Courier, mono" color="<?=$color4;?>"><h4><?=number_format($query4[0]["Ranking"],$dec);?><h4></font>
                    </td>
                </tr>
                <? } ?>
            </table>
            <p>&nbsp;</p>
            <?
            return 1;
        }
    }
    
    function cargaEscenarios()   
    {
        $this->conex = new conEstacion("127.0.0.1","sa","","Tesis");
        $SQL="select name from dbo.sysobjects where ";
        $SQL.="(name like 'sc%Matriz' and name <> 'scOriginalMatriz' and OBJECTPROPERTY(id, N'IsUserTable') = 1) ";
        $SQL.="order by name";
        $escenarios = $this->conex->ejecutarQuerySQL($SQL); 

        $names = array();
        for ($i=0;$i<sizeof($escenarios);$i++) { 
            $names[$i]=substr_replace($escenarios[$i]["name"],'',0, 2);
            $names[$i]=substr_replace($names[$i],'',-6,6);
        } 
        return $names;
        //$escenarios[0][name]="";
        //$this->loadScene($dec,$scene);
    }
    
    function loadScene($dec,$scene)
    {     
        $this->conex = new conEstacion("127.0.0.1","sa","","Tesis");
        //$conex = parent::conEstacion("127.0.0.1","sa","","Tesis");
        $this->setdec($dec);
        $SQL="Exec ifExists '".$scene."'";
        $ifExists = $this->conex->ejecutarQuerySQL($SQL); 
        if(!($ifExists[0]["checa1"]==1 && $ifExists[0]["checa2"]==1)){
            return 0;
        }else{
            ?>
            <table width="100%" border="1" cellpadding="0" cellspacing="0"  bgcolor="" background="">
                <tr>    
                    <td align="center" bgcolor="#D0D0D0" valign="middle" rowspan="2">
                        <font face="Courier New, Courier, mono" color="#000020"><h4>MATRIZ DE PAGOS</h4></font>
                    </td>
                    <?
                    $SQL="Select idFamilia,Familia,idCaracteristica,Caracteristica from sc".$scene."Matriz ";
                    $SQL.="group by idFamilia,Familia,idCaracteristica,Caracteristica ";
                    $SQL.="Order by Caracteristica,idCaracteristica asc";
                    $query = $this->conex->ejecutarQuerySQL($SQL); 
                    for($i=0;$i<count($query);$i++){
                        if($i%2==0){
                            $color="#3399FF";
                            $color2="#FFFFFF";
                        }
                        else
                        {
                            $color="#D0D0D0";
                            $color2="#0000FF";
                        }
                    ?>
                        <td align="center" colspan="3" bgcolor="<?=$color;?>">
                            <font face="Courier New, Courier, mono" color="<?=$color2;?>"><h4><?=$query[$i]["Caracteristica"];?></h4></font>
                        </td>      
                    <? } ?>   
                    <td align="center" colspan="3" rowspan="2" bgcolor="#FF7C3E">
                        <font face="Courier New, Courier, mono" color="#000020"><h4>Ranking</h4></font>
        <!--                        <a href="javascript:mostrarClientes()"><font face="Courier New, Courier, mono" color="#3399FF"><?=$query[$i]["Caracteristica"];?></font></a> -->
                    </td>      
                </tr>    
                <?
                ?>
                <tr>    
                    <?
                    $SQL="select Marca,Modelo,idFamilia,Familia,Caracteristica,idCaracteristica,Proporcion,Peso,Factor ";
                    $SQL.="from sc".$scene."Matriz c ";
                    $SQL.="where Modelo='Astra Paq. C Comfort Manual 1.8L' ";
                    $SQL.="group by Marca,Modelo,idFamilia,Familia,Caracteristica,idCaracteristica,Proporcion,Peso,Factor ";
                    $SQL.="order by Marca,Modelo,Caracteristica,idCaracteristica asc";
                    $query5 = $this->conex->ejecutarQuerySQL($SQL); 
                    for($k=0;$k<count($query5);$k++){
                        if($k%2==0)
                        {
                            $color1="#B7C6FB";
                            $color2="#A0A7FA";
                            $color3="#819BF8";
                            $color4="#000000";
                        }
                        else
                        {
                            $color1="#F4F4F4";
                            $color2="#E5E5E5";
                            $color3="#E0E0E0";
                            $color4="#0000FF";
                        }
        /*
                            $color1="#969696";
                            $color2="#D0D0D0";
                            $color3="#FFFF00";
        */
                    ?>
                        <td align="center" bgcolor="<?=$color1;?>">
                            <font face="Courier New, Courier, mono" color="<?=$color4;?>"><h4>Proporcion</h4></font>
                        </td>
                        <td align="center" bgcolor="<?=$color2;?>">
                            <font face="Courier New, Courier, mono" color="<?=$color4;?>"><h4>Factor</h4></font>
                        </td>
                        <td align="center" bgcolor="<?=$color3;?>">
                            <font face="Courier New, Courier, mono" color="<?=$color4;?>"><h4>Peso</h4></font>
                        </td>
                    <? } ?>
                </tr>    
                <?
                $SQL="Select Marca, Modelo from sc".$scene."Matriz ";
                $SQL.="group by Marca, Modelo ";
                $SQL.="Order by Marca, Modelo asc";
                $query2 = $this->conex->ejecutarQuerySQL($SQL); 
                for($i=0;$i<count($query2);$i++){?>
                <tr>    
                    <td bgcolor="#FFFFFF">
                        <font face="Courier New, Courier, mono" color="#0000FF"><h4><?=$query2[$i]["Modelo"];?></h4></font>
                    </td>
                    <?                       
                    $SQL="select Marca,Modelo,idFamilia,Familia,Caracteristica,idCaracteristica,Proporcion,Peso,Factor ";
                    $SQL.="from sc".$scene."Matriz c ";
                    $SQL.="where Modelo='".$query2[$i]["Modelo"]."' ";
                    $SQL.="group by Marca,Modelo,idFamilia,Familia,Caracteristica,idCaracteristica,Proporcion,Peso,Factor ";
                    $SQL.="order by Marca,Modelo,Caracteristica,idCaracteristica asc";
                    $query3 = $this->conex->ejecutarQuerySQL($SQL); 

                    $SQL="select Marca,Modelo,sum(Peso) as 'Ranking'";
                    $SQL.="from sc".$scene."Matriz c ";
                    $SQL.="where Modelo='".$query2[$i]["Modelo"]."' ";
                    $SQL.="group by Marca,Modelo ";
                    $SQL.="order by Marca,Modelo asc ";
                    $query4 = $this->conex->ejecutarQuerySQL($SQL); 
                    
                    for($k=0;$k<count($query3);$k++){
                        if($k%2==0)
                        {
                            $color1="#B7C6FB";
                            $color2="#A0A7FA";
                            $color3="#819BF8";
                            $color4="#000000";
                        }
                        else
                        {
                            $color1="#F4F4F4";
                            $color2="#E5E5E5";
                            $color3="#E0E0E0";
                            $color4="#0000FF";
                        }
                    ?>
                        <td align="center" bgcolor="<?=$color1;?>">
                            <font face="Courier New, Courier, mono" color="<?=$color4;?>"><h4><?=number_format($query3[$k]["Proporcion"],$dec);?></h4></font>
                        </td>
                        <td align="center" bgcolor="<?=$color2;?>">
                            <font face="Courier New, Courier, mono" color="<?=$color4;?>"><h4><?=number_format($query3[$k]["Factor"],$dec);?></h4></font>
                        </td>
                        <td align="center" bgcolor="<?=$color3;?>">
                            <font face="Courier New, Courier, mono" color="<?=$color4;?>"><h4><?=number_format($query3[$k]["Peso"],$dec);?></h4></font>
                        </td>
                    <? } ?>
                    <td align="center" bgcolor="#FF9B6A">
                        <font face="Courier New, Courier, mono" color="<?=$color4;?>"><h4><?=number_format($query4[0]["Ranking"],$dec);?><h4></font>
                    </td>
                </tr>
                <? } ?>
            </table>
            <p>&nbsp;</p>
            <?
            return 1;
        }
    }
}
