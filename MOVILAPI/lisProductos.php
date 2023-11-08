<?php

header("Access-Control-Allow-Origin: *"); // Permite solicitudes desde cualquier origen
header("Access-Control-Allow-Methods: GET"); // Solo permitir solicitudes GET
header("Content-Type: application/json"); // Establecer el tipo de contenido como JSON


require_once "conexion.php";
$sql = "SELECT * FROM T_PRODUCTOS";
$st  = $con->prepare($sql);
$st->execute();
$rst = $st->fetchAll(PDO::FETCH_ASSOC);
echo json_encode($rst);