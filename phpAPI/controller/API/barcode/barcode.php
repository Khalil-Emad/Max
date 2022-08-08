
<?php
// session_start();
include '../../../controller/function.php';
include '../../../controller/security-ajax.php';
$conn = db($db);
if ($_SERVER['REQUEST_METHOD'] == 'POST' ) {

        $status = 0;
        $code = 0;
        $message = null;
        $urlImg = '../upload/';
            
    if (!filter_var($_POST['barcode'], FILTER_SANITIZE_STRING)) {
        $message ='You have not added an barcode';
        $code = 1;
        $status = 1;
    } else {
        $barcodeName = filter_var($_POST['barcode'], FILTER_SANITIZE_STRING);
      $barcodeName =  trim($barcodeName);
    }
  
    if ($status == 0) {
        $sql = "SELECT barcode FROM  `stock` where img = 'default.jpg' AND  `barcode` =  '$barcodeName'  ";
$result = $conn->query($sql);
if ($result->num_rows == 0) {
    $code = 200;
    $message = 'uploaded';
} else {
    $file =  explode("data:image/png;base64,",$_POST["barcodeBase64"]);
    $urlImg = rand_set().'-barcode-'.$barcodeName.'.png';
    $file = base64_decode($file[1]);
    $url = '../upload/'.$urlImg;
    file_put_contents($url,$file);
    $sql = "UPDATE `stock` SET `img` = '$urlImg' WHERE `barcode` =  '$barcodeName' ";
    if ($conn->query($sql) === TRUE) {
    $code = 200;
    $message = 'uploads done';
} else {
    $code = 20;
    $message = 'sql errors Update ';
}}

    }
    echo json_encode(['status' => $code ,
    'msg' => $message ,
    'imgUrl' => $urlImg
]);    
$conn->close();

}





