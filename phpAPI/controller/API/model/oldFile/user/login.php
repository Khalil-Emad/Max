<?php
// session_start();
include '../../../controller/function.php';
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
       $passwordTwo =  sha1($password);
        $sql = "SELECT * FROM `admin` where $EmailOruserName = '$userName'  AND `password` = '$passwordTwo' ";
        $stmt = $conn->query($sql);

        if ($stmt->num_rows > 0) {
            $data = $stmt->fetch_assoc();
            $data['caseLogin'] = 'admin' ;
        
            if ($data['active'] == 1) {
                $code = 1 ;
                $message = 'logged as admin Successfully';
            }else {
                $code = 2 ;
                $message = 'Your admin account is suspended, contact the administration';
            }

        }else {
            $sql = "SELECT * FROM `users` where $EmailOruserName = '$userName'  AND `password` = '$passwordTwo' ";
            $stmt = $conn->query($sql);
    
            if ($stmt->num_rows > 0) {

                $data = $stmt->fetch_assoc();
                $data['caseLogin'] = 'users' ;
                if ($data['active'] == 1) {
                    $code = 1 ; 
                    $message = 'logged as user Successfully';
                    unset($data["email"]);
                }else {
                    $code = 2 ;
                    $message = 'Your user account is suspended, contact the administration';
                }
                

            }else {
                $code = 0 ;
                $message = 'Wrong Data';

            }

        }
 
}
    unset($data['password']);
    if ($code == 1 ) {
        unset($data['code']);
        echo json_encode(['status' => $code,  'data' => $data , 'msg' => $message]);
    }else {
        echo json_encode(['status' => $code, 'msg' => $message]);
    }

$conn->close();

} else {

    $msg = 'You do not have permission to view the content';
    echo json_encode(['code' => 'You do not have powers', 'Message' => $msg]);
    exit;
}
