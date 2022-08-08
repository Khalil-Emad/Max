<?php
// session_start();
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['adminId']))  {
    include '../../../controller/function.php';
    include '../../../controller/security-ajax.php';
    $conn = db($db);
    $invoicePurchasesId = 0 ;
    $DataInvoice = [] ;
    $DataPurchases = [] ;
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
      
                $DataInvoiceStatus = $DataInvoice[0]['status'];
                if ($DataInvoiceStatus == 3 ) {
                $status = 100 ;
                $message = 'Invoice and stock returned';
                }

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

            if (isset($_POST['returnCase']) == 1) {
                $returnCase = 1 ;
            }else {
                $returnCase = 0 ;
            }
            
        if ($status == 200 && @$_POST['returnCase'] == 1) {
            UpdateStatusSQL ('invoicePurchases' , 2 , 'id' ,$invoicePurchasesId );
            UpdateStatusSQL ('stock' , 2 , 'invoicePurchasesId' ,$invoicePurchasesId );
            $message = 'Invoice and stock returned';
            $status = 200;
        }
     
        // $categoryId =  filter_var($_POST['categoryId'], FILTER_SANITIZE_STRING);




echo json_encode([
    'msg' => $message,
    'status' => $status,
    'DataInvoice' => $DataInvoice,
    'DataPurchases' =>$DataPurchases
]);

$conn->close();

}
