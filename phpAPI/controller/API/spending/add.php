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
        
        $convertDateTime = convertDateTime (); 
        $convertDate = $convertDateTime['convertDate'];

    if (!filter_var($_POST['date'], FILTER_SANITIZE_STRING)) {
        $message ='You have not added an date';
        $code = 1;
        $status = 1;
    } else {
        $date = strtotime($_POST['date']);
    }

    if (!filter_var($_POST['cash'], FILTER_SANITIZE_STRING)) {
        $message ='You have not added an cash';
        $code = 1;
        $status = 1;
    } else {
        $cash = filter_var($_POST['cash'], FILTER_SANITIZE_STRING);
    }

    if (!isset($_POST['spendingTypeId'])) {
        $message ='You have not added an spending Type Id';
        $code = 2;
        $status = 1;
    } else {
        $spendingTypeId = filter_var($_POST['spendingTypeId'], FILTER_SANITIZE_STRING);
    }


        $checkSpendingTypeId = checkSpendingTypeId($adminId , $userId , $spendingTypeId) ;
        $status = $checkSpendingTypeId['status'];
        $message = $checkSpendingTypeId['message'];


    
    
    if ($status == 0) {
        $TimeCheck = strtotime("now");

        $sql = "INSERT INTO `spending` (`adminId`, `userId`, `spendingTypeId`, `cash`, `date`, `dateRegistered`, `status`) 
                                VALUES ( $adminId,$userId, $spendingTypeId, $cash, '$convertDate', '$TimeCheck', 0);";
           if ($conn->query($sql) === TRUE) {
            $code = 200;
            $message = 'registered';
        } else {
            $code = 20;
            $message = 'sql errors INSERT ';
            // $message =$sql;
        }
    }
 
    echo json_encode(['status' => $code, 'msg' => $message]);
    
    $conn->close();

} else {

    $msg = 'You do not have permission to view the content';
    echo json_encode(['code' => 'You do not have powers', 'Message' => $msg]);
    exit;
}
