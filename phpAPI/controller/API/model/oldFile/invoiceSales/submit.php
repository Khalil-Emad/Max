<?php
// session_start();
include '../../../controller/function.php';
include '../../../controller/security-ajax.php';
$conn = db($db);
// error(true);
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $data['totalPurchasePrice'] = null;
    $caseSql = "";
    $message = "";
    $invoicePurchasesId = 0;
    $errorsSql = false;

        $checkAdminId = checkAdminId();
        $message = $checkAdminId['message'];
        $code = $checkAdminId['code'];
        $status = $checkAdminId['status'];
        $adminId = $checkAdminId['adminId'];
        $userId = $checkAdminId['userId'];

        if (!filter_var($_POST['date'], FILTER_SANITIZE_STRING)) {
            $message = 'You have not added an date';
            $code = 2;
            $status = 1;
        } else {
            $date = strtotime($_POST['date']);
        }


        if (!filter_var($_POST['randCode'], FILTER_SANITIZE_STRING)) {
            $message = 'You have not added an randCode';
            $code = 2;
            $status = 1;
        } else {
            $randCode = filter_var($_POST['randCode'], FILTER_SANITIZE_STRING);
            if (checkRandCode($randCode) !== true) {
                $message = 'Invoice number is already registered';
                $code = 3;
                $status = 1;
            }
        }

        if (!filter_var($_POST['invoicePurchasesId'], FILTER_SANITIZE_STRING)) {
            $message = 'You have not added an invoice Purchases Id';
            $code = 2;
            $status = 1;
        } else {
            $invoicePurchasesId = filter_var($_POST['invoicePurchasesId'], FILTER_SANITIZE_STRING);
          
        }

        
        if ($status == 0) {
            $TimeCheck = strtotime("now");
            $tamp_purchasesCheck = "SELECT * FROM `temp_purchases` where ( adminId = '$adminId' OR userId = '$userId'  ) AND randCode = '$randCode'";
            $reSQL = $conn->query($tamp_purchasesCheck);
            if ($reSQL->num_rows == 0) {
                $message = 'rand Code code not registered';
                $code = 3;
            } else {
            $tempPurchasesSumInvoiceId = tempPurchasesSum($table = 'temp_purchases', $invoicePurchasesId ,$randCode);
            $data['totalSalePrice'] = $tempPurchasesSumInvoiceId['totalSalePrice'];
            $data['totalPurchasePrice'] = $tempPurchasesSumInvoiceId['totalPurchasePrice'];

            $total =  $tempPurchasesSumInvoiceId['totalPurchasePrice'];

                $sql = "INSERT INTO `invoicePurchases` ( `adminId`, `userId`, `randCode`, `total`, `cash`, `date`, dateRegistered , `status`) 
                VALUES ( '$adminId', $userId, '$randCode', '$total', '$total', '$date' ,'$TimeCheck' , 0 );";
                if ($conn->query($sql) === TRUE) {
                    $invoicePurchasesId = $conn->insert_id;
                    while ($row = $reSQL->fetch_assoc()) {
                        $categoryId = $row['categoryId'];
                        $modelId = $row['modelId'];
                        $adminId = $row['adminId'];
                        $userId = $row['userId'];
                        $salePrice = $row['salePrice'];
                        $purchasePrice = $row['purchasePrice'];
                        $size = $row['size'];
                        $color = $row['color'];
                        $barcode = $row['barcode'];
                        $sql = "INSERT INTO `purchases` (randCode , `categoryId`, `modelId`, `adminId`, `userId`, `invoicePurchasesId`, `img`, `salePrice`, `purchasePrice`, `size`, `color`, `status` , `barcode`) 
                        VALUES ('$randCode' , $categoryId, $modelId ,$adminId, $userId, $invoicePurchasesId,
                        'default.jpg', $salePrice, $purchasePrice, '$size', '$color', '1', '$barcode');";
                         $conn->query($sql);
                  }
                  
                $sql = "DELETE FROM temp_purchases where ( adminId = '$adminId' OR userId = '$userId'  ) AND randCode = '$randCode'";
                $conn->query($sql);
                $status = 200;
                $message = 'done';
            } 


           }

        
            }
        
    

    echo json_encode([
        'status' => $status,
        'invoicePurchasesId' => $invoicePurchasesId,
        'data' => $data,
        'msg' => $message,
        'errors' => $errorsSql
    ]);
    $conn->close();
} else {
    $msg = 'You do not have permission to view the content';
    echo json_encode(['status' => 'You do not have powers', 'msg' => $msg]);
}
