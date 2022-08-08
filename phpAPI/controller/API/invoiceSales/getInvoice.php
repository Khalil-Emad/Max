<?php
// session_start();
include '../../../controller/function.php';
include '../../../controller/security-ajax.php';
$conn = db($db);
$id = 1 ;

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $data[] = null;
    if (isset($_POST['adminId']) ) {
        $checkAdminId = checkAdminId ();
        $message= $checkAdminId['message'];
        $code= $checkAdminId['code'];
        $status= $checkAdminId['status'];
        $adminId= $checkAdminId['adminId'];
        $userId= $checkAdminId['userId'];
        
        // $categoryId =  filter_var($_POST['categoryId'], FILTER_SANITIZE_STRING);

        $category = "SELECT id FROM `invoiceSales` ORDER BY `id` DESC";
        $reSQL = $conn->query($category);
        if ($reSQL->num_rows > 0) {
            $data = $reSQL->fetch_assoc();
            $id = $data['id'] + 1;
        }
    }
echo json_encode([
    'salesInvoiceId' => "$id" ,
    'randCode' => randCodeInvoiceSales()
]);
$conn->close();

}

