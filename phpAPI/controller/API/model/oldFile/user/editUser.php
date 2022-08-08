<?php
// session_start();
include '../../../controller/function.php';
include '../../../controller/security-ajax.php';
$conn = db($db);
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['userId']) ) {

        $status = 0;
        $userId =  filter_var($_POST['userId'], FILTER_SANITIZE_STRING);
        $usersSql = "SELECT id , userName , email  FROM `users` where id = $userId ";
        $reSQL = $conn->query($usersSql);
        if ($reSQL->num_rows > 0) {
        $data = $reSQL->fetch_all();
        // var_dump($data);
        $userId = $data[0][0] ;
        $userNameCurrent = $data[0][1] ;
        $emailCurrent = $data[0][2] ;
        // $userNameCurrent = $data['userName'] ;
        // $emailCurrent = $data['email'] ;
               
    if (empty($_POST['firstName']) && strlen($_POST['firstName'])  < 3 && empty($_POST['firstName']) == ' ' ) {
        $message = 'Please complete the name';
        $status = 1;
    } else {
            $firstName = filter_var($_POST['firstName'], FILTER_SANITIZE_STRING);
            $sql = "UPDATE users SET firstName='$firstName' WHERE id=$userId";
            $stmt = $conn->query($sql);
    }

    if (strlen($_POST['password'])  < 7 && !empty($_POST['password'])) {
        $password =  sha1($password);
        $sql = "UPDATE users SET password='$password' WHERE id=$userId";
        $stmt = $conn->query($sql);
    }

    
    if (!filter_var($_POST['lastName'], FILTER_SANITIZE_STRING)) {
        $message ='You have not added an lastName';
        $code = 9;
        $status = 1;
    } else {
        $lastName = filter_var($_POST['lastName'], FILTER_SANITIZE_STRING);
        $sql = "UPDATE users SET lastName='$lastName' WHERE id=$userId";
        $stmt = $conn->query($sql);
    }

    if (!filter_var($_POST['mobile'], FILTER_SANITIZE_STRING)) {
        $message ='You have not added an mobile';
        $code = 10;
        $status = 1;
    } else {
        $mobile = filter_var($_POST['mobile'], FILTER_SANITIZE_STRING);
        $sql = "UPDATE users SET `number`='$mobile' WHERE id=$userId";
        $stmt = $conn->query($sql);
    }

    if (!filter_var($_POST['userName'], FILTER_SANITIZE_STRING)) {
        $message ='You have not added an userName';
        $code = 16;
        $status = 1;
    } else {
        $userName = filter_var($_POST['userName'], FILTER_SANITIZE_STRING);
        $SQLmobile = "SELECT userName FROM users WHERE userName = '$userName'  AND   userName !='$userNameCurrent' -- id != '$userId'  ";
        $stmt = $conn->query($SQLmobile);
        if ($stmt->num_rows > 0) {
            $message = 'This userName is already registered';
            $code = 6;
            $status = 1;
        }else {
            $sql = "UPDATE users SET userName='$userName' WHERE id=$userId";
            $stmt = $conn->query($sql);
        }
 
    }

    if (!filter_var($_POST['email'], FILTER_VALIDATE_EMAIL)) {
        $message = 'You have not added an email ';
        $code = 3;
        $status = 1;
    } else {
        $email = filter_var($_POST['email'], FILTER_VALIDATE_EMAIL);
        $userName = filter_var($_POST['userName'], FILTER_SANITIZE_STRING);
        $SQLmobile = "SELECT email FROM users WHERE email = '$email'  AND   email !='$emailCurrent' -- id != '$userId'  ";
        $stmt = $conn->query($SQLmobile);
        if ($stmt->num_rows > 0) {
            $message = 'This email is already registered';
            $code = 6;
            $status = 1;
        }else {
            $sql = "UPDATE users SET email='$email' WHERE id=$userId";
            $stmt = $conn->query($sql);
        }
    }

    echo json_encode(['status' => $code, 'msg' => $message]);
 }
 $conn->close();

} else {

    $msg = 'You do not have permission to view the content';
    echo json_encode(['code' => 'You do not have powers', 'Message' => $msg]);
    exit;
}
$conn->close();
