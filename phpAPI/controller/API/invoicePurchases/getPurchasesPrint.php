<?php
// session_start();
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['adminId']))  {
    include '../../../controller/function.php';
    include '../../../controller/security-ajax.php';
    $conn = db($db);
    $sales = 0 ;
    $barCode = '';
    $DataInvoice = [];
    $DataSales = [] ;
    $data[] = null;
  
    $checkAdminId = checkAdminId ();
    $message= $checkAdminId['message'];
    $code= $checkAdminId['code'];
    $status= $checkAdminId['status'];
    $adminId= $checkAdminId['adminId'];
    $userId= $checkAdminId['userId'];
   

    if (!filter_var($_POST['invoicePurchasesId'], FILTER_SANITIZE_STRING)) {
        $message = 'You have not added an invoice Purchases Id';
        $code = 2;
        $status = 1;
    } else {
            $invoicePurchasesId = filter_var($_POST['invoicePurchasesId'], FILTER_SANITIZE_STRING);
            $invoicePurchases = "SELECT * FROM `invoicePurchases` where ( adminId = '$adminId' OR userId = '$userId'  ) AND  id = $invoicePurchasesId";
            $reSQL = $conn->query($invoicePurchases);
            if ($reSQL->num_rows > 0) {
                $DataInvoice = $reSQL -> fetch_all(MYSQLI_ASSOC);
            $status = 0;
  
            $stock = "SELECT  * , model.code AS modelCode  FROM `stock` 
            INNER JOIN category ON category.id=stock.categoryId 
            INNER JOIN model ON model.id=stock.modelId 
            where ( stock.adminId = '$adminId' OR stock.userId = '$userId'  )
            AND stock.invoicePurchasesId = $invoicePurchasesId  ";
         
         $re = $conn->query($stock);
            if ($re->num_rows > 0) {
                $DataPurchases = $re -> fetch_all(MYSQLI_ASSOC);
                $count = count($DataPurchases); 
                for ($i=0; $i < $count ; $i++) { 
            //   $DataPurchases[$i]["date"] =  date('d - m - Y',$DataPurchases[$i]["date"]);
                unset($DataPurchases[$i]["categoryId"]);
                unset($DataPurchases[$i]["modelId"]);
                unset($DataPurchases[$i]["adminId"]);
                unset($DataPurchases[$i]["userId"]);
                unset($DataPurchases[$i]["invoicePurchasesId"]);
                unset($DataPurchases[$i]["img"]);
                unset($DataPurchases[$i]["status"]);
                unset($DataPurchases[$i]["code"]);
                }
               $message = '';
                $status = 200;
            }
       }     
}


        if ($message == null) {
            $message = 'returned';
        }


echo json_encode([
    'msg' => $message,
    'status' => $status,
    'DataInvoice' => $DataInvoice,
    'DataPurchases' => $DataPurchases,
    'invoicePurchasesId' => $invoicePurchasesId,
    
]);

$conn->close();

}
