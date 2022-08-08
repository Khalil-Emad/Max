<?php
// session_start();
include '../../../controller/function.php';
include '../../../controller/security-ajax.php';
$conn = db($db);
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $data = [];
    $stock = [];
    if (isset($_POST['adminId']) && isset($_POST['model'])) {
        $checkAdminId = checkAdminId ();
        $message= $checkAdminId['message'];
        $code= $checkAdminId['code'];
        $status= $checkAdminId['status'];
        $adminId= $checkAdminId['adminId'];
        $userId= $checkAdminId['userId'];

        
        $model =  filter_var($_POST['model'], FILTER_SANITIZE_STRING);

        $category = "SELECT * FROM `model` where ( adminId = '$adminId' OR userId = '$userId'  )   AND code = '$model'  ";
        $stmt = $conn->query($category);
        if ($stmt->num_rows > 0) {
            $data = $stmt -> fetch_all(MYSQLI_ASSOC);
            $modeCode = $data[0]['id'];
            $sqlSales = "SELECT DISTINCT stock.* ,category.categoryName , category.categoryNameAr , model.code AS modelCode , 
             storetype.nameAr as  storeNameAr , storetype.nameEn as  storeNameEn FROM `stock`
            INNER JOIN category ON category.id=stock.categoryId 
            INNER JOIN storetype ON storetype.id=stock.storeId 
             INNER JOIN model ON model.id=stock.modelId
             WHERE ( stock.adminId = '$adminId' OR stock.userId = '$userId'  )
              AND ( stock.status = 0  or  stock.status = 3 )  AND model.code = '$model' ";
           $stmt = $conn->query($sqlSales);
           if ($stmt->num_rows > 0) {
            $stock = $stmt -> fetch_all(MYSQLI_ASSOC);
          }

        }
    }
}

echo json_encode($stock);
$conn->close();
