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
                    $DataInvoice[0]['date'] =  date('d-m-Y', $DataInvoice[0]['date']);

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
                        }
                      
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
    'DataSales' => $getStock,
    'invoiceSalesId' => $invoiceSalesId,
    
]);

$conn->close();

}
