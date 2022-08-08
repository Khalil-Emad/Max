<?php
// session_start();
// include '../../controller/conn.php';
include '../../../controller/conn.php';
include '../../../vendor/libphonenumber/vendor/autoload.php';
// namespace libphonenumber\Tests\carrier;

use libphonenumber\PhoneNumber;
use libphonenumber\PhoneNumberToCarrierMapper;
use libphonenumber\PhoneNumberUtil;
use PHPUnit\Framework\TestCase;
// $conn = db($db);
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $message = null;
    $status = 0;

    if (!filter_var($_POST['phone'], FILTER_SANITIZE_STRING)) {
        $message ='Please verify that the phone is correct';
        $code = 3;
    } else {
        $phone = filter_var($_POST['phone'], FILTER_SANITIZE_STRING);
    }

    $phoneNumberUtil = $phoneNumberUtil->isPossibleNumber($phone);
    print_r($phoneNumberUtil);

    if ($phoneNumberUtil === true) {
        $code =200 ;
    } else {
      $message ='Please verify that the phone is correct';
      $code = 2;
    }

    if (filter_var($_POST['email'], FILTER_VALIDATE_EMAIL)) {
        $code =200 ;
      } else {
        $message ='Please verify that the email is correct';
        $code = 1;
      }


        echo json_encode(['status' => $code, 'msg' => $message]);
    

} else {

    $msg = 'You do not have permission to view the content';
    echo json_encode(['code' => 'You do not have powers', 'Message' => $msg]);
    exit;
}
