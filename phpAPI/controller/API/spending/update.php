<?php
// session_start();
include '../../../controller/function.php';
include '../../../controller/security-ajax.php';
$conn = db($db);
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['cash']) && isset($_POST['date']) ) {
    $cash = null;
    $message = null ;
    $status = 0;
    $checkAdminId = checkAdminId ();
    $message= $checkAdminId['message'];
    $code= $checkAdminId['code'];
    $status= $checkAdminId['status'];
    $adminId= $checkAdminId['adminId'];
    $userId= $checkAdminId['userId'];
    
    $convertDateTime = convertDateTime (); 
    $convertDate = $convertDateTime['convertDate'];


if (!filter_var($_POST['cash'], FILTER_SANITIZE_STRING)) {
    $message ='You have not added an cash';
    $code = 1;
    $status = 1;
} else {
    $cash = filter_var($_POST['cash'], FILTER_SANITIZE_STRING);
}

if (!isset($_POST['spendingId'])) {
    $message ='You have not added an spending  Id';
    $code = 2;
    $status = 1;
} else {
    $spendingId = filter_var($_POST['spendingId'], FILTER_SANITIZE_STRING);
}


if ($status == 0) {
    if ($cash !== null ) {
        $sqlCash = "cash='".$cash."' , ";
    }
         $sql = "UPDATE spending SET $sqlCash `date`='$convertDate'   WHERE id=$spendingId";
        $stmt = $conn->query($sql); 
         $message = 'done';
         $code = 200;
}


echo json_encode(['status' => $code, 'msg' => $message]);
$conn->close();
} else {
   $msg = 'You do not have permission to view the content';
   echo json_encode(['status' => 'You do not have powers', 'msg' => $msg]);
   exit;
}