<?php
// session_start();
include '../../../controller/function.php';
include '../../../controller/security-ajax.php';
$conn = db($db);
if ($_SERVER['REQUEST_METHOD'] == 'POST') {

        $status = 0;

    if (empty($_POST['firstName']) && strlen($_POST['firstName'])  < 3 && empty($_POST['firstName']) == ' ' ) {
        $message = 'Please complete the name';
        $code = 1;
        $status = 1;
    } else {
        $firstName = filter_var($_POST['firstName'], FILTER_SANITIZE_STRING);
    }


    // if (!filter_var($_POST['email'], FILTER_VALIDATE_EMAIL)) {
    //     $message = 'You have not added an email ';
    //     $code = 3;
    //     $status = 1;
    // } else {
    //     $email = filter_var($_POST['email'], FILTER_VALIDATE_EMAIL);
    // }

    if (empty($_POST['password'])) {
        $message = 'You did not add the password ';
        $code = 4;
        $status = 1;
    } else {
        $secKey = filter_var($_POST['password'], FILTER_SANITIZE_STRING);
    }

    if (strlen($secKey)  < 7) {
        $message = 'Password must be more than 8 characters';
        $code = 5;
        $status = 1;
    }

    $password =  sha1($secKey);
    
    if (!filter_var($_POST['lastName'], FILTER_SANITIZE_STRING)) {
        $message ='You have not added an lastName';
        $code = 9;
        $status = 1;
    } else {
        $lastName = filter_var($_POST['lastName'], FILTER_SANITIZE_STRING);
    }

    if (!filter_var($_POST['mobile'], FILTER_SANITIZE_STRING)) {
        $message ='You have not added an mobile';
        $code = 10;
        $status = 1;
    } else {
        $mobile = filter_var($_POST['mobile'], FILTER_SANITIZE_STRING);
    }

    
    if (!filter_var($_POST['userName'], FILTER_SANITIZE_STRING)) {
        $message ='You have not added an userName';
        $code = 16;
        $status = 1;
    } else {
        $userName = filter_var($_POST['userName'], FILTER_SANITIZE_STRING);
    }


    if (!filter_var($_POST['adminId'], FILTER_SANITIZE_STRING)) {
        $message ='You have not added an adminId';
        $code = 16;
        $status = 1;
    } else {
        $adminId = filter_var($_POST['adminId'], FILTER_SANITIZE_STRING);
    }



    if (isset($userName)) {
        $SQLmobile = "SELECT userName FROM users WHERE userName = '$userName' ";
        $stmt = $conn->query($SQLmobile);
        if ($stmt->num_rows > 0) {
            $message = 'This userName is already registered';
            $code = 6;
            $status = 1;
        }
    }

    if (isset($adminId)) {
        $SQLmobile = "SELECT id FROM `admin` WHERE id = $adminId ";
        $stmt = $conn->query($SQLmobile);
        if ($stmt->num_rows == 0) {
            $message = 'This admin is not registered';
            $code = 100;
            $status = 1;
        }
    }

    // if (isset($email)) {
    //     $sql_email = "SELECT email FROM users WHERE email = '$email' ";
    //     $stmt = $conn->query($sql_email);
    //     if ($stmt->num_rows > 0) {
    //         $message = 'This email is already registered';
    //         $code = 6;
    //         $status = 1;
    //     }
    // }
    
    if ($status == 0) {
        $TimeCheck = strtotime("now");
        $rand_set = rand_set();
        
 
        $R=rand(0,10000);   

        $sql = "INSERT INTO `users` ( `adminID`, `firstName`, `lastName`, `userName`, `password`, `mobile`, `email`, `img`, `status`, `Registration`) 
        VALUES ( $adminId, '$firstName', '$lastName', '$userName', '$password', '$mobile', null, '', 0, '$TimeCheck');";
            
            if ($conn->query($sql) === TRUE) {
         
            $last_id = $conn->insert_id;   
            $message ='User Add';
            $code = 200;
        } else {
            $code = 20;
            $message = 'sql errors INSERT ';
            $message =$sql;;
        }
    }
 

          echo json_encode(['status' => $code, 'msg' => $message]);
             $conn->close();

} else {

    $msg = 'You do not have permission to view the content';
    echo json_encode(['code' => 'You do not have powers', 'Message' => $msg]);
    exit;
}
