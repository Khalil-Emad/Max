<?php
// session_start();
include '../../../controller/function.php';
include '../../../controller/security-ajax.php';
$conn = db($db);
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $data[] = null;
    if (isset($_POST['adminId']) && isset($_POST['categoryId'])) {
        $checkAdminId = checkAdminId ();
        $message= $checkAdminId['message'];
        $code= $checkAdminId['code'];
        $status= $checkAdminId['status'];
        $adminId= $checkAdminId['adminId'];
        $userId= $checkAdminId['userId'];

        
        $categoryId =  filter_var($_POST['categoryId'], FILTER_SANITIZE_STRING);

        $category = "SELECT * FROM `model` where ( adminId = '$adminId' OR userId = '$userId'  )   AND categoryId =$categoryId  ";
        $stmt = $conn->query($category);
        if ($stmt->num_rows > 0) {
            $data = $stmt -> fetch_all(MYSQLI_ASSOC);
        }
    }
}

echo json_encode($data);
$conn->close();
