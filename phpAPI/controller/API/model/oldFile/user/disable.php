<?php
// session_start();
include '../../../controller/function.php';
include '../../../controller/security-ajax.php';
$conn = db($db);
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['userId'])  && isset($_POST['adminId']) ) {

        $status = 0;
        $message = 0;
        
        $userId =  filter_var($_POST['userId'], FILTER_SANITIZE_STRING);
        $adminId =  filter_var($_POST['adminId'], FILTER_SANITIZE_STRING);
        $userAccountSql = "SELECT active  FROM `users` where id = $userId  AND adminId = '$adminId' ";
        $reSQL = $conn->query($userAccountSql);
        if ($reSQL->num_rows > 0) {
            $data = $reSQL->fetch_assoc();
        // var_dump($data);
     
        $active =$data['active'];
        if($active == 1 ) {

        $message = 'Account disabled successfully';
        $deleted =0 ;
        }else {
            $message = 'Account restored successfully';
            $deleted = 1;
        }
        $sql = "UPDATE users SET active=$deleted WHERE id=$userId";
        $stmt = $conn->query($sql);

   
 }else {
    $status =1;
    $message = 'The data is incorrect';
 }


 echo json_encode(['status' => $code, 'msg' => $message]);
 $conn->close();

} else {

    $msg = 'You do not have permission to view the content';
    echo json_encode(['code' => 'You do not have powers', 'Message' => $msg]);
    exit;
}
