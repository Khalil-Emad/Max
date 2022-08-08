<html>
<head>
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Barcode Printer</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script src="assets/JsBarcode.code128.min.js"></script>
  <script src="assets/print.min.js"></script>
  <script src="assets/jquery.min.js"></script>
  <!-- <script src="https://unpkg.com/jspdf@latest/dist/jspdf.min.js"></script> -->
      <!-- Bootstrap core CSS -->
<link href="assets/bootstrap.min.css" rel="stylesheet" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
    <!-- Custom styles for this template -->
    <link href="sticky-footer.css" rel="stylesheet">
<style>

.container {
  width: auto;
  max-width: 680px;
  padding: 0 15px;
}

.footer {
  background-color: #f5f5f5;
}
    </style>
</head>

<body class="d-flex flex-column h-100">
<?php
// session_start();
include '../../../controller/conn.php';
// include '../../../controller/security-ajax.php';
$conn = db($db);
if (isset($_GET['invoicePurchasesId'])) { 

  $status = 0;
  $barcode[] = null ;

  if (!filter_var($_GET['invoicePurchasesId'], FILTER_SANITIZE_STRING)) {
    $message = 'You have not added an invoice Purchases Id';
    $code = 2;
    $status = 1;
} else {
          $invoicePurchasesId = filter_var($_GET['invoicePurchasesId'], FILTER_SANITIZE_STRING);
          $invoicePurchases = "SELECT id FROM `invoicePurchases` where id = $invoicePurchasesId";
          $reSQL = $conn->query($invoicePurchases);
          if ($reSQL->num_rows > 0) {
          $stock = "SELECT salePrice , barcode  FROM `stock` where invoicePurchasesId = $invoicePurchasesId  ";
          $re = $conn->query($stock);
          if ($re->num_rows > 0) {
          $barcode = $re -> fetch_all(MYSQLI_ASSOC);
          $message = 'done';
          $status = 0;
        }else {
          $message = 'barcode not Found';
          $status = 1;
        }
   }else {
    $message = 'invoice Purchases Id not Found';
    $status = 1;
   }   
}
} 

    if ($status == 0) { ?>
    <!-- Begin page content -->
    <main role="main" class="flex-shrink-0">
  <div class="container">
    <h1 class="mt-5">Max </h1>
    <p class="lead">Barcode Printer invoice Purchases Id</p>

<div id="printable">
  <?php 
  foreach ($barcode as $code) {
   $codeArray =  $code['barcode'];
   $salePrice =  $code['salePrice'];
  echo '<img class="barcode_'.$codeArray.'" data-value="'.$codeArray.'"></img>';
        echo '<span class="pri_'.$codeArray.'"></span>'; 
  }
  echo ' </div>';
  ?>

  <div class="lod">
  <div class="spinner-grow text-success" role="status">
  <span class="sr-only">Loading...</span>
</div>
  </div>
  <button type="button" class="print_R btn btn-Success" onclick="printBarcode()">  Print barcode
  <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
  <span class="sr-only">Loading...</span>
</button>

  <script> 
   $('.lod').hide();
   setTimeout(function () {
    printBarcode();
                 }, 2500);

  <?php 
  foreach ($barcode as $code) {
   $codeArray =  $code['barcode']; ?>
    JsBarcode(".barcode_<?=$codeArray?>", "<?=$codeArray?>", {
    width: 1,
    height: 30,
    textAlign: "left",
    fontOptions: "bold",
    margin: 10,
    fontSize: 20
  })

  barcodeBase64 = $('.barcode_<?=$codeArray?>').attr('src');
  $('.pri_<?=$codeArray?>').append('<?$salePrice?>');
  barcode = "<?=$codeArray?>";
  insertImg (barcode , barcodeBase64)

  
  <?php } ?>
 let barcodeSVGs = document.getElementsByClassName("barcode")
 function printBarcode() {
   $('.lod').show();
   $('.print_R').hide();
   let printFrame = document.createElement("iframe")
   let printableElement = document.getElementById("printable")
  
   printFrame.setAttribute("id", "printjs")
   printFrame.srcdoc = "" +
     printableElement.outerHTML + ""

   document.body.appendChild(printFrame)

   let iframeElement = document.getElementById("printjs")
   iframeElement.focus()
   iframeElement.contentWindow.print()

 }

function insertImg (barcode , barcodeBase64) {
    $.ajax({
                            url:"barcode.php",
                            method:"post",
                            data: {barcode , barcodeBase64} ,
                            success:function(data){
                                 console.log(data)
                            }
        });
 }
</script>
</div>
</main>

<footer class="footer mt-auto py-3">
  <div class="container">
    <span class="text-muted">CodeRoot Tame Development </span>
  </div>
</footer>
<?php } else {
 echo json_encode(['status' => $status, 'msg' => $message]);

} 