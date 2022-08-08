<?php
// session_start();
include '../../../controller/function.php';
include '../../../controller/security-ajax.php';
$conn = db($db);
if ($_SERVER['REQUEST_METHOD'] == 'POST'&& isset($_POST['categoryId'])  && isset($_POST['adminId']) ) {

        $status = 0;
        $code = 0;
        $message = null;
        $categoryId = null;


    $checkAdminId = checkAdminId ();
    $message= $checkAdminId['message'];
    $code= $checkAdminId['code'];
    $status= $checkAdminId['status'];
    $adminId= $checkAdminId['adminId'];
    $userId= $checkAdminId['userId'];
    
    if ($status == 0) {
        $checkCategoryId =  checkCategoryId ();
        $message= $checkCategoryId['message'];
        $code= $checkCategoryId['code'];
        $status= $checkCategoryId['status'];
        $categoryId = $checkCategoryId['categoryId'];
    }
  
    
    // $SQLmobile = "SELECT id FROM `model` WHERE ( adminId = '$adminId' OR userId = '$userId'  )  AND categoryId = '$categoryId'  ";
    // $stmt = $conn->query($SQLmobile);
    // if ($stmt->num_rows > 0) {
    //     $message = 'is already registered';
    //     $code = 25;
    //     $status = 1;
    // }
    if ($status == 0) {
        // echo 'WDWD';
        randSet:
        $rand_set = rand_set();
        $sql = "SELECT * FROM `model` where `code` = $rand_set ";
        $stmt = $conn->query($sql);
        if ($stmt->num_rows > 0) { 
            $rand_set = rand_set();
            goto randSet;
        }


         $sql = "INSERT INTO `model` ( `adminId`, `userId` ,`categoryId`, `code`, `status`) VALUES ( $adminId, $userId , $categoryId, $rand_set, 1);";
           if ($conn->query($sql) === TRUE) {
            $code = 200;
            $message = $rand_set;
        } else {
            $code = 20;
            $message = 'sql errors INSERT ';
        }
    }
 
    echo json_encode(['status' => $code, 'msg' => $message]);
    
    $conn->close();

} else {

    $msg = 'You do not have permission to view the content';
    echo json_encode(['code' => 'You do not have powers', 'Message' => $msg]);
    exit;
}
