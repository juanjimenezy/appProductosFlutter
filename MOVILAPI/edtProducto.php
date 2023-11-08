<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST"); 
header("Content-Type: application/json");
header('Access-Control-Allow-Headers: access');

$json = file_get_contents('php://input');
$data = json_decode($json, true);

require_once "conexion.php";
if(isset($data["nombre"]) && isset($data["precio"]) && isset($data["descripcion"]) && isset($data["id"])){

	$nombre  = $data["nombre"];
	$des     = $data["descripcion"];
	$precio  = $data["precio"];
	$id      = $data["id"];

	$sql = "UPDATE T_PRODUCTOS SET
	        PRO_NOMBRE = ?, PRO_PRECIO = ? , PRO_DESCRIPCION = ?
	        WHERE PRO_ID = ?";

	$st  		= $con->prepare($sql);
	$valores 	= array($nombre, $precio, $des, $id);
	$rst        = $st->execute($valores);
	if( $rst > 0){
		echo json_encode(array("mensaje"=>"Se actualizo un producto"));
	}else{
		echo json_encode(array("mensaje"=>"Error al actualizar"));
	}
}else{
	$pNombre = isset($_POST["nombre"]) 		? "": "[nombre]";
	$pPrecio = isset($_POST["precio"]) 		? "": "[precio]";
	$pDes    = isset($_POST["descripcion"]) ? "": "[descripcion]";
	$pid     = isset($_POST["id"]) 			? "": "[id]";
	echo json_encode(array("mensaje"=>"Faltan los parametros $pNombre $pPrecio $pDes $pid en la peticion"));
}