<?php
// session_start();
include '../../../controller/function.php';
include '../../../controller/security-ajax.php';
$conn = db($db);
if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    $checkAdminId = checkAdminId ();
    $message= $checkAdminId['message'];
    $code= $checkAdminId['code'];
    $status= $checkAdminId['status'];
    $adminId= $checkAdminId['adminId'];
    $userId= $checkAdminId['userId'];

    $message = null;
    $status = 0;

            if (empty($_POST['password'])) {
                $message = 'You did not add the password';
                $status = 1;
            } else {
                $password = filter_var($_POST['password'], FILTER_SANITIZE_STRING);
            }


        if ($status == 0) {
                $passwordTwo =  sha1($password);
                $sql = "SELECT * FROM `admin` where  id = $adminId AND  `password` = '$passwordTwo' ";
                $stmt = $conn->query($sql);
                if ($stmt->num_rows > 0) {
                    $status = 200;
                    $message = 'done';

                }else {
                    $message = 'wrong password';

                    $status = 100;
            }
        }


echo json_encode(['status' => $status, 'msg' => $message]);
$conn->close();
}

