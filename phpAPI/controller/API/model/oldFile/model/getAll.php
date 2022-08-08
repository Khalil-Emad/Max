<?php
// session_start();
include '../../../controller/function.php';
include '../../../controller/security-ajax.php';
$conn = db($db);
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $data[] = null;
    // if (isset($_POST['adminId'])) {

        $checkAdminId = checkAdminId ();
        $message= $checkAdminId['message'];
        $code= $checkAdminId['code'];
        $status= $checkAdminId['status'];
        $adminId= $checkAdminId['adminId'];
        $userId= $checkAdminId['userId'];

        // $adminId =  filter_var($_POST['adminId'], FILTER_SANITIZE_STRING);
        $category = "SELECT DISTINCT  * , model.id as 'modelId' FROM `model` INNER JOIN category ON category.id=model.categoryId where  model.adminId = $adminId";
        $stmt = $conn->query($category);
        if ($stmt->num_rows > 0) {
            $data = $stmt -> fetch_all(MYSQLI_ASSOC);
        }
    // }
}

echo json_encode($data);
$conn->close();
