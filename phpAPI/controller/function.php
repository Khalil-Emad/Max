    <?php
    session_start();
    date_default_timezone_set('Africa/Cairo');
    //if (!isset($view_head) ) {  echo 'You do not have permission to view the content';  exit ; } 
    include_once 'conn.php';
    include_once 'HeaderFunction.php';
    define('NameSite',siteName());
    function validateInput($data) {
      $data = trim($data);
      $data = stripslashes($data);
      $data = filter_var($data, FILTER_SANITIZE_STRING);
      $data = htmlspecialchars($data);
      return $data;
    }


    function checkSubCategoryId($subCategoryId) {
      $conn = db (IsConn);
      $subCategorySQL = "SELECT id FROM subCategory WHERE id LIKE '%$subCategoryId%' ";
      $RE = $conn->query($subCategorySQL);
      if ($RE->num_rows > 0) {
      return true ;
      }else {
      return false;
    } 
    }

    
    function getStatusStockType($adminId , $userId , $stockType) {
      $conn = db (IsConn);
      $data = NULL; 
      $sqlStore = "SELECT `status` FROM `storetype` WHERE ( adminId = '$adminId' OR userId = '$userId'  ) AND id = $stockType  ";
      $stmt = $conn->query($sqlStore);
      if ($stmt->num_rows > 0) {
        $data = $stmt -> fetch_all(MYSQLI_ASSOC);
      }
    return $data[0]['status'] ;
    }



    function checkSqlCategoryId($categoryId) {
      $conn = db (IsConn);
      $categorySql = "SELECT id FROM category WHERE id LIKE '%$categoryId%' ";
      $usersRE = $conn->query($categorySql);
      if ($usersRE->num_rows > 0) {
      return true ;
      }else {
      return false;
    } 
    }

    function checkModelCode($model) {
      $conn = db (IsConn);
      $modelSql = "SELECT id FROM `model` WHERE code = $model ";
      $usersRE = $conn->query($modelSql);
      if ($usersRE->num_rows > 0) {
        $data = $usersRE->fetch_assoc();
      return $data['id'] ;
      }else {
      return false;
    } 
    }

    function checkCity($city) {
      $conn = db (IsConn);
      $sql_email = "SELECT id FROM city WHERE id LIKE '%$city%' ";
      $usersRE = $conn->query($sql_email);
      if ($usersRE->num_rows > 0) {
      return true ;
      }else {
      return false;
    } 
    }


    function checkCountry($country) {
      $conn = db (IsConn);
      $sql_email = "SELECT id FROM country WHERE id LIKE '%$country%' ";
      $usersRE = $conn->query($sql_email);
      if ($usersRE->num_rows > 0) {
      return true ;
      }else {
      return false;
    } 
    }

    
    function checkModelInCategory($model ,$categoryId ) {
      $conn = db (IsConn);
      $sql_email = "SELECT code FROM `model` WHERE code = $model AND categoryId = $categoryId  ";
      $usersRE = $conn->query($sql_email);
      if ($usersRE->num_rows > 0) {
      return true ;
      }else {
      return false;
    } 
    }

    function checkRegion($region) {
      $conn = db (IsConn);
      $sql_email = "SELECT id FROM region WHERE id LIKE '%$region%' ";
      $usersRE = $conn->query($sql_email);
      if ($usersRE->num_rows > 0) {
      return true ;
      }else {
      return false;
    } 
    }

    function checkAdminId () {
      $conn = db (IsConn);
      $message = NULL;
      $code = 0;
      $status = 0;
      $userId = 0 ;
      $caseLogin = null ;

      if (!filter_var($_POST['adminId'], FILTER_SANITIZE_STRING)) {
        $message ='You have not added an adminId';
        $code = 16;
        $status = 1;
    } else {
        $adminId = filter_var($_POST['adminId'], FILTER_SANITIZE_STRING);
    }

    if (empty($_POST['caseLogin'])) {
      $message ='You have not added an case Login';
      $code = 17;
      $status = 1;
    } else {

      $caseLogin = filter_var($_POST['caseLogin'], FILTER_SANITIZE_STRING);
      if ($caseLogin == 'users') {

        $SQLmobile = "SELECT id , adminID FROM `users` WHERE id = $adminId ";
        $stmt = $conn->query($SQLmobile);
        if ($stmt->num_rows > 0) {
          $data = $stmt->fetch_assoc();
          $adminId =$data['adminID'];
          $userId =$data['id'];
          }else {
          $message = 'This users is not registered';
          $code = 100;
          $status = 1;
        }
      }else {
        if (isset($adminId)) {
          $SQLmobile = "SELECT id FROM `admin` WHERE id = $adminId ";
          $stmt = $conn->query($SQLmobile);
          if ($stmt->num_rows == 0) {
              $message = 'This admin is not registered';
              $code = 100;
              $status = 1;
          }
      }
      }

    }



    return array (
        'message' => $message , 'code' => $code ,
        'caseLogin' => $caseLogin ,
        'status' => $status ,'adminId'=>$adminId , 'userId'=>$userId
    ) ;

    }

    function checkCategoryId () {
      $message = NULL;
      $code = 0;
      $status = 0;

      if (!filter_var($_POST['categoryId'], FILTER_SANITIZE_STRING)) {
        $message ='You have not added an categoryId';
        $code = 16;
        $status = 1;
    } else {
        $categoryId = filter_var($_POST['categoryId'], FILTER_SANITIZE_STRING);
    }


    if (checkSqlCategoryId($categoryId) != true) {
      $message = 'This categoryId is not registered';
      $code = 100;
      $status = 1;
    }
    return array ('message' => $message , 'code' => $code , 'status' => $status , 'categoryId'=>$categoryId ) ;

    }

    function checkModel () {
      $message = NULL;
      $code = 0;
      $status = 0;

      if (!filter_var($_POST['model'], FILTER_SANITIZE_STRING)) {
        $message ='You have not added an model';
        $code = 16;
        $status = 1;
    } else {
        $model = filter_var($_POST['model'], FILTER_SANITIZE_STRING);
    }


    if (checkModelCode($model) != true) {
      $message = 'This model Code is not registered';
      $code = 100;
      $status = 1;
    }
    return array ('message' => $message , 'code' => $code , 'status' => $status , 
    'modelCode'=>$model  , 'modelId' =>checkModelCode($model)) ;

    }


     function tempPurchasesSum ($table = 'temp_purchases' ,  $invoicePurchasesId ,$randCode = null) {
      $conn = db (IsConn);
      $totalPurchasePrice = NULL;
      $totalSalePrice = 0;
      $sql = "SELECT SUM(salePrice) AS totalSalePrice  ,  SUM(purchasePrice) AS totalPurchasePrice  FROM `$table`  ";
      if (isset($invoicePurchasesId)) {
          $sql .='where invoicePurchasesId ='.$invoicePurchasesId;
      }

      if (isset($randCode) != null) {
        $sql .=' AND randCode ='."'$randCode'";;
    }

      // echo $sql ;
      $reSQL = $conn->query($sql);
      if ($reSQL->num_rows > 0) {
        $data = $reSQL->fetch_assoc();
        $totalPurchasePrice = $data['totalPurchasePrice'];
        $totalSalePrice = $data['totalSalePrice'];
      }
    return array ('totalSalePrice' => $totalSalePrice , 'totalPurchasePrice' => $totalPurchasePrice ) ;
     }


     function tempSalesSum ($table = 'temp_Sales' ,$randCode = null) {
      $conn = db (IsConn);
      $price = 0;

      $sql = "SELECT SUM(price) AS price  FROM `$table`  ";
  

      if (isset($randCode) != null) {
        $sql .=' where randCode ='."'$randCode'";;
    }      // echo $sql ;
      $reSQL = $conn->query($sql);
      if ($reSQL->num_rows > 0) {
        $data = $reSQL->fetch_assoc();
        $price = $data['price'];
      }
    return array ('total' => $price ) ;
     }


    function deletedSql ($idData , $table) {
      $conn = db (IsConn);
      $message = NULL;
      $code = 0;
      $status = 0;

      $sql = "SELECT id , active   FROM `$table` where id = $idData  ";
      $reSQL = $conn->query($sql);
      if ($reSQL->num_rows > 0) {
      $data = $reSQL->fetch_all();
      // var_dump($data);
      $userId = $data[0][0] ;
      $deletedCase = $data[0][1] ;

      if($deletedCase == 0 ) {

      $message = $table . 'disabled successfully';
      $deleted = 1;
      }else {
          $message = $table . 'restored successfully';
          $deleted = 0;
      }
      $sql = "UPDATE `$table` SET active=$deleted WHERE id=$idData";
      $conn->query($sql);

    }else {
    $status =1;
    $message = 'The data is incorrect';
    }

    return array ('message' => $message , 'code' => $code , 'status' => $status) ;

    }


    function UpdateAdmin($user, $now, $status) {
      $conn = db (IsConn);
      $UpdateAdmin = "INSERT INTO `update-admin` (`username`, `time`, `status`) VALUES ('$user', '$now', '$status')";
      $stmt = $conn->query($UpdateAdmin);
    }


    function getUserIP() {
      $ip = '';
      if (isset($_SERVER['HTTP_CLIENT_IP']))
          $ip = $_SERVER['HTTP_CLIENT_IP'];
      else if(isset($_SERVER['HTTP_X_FORWARDED_FOR']))
          $ip = $_SERVER['HTTP_X_FORWARDED_FOR'];
      else if(isset($_SERVER['HTTP_X_FORWARDED']))
          $ip = $_SERVER['HTTP_X_FORWARDED'];
      else if(isset($_SERVER['HTTP_X_CLUSTER_CLIENT_IP']))
          $ip = $_SERVER['HTTP_X_CLUSTER_CLIENT_IP'];
      else if(isset($_SERVER['HTTP_FORWARDED_FOR']))
          $ip = $_SERVER['HTTP_FORWARDED_FOR'];
      else if(isset($_SERVER['HTTP_FORWARDED']))
          $ip = $_SERVER['HTTP_FORWARDED'];
      else if(isset($_SERVER['REMOTE_ADDR']))
          $ip = $_SERVER['REMOTE_ADDR'];
      else
          $ip = 'UNKNOWN';
      return $ip;
    }



    function rand_set() {
      $chars = array(0,1,2,3,4,5,6,7,8,9);
      $sn = '';
      $max = count($chars)-1;
      for($i=0;$i<4;$i++){
          $sn .= (!($i % 4) && $i ? '' : '').$chars[rand(0, $max)];
          }
          return $sn ;
    } 


    function randCode () {
      $conn = db (IsConn);
      $code = null ;

      reRandCode:
      $code .= rand(0,1000);
      $SQLmobile = "SELECT randCode FROM `stock` WHERE randCode = '$code' ";
      $stmt = $conn->query($SQLmobile);
      if ($stmt->num_rows > 0) {
        goto reRandCode;
      }

      return $code ;
    }

    
    function randCodeInvoiceSales () {
      $conn = db (IsConn);
      $code = null ;

      reRandCode:
      $code .= rand(0,1000);
      $SQLmobile = "SELECT randCode FROM `invoiceSales` WHERE randCode = '$code' ";
      $stmt = $conn->query($SQLmobile);
      if ($stmt->num_rows > 0) {
        goto reRandCode;
      }

      return $code ;
    }

    function checkRandCodeInvoiceSales ($code) {
      $conn = db (IsConn);
      $SQLmobile = "SELECT randCode FROM `temp_Sales` WHERE randCode = $code ";
      $stmt = $conn->query($SQLmobile);
      if ($stmt->num_rows > 0) {
        return true ;
      }else {
        return false ;
      }

    }

    function checkRandCode ($code) {
      $conn = db (IsConn);
      $SQLmobile = "SELECT randCode FROM `temp_purchases` WHERE randCode = '$code' ";
      $stmt = $conn->query($SQLmobile);
      if ($stmt->num_rows > 0) {
        return true ;
      }else {
        return false ;
      }

    }

    function checkStoreType ($storeId) {
      $conn = db (IsConn);
      $SQLmobile = "SELECT id FROM `storetype` WHERE id = '$storeId' ";
      $stmt = $conn->query($SQLmobile);
      if ($stmt->num_rows > 0) {
        return true ;
      }else {
        return false ;
      }

    }

    function UpdateStatusSQL ($table , $val , $whereSQL , $barcode ) {
      $conn = db (IsConn);
      $sql = "UPDATE `$table` SET status=$val WHERE $whereSQL='$barcode'";
      $conn->query($sql);
    } 

    function barcode ($model , $price ) {
      $conn = db (IsConn);
      $code = null ;
      $code = $model . '-' .$price ;

      reCode:
      $code .= '-'. rand(0,10000);
      $SQLmobile = "SELECT id FROM `stock` WHERE barcode = '$code' ";
      $stmt = $conn->query($SQLmobile);
      if ($stmt->num_rows > 0) {
        goto reCode;
      }

      return $code ;
    }

    function validate_phone_number($phone)
    {
        // Allow +, - and . in phone number
        $filtered_phone_number = filter_var($phone, FILTER_SANITIZE_NUMBER_INT);
        // Remove "-" from number
        $phone_to_check = str_replace("-", "", $filtered_phone_number);
        // Check the lenght of number
        // This can be customized if you want phone number from a specific country
        if (strlen($phone_to_check) < 10 || strlen($phone_to_check) > 14) {
            return false;
        } else {
          return true;
        }
    }

    function checkInfoUser ($adminId , $userId) {
      $conn = db (IsConn);
      $status = NULL;
      if (isset($_POST['name']) && isset($_POST['phone']) ) {
      $name = filter_var($_POST['name'], FILTER_SANITIZE_STRING);
      $phone = filter_var($_POST['phone'], FILTER_SANITIZE_STRING);

      $SQLmobile = "SELECT id FROM `client` WHERE  ( adminId = '$adminId' OR userId = '$userId'  ) `name` = '$name' AND  phone` = '$phone'  ";
      $stmt = $conn->query($SQLmobile);
      if ($stmt->num_rows > 0) {
        $status = 100;
        $message = 'already registered'  ;
      }else {
        $TimeCheck = strtotime("now");
        $sql = "INSERT INTO `client` ( `adminId`, `userId`, `name`, `phone`, `date`) VALUES ('$adminId', '$userId', '$name', '$phone', '$TimeCheck')";
        $conn->query($sql);
        $status =  200 ;
        $message = 'successfully registered'  ;

      }
      }else {
        $message ='You have not added name or phone ';
      }
    return array ( 'message' => $message , 'status' => $status ) ;
    }

    function getStock($barcode) {
      $conn = db (IsConn);
      $data =null ;
      $sqlStock = "SELECT  * , model.code AS modelCode  FROM `stock` 
      INNER JOIN category ON category.id=stock.categoryId 
      INNER JOIN model ON model.id=stock.modelId 
      where  barcode ='$barcode' " ;
    
       $result = $conn->query($sqlStock);
      if ($result->num_rows > 0) { 
      $data =  $result->fetch_assoc();
      unset($data["categoryId"]);
      unset($data["modelId"]);
      unset($data["adminId"]);
      unset($data["userId"]);
      unset($data["invoicePurchasesId"]);
      unset($data["img"]);
      unset($data["status"]);
      unset($data["code"]);
      } 
      return $data ;

    }

    
    function checkSpendingType ($adminId , $userId) {
      $conn = db (IsConn);
      $status = NULL;
      if (isset($_POST['name']) && isset($_POST['nameAr'])  ) {
      $name = filter_var($_POST['name'], FILTER_SANITIZE_STRING);
      $nameAr = filter_var($_POST['nameAr'], FILTER_SANITIZE_STRING);

      $SQLmobile = "SELECT id FROM `spendingType` WHERE  ( adminId = '$adminId' OR userId = '$userId'  ) `name` = '$name' AND nameAr = '$nameAr' ";
      $stmt = $conn->query($SQLmobile);
      if ($stmt->num_rows > 0) {
        $status = 100;
        $message = 'already registered'  ;
      }else {
        $TimeCheck = strtotime("now");
        $sql = "INSERT INTO `spendingType` ( `adminId`, `userId`, `name`, nameAr , `date`) VALUES ('$adminId', '$userId', '$name', '$nameAr', '$TimeCheck')";
        $conn->query($sql);
        $status =  200 ;
        $message = 'successfully registered'  ;

      }
      }else {
        $message ='You have not added name ';
      }
    return array ( 'message' => $message , 'status' => $status ) ;
    }
    

    function checkSpendingTypeId($adminId , $userId , $spendingTypeId) {
      $conn = db (IsConn);
      $message = NULL ;
      $SQLmobile = "SELECT   id , `status`  FROM `spendingType` WHERE ( adminId = '$adminId' OR userId = '$userId'  ) AND id = $spendingTypeId  ";
      $stmt = $conn->query($SQLmobile);
      if ($stmt->num_rows == 0) {
        $message = 'is Not before registered';
        $status = 1;
        }else {
         $dataSpending = $stmt->fetch_assoc();

        $status = 0 ;
        }
    return array ( 'message' => $message , 'status' => $status  , 'statusCse' => $dataSpending['status']  ) ;
    }

    function checkSpendingId($adminId , $userId , $spendingId) {
      $conn = db (IsConn);
      $message = NULL ;
      $SQLmobile = "SELECT  id , `status`  FROM `spending` WHERE ( adminId = '$adminId' OR userId = '$userId'  ) AND id = $spendingId  ";
      $stmt = $conn->query($SQLmobile);
      if ($stmt->num_rows == 0) {
        $message = 'is Not before registered';
        $status = 1;
        }else {
         $dataSpending = $stmt->fetch_assoc();
        $status = 0 ;
        }
    return array ( 'message' => $message , 'status' => $status , 'statusCse' => $dataSpending['status']   ) ;
    }


    function getSalesFromRandCode($adminId , $userId , $randCode) {
      $conn = db (IsConn);
      $sqlSales = "SELECT * FROM `sales` WHERE ( adminId = '$adminId' OR userId = '$userId'  ) AND randCode = '$randCode'  ";
      $stmt = $conn->query($sqlSales);
      if ($stmt->num_rows > 0) {
        $data = $stmt -> fetch_all(MYSQLI_ASSOC);
      }
    return $data ;
    }

    function getStockFromInvoicePurchasesId($adminId , $userId , $invoicePurchasesId) {
      $conn = db (IsConn);
      $data = NULL; 
      $sqlSales = "SELECT * FROM `stock` WHERE ( adminId = '$adminId' OR userId = '$userId'  ) AND invoicePurchasesId = '$invoicePurchasesId'  ";
      $stmt = $conn->query($sqlSales);
      if ($stmt->num_rows > 0) {
        $data = $stmt -> fetch_all(MYSQLI_ASSOC);
      }
    return $data ;
    }

    function getStockFromStatus($adminId , $userId , $status ,$between , $statusStockId = 0)  {
      $conn = db (IsConn);
      $data = []; 
      $sqlStockType = null ;

      if ($statusStockId != 0  ) {
        $sqlStockType = 'AND stock.storeId = '.$statusStockId;
      }
      $sqlSales = "SELECT DISTINCT stock.* , storetype.nameAr as  storeNameAr , storetype.nameEn as  storeNameEn , 
         category.categoryName , category.categoryNameAr , model.code AS codeModel FROM `stock`
       INNER JOIN storetype ON storetype.id=stock.storeId
       INNER JOIN category ON category.id=stock.categoryId
        INNER JOIN model ON model.id=stock.modelId  
       WHERE ( stock.adminId = '$adminId' OR stock.userId = '$userId'  ) AND stock.status = $status $between  $sqlStockType ";
      $stmt = $conn->query($sqlSales);
      if ($stmt->num_rows > 0) {
        $data = $stmt -> fetch_all(MYSQLI_ASSOC);
      }
      // echo $sqlSales ;
    return $data ;
    }

    function expectedProfit ($adminId , $userId  ,$between)  {
      $conn = db (IsConn);
      $data = []; 
  
      $client = "SELECT SUM(salePrice) AS totalSalePrice, SUM(purchasePrice) AS TotalPurchasePrice FROM `stock` WHERE  ( adminId = '$adminId' OR userId = '$userId'  ) and status = 0  or status = 3 $between";
        $reSQL = $conn->query($client);
        if ($reSQL->num_rows > 0) {
        $data = $reSQL->fetch_assoc(); 
        }
       $expectedProfit = $data['totalSalePrice'] - $data['TotalPurchasePrice']  ;

      if (empty($data['totalSalePrice'] )  ) {
        $data['totalSalePrice'] ="0";
      }

      if (empty($data['TotalPurchasePrice'] )  ) {
        $data['TotalPurchasePrice'] ="0";
      }

      
      if (empty($data['TotalPurchasePrice'] )  ) {
        $data['TotalPurchasePrice'] ="0";
      }
      
        return array (
          'totalSalePrice' => $data['totalSalePrice'] ,
          'totalPurchasePrice' => $data['TotalPurchasePrice'] ,
          'expectedProfit' => "$expectedProfit"
      ); 

    }

    function convertDateTime ( $set = 1 , $dataAPI = null) {
      $date = null ;
      $startDate = null ;
      $endDate = null ;
      $between = null ;
      $case = false ;
      $convertDate = NULL;
      $convertStartDate = NULL;
      $convertEndDate = NULL;
      $strtotime = NULL;
      $dataTime = "12:00";
      

    if (isset($_POST['startDate'])) {
      $startDate = date('d-m-Y',strtotime($_POST['startDate']));
      $convertStartDate = strtotime($startDate) ;
      
    } 

    if (isset($_POST['date'])) {
      $date = date('d-m-Y',strtotime($_POST['date']));
      $convertDate = strtotime($date) ;
      $dataTime = date("h:i:sa",strtotime($_POST['date']));
    } 

    if (isset($_POST['endDate'])) {
      $endDate = date('d-m-Y',strtotime($_POST['endDate']));
      $convertEndDate = strtotime($endDate) ;
    } 

    if ($startDate == $endDate && $startDate != null  && $endDate != null ) {
      $case = true ;
    }

    if ($case == true && $startDate != null) {
       $between = ' AND date = "'.$convertStartDate.'"';
    }

    if ($case == false && $startDate != null && $endDate != null ) {
      $between = ' AND `date` BETWEEN  "'.$convertStartDate.'" AND "'.$convertEndDate.'"   ';
    }

    $strtotime = strtotime($date);

    if ($set == 1) {
      $data = array (
        'between'=>$between ,
        'convertStartDate'=>$convertStartDate ,
        'convertEndDate'=>$convertEndDate ,
        'convertDate'=>$convertDate ,
        'date'=>$date ,
        'start'=>$startDate ,
        'end'=>$endDate ,
        'case'=>$case ,
        'dataTime'=>$dataTime ,
        'strtotime'=>$strtotime 
      );
    }else {
      $data = date('d-m-Y',strtotime($dataAPI));
    }

    return $data ;
  }