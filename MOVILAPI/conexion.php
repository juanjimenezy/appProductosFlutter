<?php
$user     = "root";
$password = "root";
$server   = "mysql:host=localhost;dbname=compumovil";

$con     = new PDO($server, $user, $password);
$con->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

// echo sha1('%&LostPwfsdfasd');