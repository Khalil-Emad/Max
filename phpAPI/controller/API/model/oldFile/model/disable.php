<?php
// session_start();
include '../../../controller/function.php';
include '../../../controller/security-ajax.php';
$conn = db($db);
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['categoryId'])  && isset($_POST['adminId']) ) {

        $status = 0;
        $message = 0;
        $table = 'model';
        $categoryId =  filter_var($_POST['categoryId'], FILTER_SANITIZE_STRING);
        $adminId =  filter_var($_POST['adminId'], FILTER_SANITIZE_STRING);
        $deletedSql =  deletedSql ($categoryId , $table);


        echo json_encode(['status' => $deletedSql['status'], 'msg' => $deletedSql['msg']]);
        $conn->close();

} else {

    $msg = 'You do not have permission to view the content';
    echo json_encode(['status' => 'You do not have powers', 'Message' => $msg]);
}