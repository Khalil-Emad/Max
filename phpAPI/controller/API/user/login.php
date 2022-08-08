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
            $userName =  $data['username'];

            $data['caseLogin'] = 'admin' ;
          
        
            if ($data['active'] == 1) {

                $code = 1 ;
                $message = 'logged as admin Successfully';
                $adminId = $data["id"] ;
               $_SESSION['adminId'] = $data['id'] ;
              
                $sql = "UPDATE `admin` SET logged=1 WHERE id=$adminId ";
                $conn->query($sql);

            }else {
                $code = 2 ;
                $message = 'Your admin account is suspended, contact the administration';
            }

        }else {
            $sql = "SELECT * FROM `users` where $EmailOruserName = '$userName'  AND `password` = '$passwordTwo' ";
            $stmt = $conn->query($sql);
    
            if ($stmt->num_rows > 0) {

                $data = $stmt->fetch_assoc();

                 $userName =  $data['userName'];
                $data['caseLogin'] = 'users' ;
                if ($data['active'] == 1) {
                    $_SESSION['userId'] = $data['id'] ;
                    $code = 1 ; 
                    $message = 'logged as user Successfully';
                   
                    $userId = $data["id"] ;
                    $sql = "UPDATE `users` SET logged=1 WHERE id=$userId ";
                    $conn->query($sql);

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
    if ($code == 1 ) {
        unset($data['password']);
        unset($data['code']);
        echo json_encode(['status' => $code,  'data' => $data , 'msg' => $message]);
        setcookie("userId", $data['id']);
        setcookie("userName", $userName);  /* expire in 1 hour */   
       
         $_SESSION['caseLogin'] = $data['caseLogin'] ;
         $_SESSION['logged'] = 1 ;
        
    }else {
        echo json_encode(['status' => $code, 'msg' => $message]);
    }

$conn->close();

} else {

    $msg = 'You do not have permission to view the content';
    echo json_encode(['code' => 'You do not have powers', 'Message' => $msg]);
    exit;
}
