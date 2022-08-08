<?php
// session_start();
// include '../../controller/conn.php';
include '../../../controller/function.php';
// include '../../../vendor/libphonenumber/vendor/autoload.php';
// // namespace libphonenumber\Tests\carrier;

// use libphonenumber\PhoneNumber;
// use libphonenumber\PhoneNumberToCarrierMapper;
// use libphonenumber\PhoneNumberUtil;
// use PHPUnit\Framework\TestCase;
// $conn = db($db);
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $message = null;
    $status = 0;


    if (isset($_POST['phone'])) { 
            if (!filter_var($_POST['phone'], FILTER_SANITIZE_STRING)) {
                $message ='Required';
                $code = 1;
            } else {
                $phone = filter_var($_POST['phone'], FILTER_SANITIZE_STRING);
            }
        
            // $phoneNumberUtil = $phoneNumberUtil->isPossibleNumber($phone);
            if (empty($phone) ) {
                $message ='Required';
                $code = 1;
            }else {
                if (validate_phone_number($phone) === true) {
                    $code =200 ;
                } else {
                  $message ='Please verify that the phone is correct';
                  $code = 2;
                }
            }
     
    }

            if (isset($_POST['email'])) {
                if (empty($_POST['email']) ) {
                    $message ='Required';
                    $code = 1;
                }else {
                if (filter_var($_POST['email'], FILTER_VALIDATE_EMAIL)) {
                    $code =200 ;
                  } else {
                    $message ='Please verify that the email is correct';
                    $code = 3;
                  }
            }
        }

            if ($code == 200 ) {
               echo json_encode(['status' => $code ]);
            }else {
                echo json_encode(['status' => $code, 'msg' => $message]);

            }
            // echo json_encode(['status' => $code, 'msg' => $message]);


            //     if ($code != 200 ) {
            //         echo json_encode(['status' => $code, 'msg' => $message]);
            // }
      
    
            $conn->close();

} else {

    $msg = 'You do not have permission to view the content';
    echo json_encode(['code' => 'You do not have powers', 'Message' => $msg]);
    exit;
}
