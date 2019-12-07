<?php
include_once("includes/Matriz de Pagos.php");
?>
<script language="JavaScript">
    function checarNumero(f){
        if (isNaN (f.value)){//IsNaN Is Not a Numeric si no es numero
            f.value="";
        }
    }

    function creaescena(){
        var f=document.mainpage,a="";
        
        if(f.txtCreateScene.value=="")
            a+="\nProporciona un nombre para el escenario";
        
        if(a==""){
            f.createSnece.value="si";
            f.submit();
        }else
            alert(a);
    }

    function cargaescena(){
        var f=document.mainpage,a="";
        
        if(f.cbocargaescenarios.options[f.cbocargaescenarios.selectedIndex].value==0)
            a+="\nProporciona un escenario a cargar";

        if(a==""){
            f.loadSnece.value="si";
            f.submit();
        }else
            alert(a);
    }
</script>
<?
class mainPage extends Matriz
{
    var $tempcreatescene;
    var $temploadscene;
    var $mensaje;
    
    function crea()
    {    
        $continuar = true;
    
        if(isset($_POST["txtCreateScene"]) && !empty($_POST["txtCreateScene"]))
            $this->tempcreatescene = $_POST["txtCreateScene"];
        else 
            $continuar = false;
                        
        if($continuar)
            return 1;
        else 
            return 0;
    }    

    function carga()
    {    
        $continuar = true;
    
        if(isset($_POST["cbocargaescenarios"]) && !empty($_POST["cbocargaescenarios"]))
            $this->temploadscene = $_POST["cbocargaescenarios"];
        else 
            $continuar = false;
                        
        if($continuar)
            return 1;
        else 
            return 0;
    }    

    function mainpage(){
    ?>
    <body bgcolor="#D0D0D0" background="">
        <form name="mainpage" method="post" action="">
        <input type="hidden" name="createSnece" value="">
        <input type="hidden" name="loadSnece" value="">
            <?
            //parent::cargaEscenarios();
            //echo $this->mensaje;
            ?> <!--<div style='width:90%; height:90%; overflow:auto'> --> <?
            if(!isset($_POST["createSnece"]) || !isset($_POST["loadSnece"])){
                parent::Matriz(8);
            }
            else
            {
                if($this->crea()){
                    if(!parent::createScene(8,$this->tempcreatescene))
                        $this->mensaje="No se pudo crear el escenario";
                    else
                        $this->mensaje="Se creo el escenario ".$this->tempcreatescene;
                }
                if($this->carga()){
                    if(!parent::loadScene(8,$this->temploadscene))
                        $this->mensaje="No se pudo cargar el escenario";
                    else
                        $this->mensaje="Se cargo el escenario ".$this->temploadscene;
                }
            }
            echo $this->mensaje;
            ?> <!-- </div> --> <?
            
            ?>
            <table width="100%" border="0" cellpadding="0" cellspacing="0"  bgcolor="" background="">
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        <input type="text" name="txtCreateScene">
                        <input type="button" name="buttonCreateScene" value="Crear Escenario" onclick="creaescena()">
                    </td>
                    <td align="right">
                        <font face="Courier New, Courier, mono" color="#000020"><h4>Carga Matriz</h4></font>
                    </td>
                    <td>
                        <?
                            $checa=parent::cargaEscenarios();
                        ?>
                        <select name="cbocargaescenarios" onchange="cargaescena()">
<!--                        <select name="cbocargaescenarios" onchange="this.form.submit()"> -->
                            <option value="0" selected>Seleccione...</option>
                            <? for($i=0;$i<count($checa);$i++){?>
                                <option value="<?=$checa[$i];?>"<?=($this->temploadscene==$checa[$i])?"selected":"";?>>
                                <?=$checa[$i];?>
                                </option>
                            <? } ?>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </form>
    <body>
    <?
    }
}
$omainpage = new mainpage();
?>
