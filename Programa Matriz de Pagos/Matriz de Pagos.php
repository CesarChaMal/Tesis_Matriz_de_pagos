<?php
//error_reporting(E_ALL);
error_reporting(0);
include("conEstacion.php");
class Matriz
{
    var $dec=8;

    function conexion()
    {            
        new conEstacion();
    }

    function setdec($dec)
    {            
        $this->dec=$dec;
    }

    function Matriz()
    {            
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
            $query = $conex->ejecutarQuerySQL($SQL); 
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
            $query5 = $conex->ejecutarQuerySQL($SQL); 
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
                    <font face="Courier New, Courier, mono" color="<?=$color4;?>"><h4>Peso</h4></font>
                </td>
                <td align="center" bgcolor="<?=$color3;?>">
                    <font face="Courier New, Courier, mono" color="<?=$color4;?>"><h4>Factor</h4></font>
                </td>
            <? } ?>
        </tr>    
        <?
        $SQL="Select Marca, Modelo from scOriginalMatriz ";
        $SQL.="group by Marca, Modelo ";
        $SQL.="Order by Marca, Modelo asc";
        $query2 = $conex->ejecutarQuerySQL($SQL); 
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
                    <font face="Courier New, Courier, mono" color="<?=$color4;?>"><h4><?=number_format($query3[$k]["Peso"],$dec);?></h4></font>
                </td>
                <td align="center" bgcolor="<?=$color3;?>">
                    <font face="Courier New, Courier, mono" color="<?=$color4;?>"><h4><?=number_format($query3[$k]["Factor"],$dec);?></h4></font>
                </td>
            <? } ?>
            <td align="center" bgcolor="#FF9B6A">
                <font face="Courier New, Courier, mono" color="<?=$color4;?>"><h4><?=number_format($query4[0]["Ranking"],$dec);?><h4></font>
            </td>
        </tr>
        <? } ?>
    </table>
    <p>&nbsp;</p>
    </form>    
    <?
    }
}
        
    
