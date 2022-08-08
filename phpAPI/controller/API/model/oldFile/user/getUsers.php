<?php
// session_start();
include '../../../controller/function.php';
include '../../../controller/security-ajax.php';
$conn = db($db);
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $data[] = null;

    $checkAdminId = checkAdminId ();
    $message= $checkAdminId['message'];
    $code= $checkAdminId['code'];
    $status= $checkAdminId['status'];
    $adminId= $checkAdminId['adminId'];
    $userId= $checkAdminId['userId'];
    

    // if (isset($_POST['adminId'])) {
        // $adminId =  filter_var($_POST['adminId'], FILTER_SANITIZE_STRING);
        $usersSql = "SELECT * FROM `users` where adminID = $adminId ";
        $re = $conn->query($usersSql);
        if ($re->num_rows > 0) {
            $data = $re -> fetch_all(MYSQLI_ASSOC);
            unset($data["email"]);

        }
    // }
    unset($data['password']);
    echo json_encode($data);
}
$conn->close();



