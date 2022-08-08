<?php
// session_start();
include '../../../controller/function.php';
include '../../../controller/security-ajax.php';
$conn = db($db);
// error(true);
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
            $total = 0;
            $cash = 0;
            $caseSql = "";
            $date = null;
            $message = "";
            $invoiceSalesId = 0;
            $errorsSql = false;

        $checkAdminId = checkAdminId();
        $message = $checkAdminId['message'];
        $code = $checkAdminId['code'];
        $status = $checkAdminId['status'];
        $adminId = $checkAdminId['adminId'];
        $userId = $checkAdminId['userId'];

        $convertDateTime = convertDateTime (); 
        $date = $convertDateTime['strtotime'];
        $time = $convertDateTime['dataTime'];


        if (!filter_var($_POST['randCode'], FILTER_SANITIZE_STRING)) {
            $message = 'You have not added an randCode';
            $code = 2;
            $status = 1;
        } else {
            $randCode = filter_var($_POST['randCode'], FILTER_SANITIZE_STRING);
            if (checkRandCodeInvoiceSales($randCode) !== true) {
                $message = 'Invoice number is already registered';
                $code = 3;
                $status = 1;
            }
        }

        if (!filter_var($_POST['invoiceSalesId'], FILTER_SANITIZE_STRING)) {
            $message = 'You have not added an invoice Sales Id';
            $code = 2;
            $status = 1;
        } else {
            $invoiceSalesId = filter_var($_POST['invoiceSalesId'], FILTER_SANITIZE_STRING);
        }




        if (empty($_POST['discount'])) {
            $discount = 0;
        } else {
            $discount = filter_var($_POST['discount'], FILTER_SANITIZE_STRING);
        }
        

        if ($status == 0) {
            $TimeCheck = strtotime("now");
            $tamp_purchasesCheck = "SELECT * FROM `temp_Sales` where ( adminId = '$adminId' OR userId = '$userId'  ) AND randCode = $randCode";
            $reSQL = $conn->query($tamp_purchasesCheck);
            if ($reSQL->num_rows == 0) {
                $message = 'rand Code code not registered';
                $code = 3;
            } else {

                $tempSalesSum = tempSalesSum($table = 'temp_Sales' ,  $randCode  ) ;
                $total =  $tempSalesSum['total'];
                $cash = $total - $discount ;
                $sql = "INSERT INTO `invoiceSales` ( `adminId`, `userId`, `randCode`, `total`, `cash`, `discount`, `date`, `dateRegistered`, `time` , `status`)
                                             VALUES ( $adminId, $userId, $randCode, $total,$cash, $discount, '$date', '$TimeCheck', '$time', 0);";
                if ($conn->query($sql) === TRUE) {
                    $invoiceSalesId = $conn->insert_id;
                    while ($row = $reSQL->fetch_assoc()) {
                        $adminId = $row['adminId'];
                        $userId = $row['userId'];
                        $barcode = $row['barcode'];

                        $sql = "INSERT INTO `sales` (`randCode`, `adminId`, `userId`, `invoiceSalesId`, `barcode`, `status`) 
                                            VALUES ('$randCode',$adminId, '$userId',$invoiceSalesId, '$barcode', 1);";
                         $conn->query($sql);
                         UpdateStatusSQL ('stock' , 1 , 'barcode' ,$barcode );
                  }
                  
                $sql = "DELETE FROM temp_Sales where ( adminId = '$adminId' OR userId = '$userId'  ) AND randCode = $randCode";
                $conn->query($sql);
                $status = 200;
                $message = 'done';
            } 

         }

    }
     
   $checkInfoUser = checkInfoUser ($adminId , $userId) ;
    

    echo json_encode([
        'status' => $status,
        'invoiceSalesId' => $invoiceSalesId,
        'total' => $total,
        'cash' => $cash,
        'discount' => $discount,
        'date' => $date,
        'msg' => $message,
        'errors' => $errorsSql ,
        'checkInfoUser' => $checkInfoUser['message']
    ]);
    $conn->close();
} else {
    $msg = 'You do not have permission to view the content';
    echo json_encode(['status' => 'You do not have powers', 'msg' => $msg]);
}
