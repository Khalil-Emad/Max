<?php
// session_start();
include '../../../controller/function.php';
include '../../../controller/security-ajax.php';
$conn = db($db);
if ($_SERVER['REQUEST_METHOD'] == 'POST') {


        $case = null;
        $date = null;
        $purchases = [];
        $spending = [];
        $sales = [];

        
        $totalCount = 0 ;
        $totalPurchasesCount = 0 ;

        // $data[0]['totalSalesItemCount'] =  "0";
        // $data[0]['totalPurchasesCount'] =  "0";
        // $data[0]['inputTotal'] = "0";
        // $data[0]['outputTotal'] =  "0";
        // $data[0]['totalPurchases'] = "0";
        // $data[0]['totalSpending'] =  "0";
        // $data[0]['cash'] =  "0";

        $checkAdminId = checkAdminId ();
        $message= $checkAdminId['message'];
        $code= $checkAdminId['code'];
        $status= $checkAdminId['status'];
        $adminId= $checkAdminId['adminId'];
        $userId= $checkAdminId['userId'];
        $TimeCheck = strtotime("now");
        
        $convertDateTime = convertDateTime (); 
        $date = $convertDateTime['date'];
        $case = $convertDateTime['between'];
        $convertEndDate = $convertDateTime['convertEndDate'];
        $convertStartDate = $convertDateTime['convertStartDate'];
        $convertDate = $convertDateTime['convertDate'];
        
            $client = "SELECT *  FROM `invoicePurchases` WHERE  ( adminId = '$adminId' OR userId = '$userId'  ) $case";
           
            $re = $conn->query($client);
            if ($re->num_rows > 0) {
            $purchases = $re -> fetch_all(MYSQLI_ASSOC);

            $totalPurchasesCount = 0 ;
            @$count = count($purchases); 
            for ($i=0; $i < $count ; $i++) { 
                $purchases[$i]['transactionsType'] = 'purchases'; 
                $purchases[$i]['transactionsTypeAr'] = 'مشتريات'; 
                $invoicePurchasesId = $purchases[$i]['id'] ; 
                //  $convertDateTimePurchases =  convertDateTime (1 , $purchases[$i]['date']) ;
                $countItemPurchases = count(getStockFromInvoicePurchasesId($adminId , $userId , $invoicePurchasesId));
                $purchases[$i]['count'] = $countItemPurchases;  
                $purchases[$i]['totalCount'] =@$count;  
                $purchases[$i]['date'] =  date('d-m-Y', $purchases[$i]['date']);
                $totalPurchasesCount += $countItemPurchases ; 

                $purchases[$i]['item'] = getStockFromInvoicePurchasesId($adminId , $userId , $invoicePurchasesId) ;  
            }
          }
    

        $client = "SELECT SUM(cash) AS total FROM `invoicePurchases` WHERE  ( adminId = '$adminId' OR userId = '$userId'  ) $case";
        $reSQL = $conn->query($client);
        if ($reSQL->num_rows > 0) {
        $totalPurchases = $reSQL->fetch_assoc(); 
        }else {
            $totalPurchases['total'] = 0 ;
        }

        if (empty($convertStartDate) && empty($convertEndDate)) {
            $betweenSpending =  null ;
        }else if (isset($convertStartDate) && isset($convertEndDate) )  {
            $betweenSpending = ' AND spending.date BETWEEN  "'.$convertStartDate.'" AND "'.$convertEndDate.'"   ';
        }else if (isset($convertDate)) {
            $betweenSpending = ' AND spending.date ="'.$convertDate.'"';
        }else {
            $betweenSpending =  null ;
        }

        $client = "SELECT DISTINCT spending.* ,spendingType.name ,spendingType.nameAr   FROM `spending` 
        INNER JOIN spendingType ON spendingType.id=spending.spendingTypeId 
        WHERE  ( spending.adminId = '$adminId' OR spending.userId = '$userId'  ) $betweenSpending ";
        $re = $conn->query($client);
        if ($re->num_rows > 0) {
        $spending = $re -> fetch_all(MYSQLI_ASSOC);

        $count = count($spending); 
        for ($i=0; $i < $count ; $i++) { 
            $spending[$i]['date'] =  date('d-m-Y', $spending[$i]['date']); 
            $spending[$i]['transactionsType'] = 'spending';  
            $spending[$i]['transactionsTypeAr'] = 'المصاريف';  
        }
        }


    $client = "SELECT SUM(cash) AS total FROM `spending` 
    WHERE  ( adminId = '$adminId' OR userId = '$userId'  ) $case";
    $reSQL = $conn->query($client);
    if ($reSQL->num_rows > 0) {
    $totalSpending = $reSQL->fetch_assoc(); 
    }else {
   $totalSpending['total'] = 0 ;
        
    }

    $client = "SELECT *  FROM `invoiceSales` WHERE  ( adminId = '$adminId' OR userId = '$userId'  ) $case";
    $re = $conn->query($client);
    if ($re->num_rows > 0) {
    $sales = $re -> fetch_all(MYSQLI_ASSOC);

    $count = count($sales); 
    $totalCount = 0 ;
    for ($i=0; $i < $count ; $i++) { 
        $sales[$i]['transactionsType'] = 'sales';  
        $sales[$i]['transactionsTypeAr'] = 'مبيعات';  
        $randCodeSales = $sales[$i]['randCode'] ; 
        $countOne = count(getSalesFromRandCode($adminId , $userId , $randCodeSales));
        $sales[$i]['date'] =  date('d-m-Y', $sales[$i]['date']);
        $sales[$i]['count'] = $countOne;  
        $sales[$i]['totalCount'] = $count;  
        $totalCount += $countOne ; 
        $sales[$i]['item'] = getSalesFromRandCode($adminId , $userId , $randCodeSales);  

      
    }

    }
        
        $client = "SELECT SUM(cash) AS total FROM `invoiceSales` WHERE  ( adminId = '$adminId' OR userId = '$userId'  ) $case";
        $reSQL = $conn->query($client);
        if ($reSQL->num_rows > 0) {
        $totalSales = $reSQL->fetch_assoc(); 
        }else {
         $totalSales['total'] = 0 ;
        }




        if (empty($totalSales['total'] )  ) {
            $data[0]['inputTotal'] = "0";
        }else {
        $data[0]['inputTotal'] =  $totalSales['total'];
        }


        if (empty($totalSpending['total'] )  ) {
            $data[0]['totalSpending'] = "0";
        }else {
        $data[0]['totalSpending'] =  $totalSpending['total'];

        }

        if (empty($totalPurchases['total'] )  ) {
               $data[0]['totalPurchases'] ="0";
        }else {
            $data[0]['totalPurchases'] = $totalPurchases['total'];
        }

        $outputTotal =$totalPurchases['total']  + $totalSpending['total']  ;
        $cash = $totalSales['total'] - $outputTotal   ;
      
        if ($cash == 0) {
                $cash = "0" ;
        }

        if ($outputTotal == 0) {
            $outputTotal = "0" ;
     }

        $data[0]['totalSalesItemCount'] =  "$totalCount";
        $data[0]['totalPurchasesCount'] =  "$totalPurchasesCount";
        $data[0]['outputTotal'] =  "$outputTotal";
        $data[0]['cash'] =  "$cash";
        

        echo json_encode([
            'purchases'=>$purchases ,
            'spending'=>$spending ,
            'sales'=>$sales ,
            'data'=> $data , 
           'convertDateTime'=> convertDateTime (1 , $dataAPI = $date) , 
           
        ]);
    $conn->close(); 
    
}