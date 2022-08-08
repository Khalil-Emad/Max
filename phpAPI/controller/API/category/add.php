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
        
    if (!filter_var($_POST['categoryName'], FILTER_SANITIZE_STRING)) {
        $message ='You have not added an categoryName';
        $code = 1;
        $status = 1;
    } else {
        $categoryName = filter_var($_POST['categoryName'], FILTER_SANITIZE_STRING);
    }

    if (!filter_var($_POST['categoryNameAr'], FILTER_SANITIZE_STRING)) {
        $message ='You have not added an categoryNameAr';
        $code = 2;
        $status = 1;
    } else {
        $categoryNameAr = filter_var($_POST['categoryNameAr'], FILTER_SANITIZE_STRING);
    }

     $SQLmobile = "SELECT id FROM `category` WHERE ( adminId = '$adminId' OR userId = '$userId'  ) AND categoryName = '$categoryName' AND categoryNameAr = '$categoryNameAr'  ";
    $stmt = $conn->query($SQLmobile);
    if ($stmt->num_rows > 0) {
        $message = 'is already registered';
        $code = 25;
        $status = 1;
    }
    
    
    if ($status == 0) {
        $sql = "INSERT INTO `category` (adminId , userId , `categoryName`, `categoryNameAr`) VALUES ($adminId , $userId , '$categoryName', '$categoryNameAr');";
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
