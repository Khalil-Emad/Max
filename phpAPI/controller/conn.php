<?php
require_once 'Header.php';
$error = 1;
$db = 1;

function db ($db) {
    if ($db == 1) {
        $servername = "localhost:3306";
        $username = "root";
        $password = "";
        $dbname = "max";
    } else {
        $servername = "localhost";
        $username = "sofaMaxApi";
        $password = 't6xKBCZKxyG(';
        $dbname = "max_api";
    }

 @ $conn = mysqli_connect( $servername, $username , $password , $dbname );

 if (!$conn) {
        $error_msg =  'Failed to connect to MySQL';
        $message =  'An unexpected error occurred .. Please contact the management of the Sejll  Development to fix the problem';
        $nu =  '+201001995914';
        echo json_encode(['error'=>$error_msg,'msg'=>$message , 'number' => $nu ]);
        exit();
      }else{ 
        $conn->set_charset('utf8');
        return $conn; 
      }
}

$now =  strtotime(date('d-m-Y')) ; 
define('IsConn', $db);
define('now', $now);

$conn = db (IsConn);
if (IsConn == 1) {
$URL_IS = 'http://localhost/realstat/';
}else {
$URL_IS = 'http://al-moshtry.com/';
}

$EmailFrom = 'info@al-moshtry.com';

define('URL', $URL_IS);




