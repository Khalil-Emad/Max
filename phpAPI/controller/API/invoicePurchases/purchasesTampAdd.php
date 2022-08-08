<?php
// session_start();
include '../../../controller/function.php';
include '../../../controller/security-ajax.php';
$conn = db($db);
// error(true);
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $data[] = null;
    $id = 1 ;

    if (isset($_POST['adminId']) && isset($_POST['categoryId'])) {
    
        $checkAdminId = checkAdminId ();
        $message= $checkAdminId['message'];
        $code= $checkAdminId['code'];
        $status= $checkAdminId['status'];
        $adminId= $checkAdminId['adminId'];
        $userId= $checkAdminId['userId'];
        
        // if  ($status == 0 ) {
            $checkCategoryId = checkCategoryId ();
            $message= $checkCategoryId['message'];
            $code= $checkCategoryId['code'];
            $status= $checkCategoryId['status'];
            $categoryId= $checkCategoryId['categoryId'];
        // } 

        // if  ($status == 0 ) {
            $checkModel = checkModel ();
            $message= $checkModel['message'];
            $modelCode= $checkModel['modelCode'];
            $status= $checkModel['status'];
            $modelId= $checkModel['modelId'];
            
        // } 

        


        if (!filter_var($_POST['size'], FILTER_SANITIZE_STRING)) {
            $message ='You have not added an size';
            $code = 2;
            $status = 1;
        } else {
            $size = filter_var($_POST['size'], FILTER_SANITIZE_STRING);
        }

        if (!filter_var($_POST['color'], FILTER_SANITIZE_STRING)) {
            $message ='You have not added an color';
            $code = 2;
            $status = 1;
        } else {
            $color = filter_var($_POST['color'], FILTER_SANITIZE_STRING);
        }

        
        if (!filter_var($_POST['salePrice'], FILTER_SANITIZE_STRING)) {
            $message ='You have not added an salePrice';
            $code = 2;
            $status = 1;
        } else {
            $salePrice = filter_var($_POST['salePrice'], FILTER_SANITIZE_STRING);
        }

        if (!filter_var($_POST['purchasePrice'], FILTER_SANITIZE_STRING)) {
            $message ='You have not added an purchasePrice';
            $code = 2;
            $status = 1;
        } else {
            $purchasePrice = filter_var($_POST['purchasePrice'], FILTER_SANITIZE_STRING);
        }
        if (!filter_var($_POST['invoicePurchasesId'], FILTER_SANITIZE_STRING)) {
            $message ='You have not added an invoicePurchasesId';
            $code = 2;
            $status = 1;
        } else {
            $invoicePurchasesId = filter_var($_POST['invoicePurchasesId'], FILTER_SANITIZE_STRING);
        }
        

        if ($status == 0) {
            $TimeCheck = strtotime("now");
        $barcode = barcode ($modelCode , $purchasePrice ) ;
        $sql = "INSERT INTO `tamp_purchases` ( `categoryId`, modelId , `adminId`, `userId`, `invoicePurchasesId`, `img`, `salePrice`, `purchasePrice`, `size`, `color`, `status`, `date`, `barcode`) 
                                            VALUES ( $categoryId,  $modelId ,$adminId, $userId, $invoicePurchasesId, 'default.jpg', $salePrice, $purchasePrice, '$size', '$color', '1', '$TimeCheck', '$barcode');";
        $stmt = $conn->query($sql);
        if ($stmt->num_rows > 0) {
          $status = 200 ;
          $message ='done';
           }else {
            $status = 100 ;
            $message ='errors #1'; 
           }
        }
    }
    echo json_encode([
        'status' => $status,
        'sql' => $sql,
         'barcode' => $barcode 
        , 'modelId' => $modelId
        , 'msg' => $message
]);
    $conn->close();

} else {
$msg = 'You do not have permission to view the content';
echo json_encode(['status' => 'You do not have powers', 'msg' => $msg]);
}
