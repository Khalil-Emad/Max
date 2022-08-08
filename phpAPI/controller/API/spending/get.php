<?php
// session_start();
include '../../../controller/function.php';
include '../../../controller/security-ajax.php';
$conn = db($db);
if ($_SERVER['REQUEST_METHOD'] == 'POST') {


        $status = 0;
        $data = [] ;
        $checkAdminId = checkAdminId ();
        $message= $checkAdminId['message'];
        $code= $checkAdminId['code'];
        $status= $checkAdminId['status'];
        $adminId= $checkAdminId['adminId'];
        $userId= $checkAdminId['userId'];
    
    if ($status == 0) {
        $client = "SELECT * , spending.id AS spendingId , spending.status AS spendingStatus   FROM `spending`
          INNER JOIN spendingType ON spendingType.id=spending.spendingTypeId 
         WHERE  ( spending.adminId = '$adminId' OR spending.userId = '$userId'  )";
        $re = $conn->query($client);
        if ($re->num_rows > 0) {
            $data = $re -> fetch_all(MYSQLI_ASSOC);

            $count = count($data); 
            for ($i=0; $i < $count ; $i++) { 
          $data[$i]["date"] =  date('d - m - Y',$data[$i]["date"]);
            // unset($data[$i]["id"]);
            unset($data[$i]["adminId"]);
            unset($data[$i]["userId"]);
            // unset($data[$i]["spendingTypeId"]);
            }
        }
    }
    // echo $client ;

    echo json_encode($data);
    $conn->close();
} 
