<?php
// session_start();
include '../../../controller/function.php';
include '../../../controller/security-ajax.php';
$conn = db($db);
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['categoryId']) && isset($_POST['adminId']) ) {

        $status = 0;
        $message =null;
        $checkAdminId = checkAdminId ();
        $message= $checkAdminId['message'];
        $code= $checkAdminId['code'];
        $status= $checkAdminId['status'];
        $adminId= $checkAdminId['adminId'];
        $userId= $checkAdminId['userId'];

        $categoryId =  filter_var($_POST['categoryId'], FILTER_SANITIZE_STRING);
        // $adminId =  filter_var($_POST['adminId'], FILTER_SANITIZE_STRING);
       
        $categorySQL = "SELECT * FROM `category` where ( adminId = '$adminId' OR userId = '$userId'  )  AND id = $categoryId ";
        $reSQL = $conn->query($categorySQL);
        if ($reSQL->num_rows > 0) {
            $data = $reSQL -> fetch_all(MYSQLI_ASSOC);


        $categoryName =  filter_var($_POST['categoryName'], FILTER_SANITIZE_STRING);
        $categoryNameAr =  filter_var($_POST['categoryNameAr'], FILTER_SANITIZE_STRING);
        $icon =  filter_var($_POST['icon'], FILTER_SANITIZE_STRING);
        

        $sql = "UPDATE category SET categoryName='$categoryName' , categoryNameAr='$categoryNameAr'  WHERE id=$categoryId";
        $stmt = $conn->query($sql); 
         $message = 'done';
 }


 echo json_encode(['status' => $code, 'msg' => $message]);
 $conn->close();

} else {

    $msg = 'You do not have permission to view the content';
    echo json_encode(['code' => 'You do not have powers', 'Message' => $msg]);
    exit;
}