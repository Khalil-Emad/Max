<?php
// session_start();
include '../../../controller/function.php';
include '../../../controller/security-ajax.php';
$conn = db($db);

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
$status = 200 ;
$message = 'done' ;
$updateErrors = 0 ;
$updateDone = 0 ;
$data[] = null;

if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['barcode']) && isset($_POST['from'])  && isset($_POST['to']) && isset($_POST['date']) ) {
  
    // if (isset($_POST['adminId'])) {
  
        $checkAdminId = checkAdminId ();
        $message= $checkAdminId['message'];
        $code= $checkAdminId['code'];
        $status= $checkAdminId['status'];
        $adminId= $checkAdminId['adminId'];
        $userId= $checkAdminId['userId'];
        $from =  filter_var($_POST['from'], FILTER_SANITIZE_STRING);
        $to =  filter_var($_POST['to'], FILTER_SANITIZE_STRING);

       if (checkStoreType ($to) !== false ) {
        // $barcode =  filter_var($_POST['barcode'], FILTER_SANITIZE_STRING);
        $convertDateTime = convertDateTime (); 
        $date = $convertDateTime['date'];

        $barcode = $_POST['barcode'];
        $previous =  json_decode($barcode);
        foreach ($previous as $code) { 
            //   
            $sql = "UPDATE  stock SET storeId=$to , updateDate='$date'  where ( status = 0 or  status = 3 ) AND barcode ='$code' ";
            if ($conn->query($sql) === TRUE) {    
                $updateDone ++;
            }else {
                $updateErrors ++;
            }
            $message = 'done';
            $status = 200 ;
        }
     
       }else {
           $message = 'check Store Id';
           $status = 100 ;

       }
}

echo json_encode(['status'=> $status 
, 'msg' => $message
, 'updateDone' => $updateDone
, 'updateErrors' => $updateErrors
]);
$conn->close();
