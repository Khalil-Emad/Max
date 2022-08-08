<?php
// session_start();
include '../../../controller/function.php';
include '../../../controller/security-ajax.php';
$conn = db($db);
if ($_SERVER['REQUEST_METHOD'] == 'POST') {


        $status = 0;
        $data = null ;
        $checkAdminId = checkAdminId ();
        $message= $checkAdminId['message'];
        $code= $checkAdminId['code'];
        $status= $checkAdminId['status'];
        $adminId= $checkAdminId['adminId'];
        $userId= $checkAdminId['userId'];
    
    if ($status == 0) {
        $client = "SELECT * FROM `spendingType` WHERE  ( adminId = '$adminId' OR userId = '$userId'  )";
        $re = $conn->query($client);
        if ($re->num_rows > 0) {
            $data = $re -> fetch_all(MYSQLI_ASSOC);
        }
    }
    echo json_encode($data);
    $conn->close();
} 
