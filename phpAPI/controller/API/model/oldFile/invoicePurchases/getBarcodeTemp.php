<?php
// session_start();
include '../../../controller/function.php';
include '../../../controller/security-ajax.php';
$conn = db($db);
// error(true);
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // $data[] = null;
    $last_id = "" ;
    $tampId = ""; 
    $barcode = "" ;
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

        
        if (checkModelInCategory($modelCode ,$categoryId )  == false) {
            $message ='The model is not related to the category';
            $code = 2;
            $status = 1;
        }

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

        if (!filter_var($_POST['randCode'], FILTER_SANITIZE_STRING)) {
            $message ='You have not added an randCode';
            $code = 2;
            $status = 1;
        } else {
            $randCode = filter_var($_POST['randCode'], FILTER_SANITIZE_STRING);
        }
        

        if ($status == 0) {

            $tamp_purchasesCheck = "SELECT * FROM `temp_purchases` where ( adminId = '$adminId' OR userId = '$userId'  ) AND categoryId = $categoryId
            AND modelId = $modelId AND salePrice = $salePrice AND purchasePrice = $purchasePrice AND size = $size 
            AND color = '$color' 
            AND randCode = '$randCode' ";
            $reSQL = $conn->query($tamp_purchasesCheck);
            if ($reSQL->num_rows > 0) {
                $message ='Stock is already registered';
                $code = 3;
            }else {
                $TimeCheck = strtotime("now");
                $barcode = barcode ($modelCode , $purchasePrice ) ;
            $sql = "INSERT INTO `temp_purchases` ( `categoryId`, randCode , modelId , `adminId`, `userId`, `invoicePurchasesId`, `img`, `salePrice`, `purchasePrice`, `size`, `color`, `status`, `date`, `barcode`) 
                                                VALUES ( $categoryId, $randCode , $modelId ,$adminId, $userId, $invoicePurchasesId, 'default.jpg', $salePrice, $purchasePrice, '$size', '$color', '1', '$TimeCheck', '$barcode');";
            if ($conn->query($sql) === TRUE) {
                $last_id = $conn->insert_id;   
              $status = 200 ;
              $message ='done';
               }else {
                $status = 100 ;
                $message ='errors #1'; 
               }
            }


        }
    }
    $tempPurchasesSumInvoiceId = tempPurchasesSum ($table = 'temp_purchases' , $invoicePurchasesId ,$randCode);

      
        $data['tampId'] = "$last_id" ;
        $data['barcode'] = $barcode ;
        $data['totalSalePrice'] = $tempPurchasesSumInvoiceId['totalSalePrice'];
        $data['totalPurchasePrice'] = $tempPurchasesSumInvoiceId['totalPurchasePrice'] ;
        $data['modelId'] = $modelId ;

    
    echo json_encode([
        'status' => $status,
        'data' => $data,
        'randCode' => $randCode,
         'msg' => $message
]);
    $conn->close();

} else {
$msg = 'You do not have permission to view the content';
echo json_encode(['status' => 'You do not have powers', 'msg' => $msg]);
}
