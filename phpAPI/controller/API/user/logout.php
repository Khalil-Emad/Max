<?php
// session_start();
include '../../../controller/function.php';
include '../../../controller/security-ajax.php';
$conn = db($db);
if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    $status = 0 ;
    $checkAdminId = checkAdminId ();
    $status= $checkAdminId['status'];
    $adminId= $checkAdminId['adminId'];
    $userId= $checkAdminId['userId'];
    $caseLogin= $checkAdminId['caseLogin'];

        if ($status == 0) {

            if ($caseLogin == 'admin') {
                $sql = "UPDATE `admin` SET logged=0 WHERE id=$adminId ";
                $conn->query($sql);
                $status = 200 ;
            }
    
            if ($caseLogin == 'users') {
                $sql = "UPDATE `users` SET logged=0 WHERE  id=$userId  AND adminID = $adminId ";
                $conn->query($sql);
                $status = 200 ;
            }

        }


echo json_encode(['status' => $status , 'caseLogin' => $caseLogin]);
$conn->close();
}

