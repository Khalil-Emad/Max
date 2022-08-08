<?php
// session_start();
include '../../../controller/function.php';
include '../../../controller/security-ajax.php';
$conn = db($db);
if ($_SERVER['REQUEST_METHOD'] == 'POST') {


        $status = 0;
        $checkAdminId = checkAdminId ();
        $message= $checkAdminId['message'];
        $code= $checkAdminId['code'];
        $status= $checkAdminId['status'];
        $adminId= $checkAdminId['adminId'];
        $userId= $checkAdminId['userId'];
    
    if ($status == 0) {
        $checkInfoUser = checkInfoUser ($adminId , $userId) ;
    }
    echo json_encode(['status' => $checkInfoUser['status'] , 'msg' =>  $checkInfoUser['message'] ]);
    @$conn->close();
} 
