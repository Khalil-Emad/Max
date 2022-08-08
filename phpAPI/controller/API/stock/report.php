<?php

// session_start();
include '../../../controller/function.php';
include '../../../controller/security-ajax.php';
$conn = db($db);
if ($_SERVER['REQUEST_METHOD'] == 'POST') {


        $case = null;
        $date = 0;
        $zero =null;
        $one = [];
        $two =[];
        $three = [];
        $expectedProfit = [];
        $totalSpending = '';
        $totalPurchases = '';
        $checkAdminId = checkAdminId ();
        $message= $checkAdminId['message'];
        $code= $checkAdminId['code'];
        $status= $checkAdminId['status'];
        $adminId= $checkAdminId['adminId'];
        $userId= $checkAdminId['userId'];

   
            if ($status == 0) {

            if (isset($_POST['stockType'])) {
                $stockType = filter_var($_POST['stockType'], FILTER_SANITIZE_STRING);
                }else {
                    $stockType = 1 ;
                }
                $statusStockId =  $stockType ;
                // $statusStockId =  getStatusStockType($adminId , $userId , $stockType) ;
                // $convertDateTime = convertDateTime ();
                // $startDate = $convertDateTime['start'];
                // $endDate = $convertDateTime['end'];
                // $case = $convertDateTime['case'];
                $between = null;

                $zero = getStockFromStatus($adminId , $userId , 0 ,$between , $statusStockId) ;
                $one = getStockFromStatus($adminId , $userId , 1 ,$between, $statusStockId) ;
                $two = getStockFromStatus($adminId , $userId , 2 ,$between, $statusStockId) ;
                $three = getStockFromStatus($adminId , $userId , 3 ,$between, $statusStockId) ;
                $expectedProfit[0] = expectedProfit ($adminId , $userId  , $between, $statusStockId) ;
        }

        echo json_encode([
            'zero'=>$zero ,
            'one'=>$one ,
            'two'=>$two ,
            'three'=>$three ,
            'total' => $expectedProfit ,
            // 'startDate'=> $startDate , 
            // 'endDate'=> $endDate ,    
            'case'=> $case ,    
        ]);
    $conn->close(); 
    
}