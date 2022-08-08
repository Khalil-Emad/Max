<?php
// session_start();
include '../../../controller/function.php';
include '../../../controller/security-ajax.php';
$conn = db($db);
if ($_SERVER['REQUEST_METHOD'] == 'POST') {

            $status = 0;
            $nu = 0;
            $statusCse = 0;
        $checkAdminId = checkAdminId ();
        $message= $checkAdminId['message'];
        $code= $checkAdminId['code'];
        $status= $checkAdminId['status'];
        $adminId= $checkAdminId['adminId'];
        $userId= $checkAdminId['userId'];
      
    if (!filter_var($_POST['spendingTypeId'], FILTER_SANITIZE_STRING)) {
        $message ='You have not added an spending Type Id';
        $code = 2;
        $status = 1;
    } else {
        $spendingTypeId = filter_var($_POST['spendingTypeId'], FILTER_SANITIZE_STRING);
    }


        $checkSpendingTypeId = checkSpendingTypeId($adminId , $userId , $spendingTypeId) ;
        $status = $checkSpendingTypeId['status'];
        $message = $checkSpendingTypeId['message'];
        $statusCse = $checkSpendingTypeId['statusCse'];

    
        if ($status == 0) {
            if ($statusCse == 1 ) {
                $message = 'spending type disable';
                $nu = 0 ;
            }else {
                $message = 'spending type enable';
                $nu = 1 ;
            }
            UpdateStatusSQL ('spendingType' ,$nu , 'id' ,$spendingTypeId );
            $status = 200;
        }


 
    echo json_encode(['status' => $code, 'msg' => $message]);
    
    $conn->close();

} else {

    $msg = 'You do not have permission to view the content';
    echo json_encode(['code' => 'You do not have powers', 'Message' => $msg]);
    exit;
}
