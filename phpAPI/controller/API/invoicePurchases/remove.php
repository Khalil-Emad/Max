<?php
// session_start();
include '../../../controller/function.php';
include '../../../controller/security-ajax.php';
$conn = db($db);

if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['barcode']) ) {
    $message = null ;
    $status = 0;
    $checkAdminId = checkAdminId ();
    $message= $checkAdminId['message'];
    $code= $checkAdminId['code'];
    $status= $checkAdminId['status'];
    $adminId= $checkAdminId['adminId'];
    $userId= $checkAdminId['userId'];
    
if (!filter_var($_POST['barcode'], FILTER_SANITIZE_STRING)) {
    $message ='You have not added an barcode ';
    $code = 1;
    $status = 1;
} else {
    $barcode = filter_var($_POST['barcode'], FILTER_SANITIZE_STRING);
}

if ($status == 0) {
    $sql = "DELETE FROM temp_purchases where ( adminId = '$adminId' OR userId = '$userId'  ) AND barcode = '$barcode' ";
    $conn->query($sql);
    $status = 200;
    $message = 'done';

} 

echo json_encode(['status' => $status, 'msg' => $message]);
$conn->close();
} else {
   $msg = 'You do not have permission to view the content';
   echo json_encode(['status' => 'You do not have powers', 'msg' => $msg]);
}