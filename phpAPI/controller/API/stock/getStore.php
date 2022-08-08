<?php
// session_start();
include '../../../controller/function.php';
include '../../../controller/security-ajax.php';
$conn = db($db);
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $data[] = null;
    // if (isset($_POST['adminId']) && isset($_POST['categoryId'])) {        
        $category = "SELECT id ,  nameAr , nameEn FROM `storetype` where  status = 0  ";
        $stmt = $conn->query($category);
        if ($stmt->num_rows > 0) {
            $data = $stmt -> fetch_all(MYSQLI_ASSOC);
        }
    }
// }

echo json_encode($data);
$conn->close();
