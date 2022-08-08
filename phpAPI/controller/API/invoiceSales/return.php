<?php
// session_start();

use JetBrains\PhpStorm\Internal\ReturnTypeContract;

if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['adminId']))  {
    include '../../../controller/function.php';
    include '../../../controller/security-ajax.php';
    $conn = db($db);
    $sales = 0 ;
    $messageAr = '';
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
        
    $returnCase = 1 ;

    

        if (!filter_var($_POST['invoiceSalesId'], FILTER_SANITIZE_STRING)) {
            $message = 'You have not added an invoice Sales Id';
            $code = 2;
            $status = 1;
        } else {
                $invoiceSalesId = filter_var($_POST['invoiceSalesId'], FILTER_SANITIZE_STRING);
                $invoiceSales = "SELECT * FROM `invoiceSales` where ( adminId = '$adminId' OR userId = '$userId'  ) AND  id = $invoiceSalesId";
                $reSQL = $conn->query($invoiceSales);
                if ($reSQL->num_rows > 0) {
                    $DataInvoice = $reSQL -> fetch_all(MYSQLI_ASSOC);
                     $status = 0;
                    $barCodeArray[] = 0;
                    $getStock[] = 0;
                $sql = "SELECT barcode FROM sales where invoiceSalesId =  $invoiceSalesId ";
                $result = $conn->query($sql);
                if ($result->num_rows > 0) {
                        $sales = $result -> fetch_all(MYSQLI_ASSOC);
                        $status = 200;
                        $count = count($sales); 
                  
                        for ($i=0; $i < $count ; $i++) { 
                            $barCodeArray[$i] =  $sales[$i]["barcode"] ;
                            $getStock[$i] = getStock($barCodeArray[$i]) ;
                            
                            // if (@$_POST['returnCase'] == 1) {
                                $xbarcode =  $sales[$i]["barcode"]  ;
                                UpdateStatusSQL ('stock' , 3 , 'barcode' ,$xbarcode );
                                $message = 'Invoice returned';
                                $messageAr = 'تم إرجاع الفاتورة';
                                $status = 200;
                            // }
                        }
                      
                }
            
           }  
    }

    // if (@$_POST['returnCase'] == 1) { 
        UpdateStatusSQL ('sales' , 3 , 'invoiceSalesId' ,$invoiceSalesId );
        UpdateStatusSQL ('invoiceSales' , 3 , 'id' ,$invoiceSalesId );
    // }
        // $categoryId =  filter_var($_POST['categoryId'], FILTER_SANITIZE_STRING);

        if ($message == null) {
            $message = 'data Return';
        }


echo json_encode([
    // 'returnCase' =>@$_POST['returnCase'],
    'msg' => $message,
    'msgAr' => $messageAr,
    'status' => $status
    // 'DataInvoice' => $DataInvoice,
    // 'DataSales' => $getStock,
    // 'invoiceSalesId' => $invoiceSalesId,
    
]);

$conn->close();

}
