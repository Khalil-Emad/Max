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
        $id = 1 ;
        
        $categoryId =  filter_var($_POST['categoryId'], FILTER_SANITIZE_STRING);

        $category = "SELECT id FROM `invoice` where ( adminId = '$adminId' OR userId = '$userId'  )   ";
        $stmt = $conn->query($category);
        if ($stmt->num_rows > 0) {
            $data = $stmt -> fetch_all(MYSQLI_ASSOC);
            $id = $data['id'] + 1;
        }
    }
}

echo json_encode(['invoiceId' => $id]);
$conn->close();
