<?php
// session_start();
include '../../../controller/function.php';
include '../../../controller/security-ajax.php';
$conn = db($db);
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['adminId'])) {
    $data[] = "";
    $price = "" ;
    $status = 0 ;
    $message = "" ;
    $stock = "" ;
    $invoiceSalesId = "" ;
    $randCode = "" ;
    $category = "" ;
    
    $tempSalesSum['total'] = "" ;
        $checkAdminId = checkAdminId ();
        $message= $checkAdminId['message'];
        $code= $checkAdminId['code'];
        $status= $checkAdminId['status'];
        $adminId= $checkAdminId['adminId'];
        $userId= $checkAdminId['userId'];
        if (isset($_POST['barcode']) ) {
        $barcode  = trim(filter_var($_POST['barcode'], FILTER_SANITIZE_STRING));
        $category = "SELECT * , model.code AS modelCode  FROM `stock`
         INNER JOIN category ON category.id=stock.categoryId 
         INNER JOIN model ON model.id=stock.modelId 
        where ( stock.adminId = '$adminId' OR stock.userId = '$userId'  )   AND stock.barcode ='$barcode'
          AND ( stock.status = 0 OR stock.status = 3  )";
        //   echo $category ;
        //   exit;
        $stmt = $conn->query($category);
        if ($stmt->num_rows > 0) {
            $stock = $stmt->fetch_all(MYSQLI_ASSOC);

            // $stock = $stmt->fetch_assoc();
            $price =$stock[0]['salePrice'];
            $status = 1  ;
            unset($stock[0]["categoryId"]);
            unset($stock[0]["modelId"]);
            unset($stock[0]["adminId"]);
            unset($stock[0]["userId"]);
            unset($stock[0]["invoicePurchasesId"]);
            unset($stock[0]["img"]);
            unset($stock[0]["status"]);
            unset($stock[0]["code"]);
        }else {
                $status = 0  ;
                $message ='Unavailable Barcode ';
        }
    }

            
    if ($status == 1 && isset($_POST['invoiceSalesId']) && isset($_POST['randCode'])  ) {

        $randCode =  filter_var($_POST['randCode'], FILTER_SANITIZE_STRING);
        $invoiceSalesId =  filter_var($_POST['invoiceSalesId'], FILTER_SANITIZE_STRING);
   
        // $tamp_purchasesCheck = "SELECT * FROM `temp_Sales`  where ( adminId = '$adminId' OR userId = '$userId'  )
        // AND randCode = $randCode 
        // AND invoiceSalesId = $invoiceSalesId
        // AND barcode = '$barcode' ";
        // $reSQL = $conn->query($tamp_purchasesCheck);

        // echo $tamp_purchasesCheck ;
        // if ($reSQL->num_rows > 0) {
        //     $message ='already registered';
        //     $code = 3;
        // }else {
         $TimeCheck = strtotime("now");
        $sql = "INSERT INTO `temp_Sales` ( `randCode`, `adminId`, `userId`, `invoiceSalesId`, `price`, `barcode`, `status`, `date`) 
        VALUES ('$randCode', $adminId, $userId, $invoiceSalesId, $price, '$barcode', 1 , '$TimeCheck');";
        if ($conn->query($sql) === TRUE) {
            $last_id = $conn->insert_id;   
          $status = 200 ;
          $message ='done';
           }else {
            $status = 100 ;
            $message ='errors #1'; 
           }
        // }
        $tempSalesSum = tempSalesSum($table = 'temp_Sales' ,  $randCode  ) ;
    } 
    

    if (empty($tempSalesSum['total'])) {
        $tempSalesSum['total'] = "0";
    }

    
    if (empty($message)) {
        $message = "";
    }

echo json_encode([
    'tempSalesId'=>$last_id ,
    'randCode'=>$randCode ,
    'msg'=>$message ,
    'item'=>$stock ,
    'status'=>$status ,
    'total'=>$tempSalesSum['total']
                ]);
$conn->close();
    }