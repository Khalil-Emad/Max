<?php
// session_start();
include '../../../controller/conn.php';
include '../../../controller/security-ajax.php';
$conn = db($db);
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $message = null;
    $code = 0;
    $status = 0;
    if (!filter_var($_POST['userName'], FILTER_SANITIZE_STRING)) {
        $message ='You have not added an email';
        $code = 3;
        $status = 1;
    } else {
        $userName = filter_var($_POST['userName'], FILTER_SANITIZE_STRING);
    }

    if (!filter_var($_POST['activity'], FILTER_SANITIZE_STRING)) {
        $message ='You have not added an activity';
        $code = 3;
        $status = 1;
    } else {
        $activity = filter_var($_POST['activity'], FILTER_SANITIZE_STRING);
    }

    if (filter_var($userName, FILTER_VALIDATE_EMAIL)) {
       $EmailOruserName = 'email';
      } else {
        $EmailOruserName = 'userName';

      }

    if (empty($_POST['password'])) {
        $message = 'You did not add the password';
        $code = 4;
        $status = 1;
    } else {
        $password = filter_var($_POST['password'], FILTER_SANITIZE_STRING);
    }


    if ($status == 0) {
    //    $passwordTwo =  sha1($password);
        $sql = "SELECT id FROM `userAccount` where $EmailOruserName = '$userName'  AND secKey = '$password' AND code = $activity ";
        $stmt = $conn->query($sql);

        if ($stmt->num_rows > 0) {
            $data = $stmt->fetch_assoc();
            $userID = $data['id'];
            $sql = "UPDATE userAccount SET activity = 1  WHERE id = $userID";
            $stmt = $conn->query($sql);
            $code = 1 ;
        }else {
            $code = 2 ;

        }
 
}

    if ($code == 1 ) {
        echo json_encode(['status' => $code]);
    }else {
        echo json_encode(['status' => $code, 'msg' => $message]);
    }
    $conn->close();

} else {

    $msg = 'You do not have permission to view the content';
    echo json_encode(['code' => 'You do not have powers', 'Message' => $msg]);
    exit;
}
