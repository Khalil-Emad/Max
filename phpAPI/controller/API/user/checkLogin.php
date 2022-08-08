<?php
// session_start();
include '../../../controller/function.php';
include '../../../controller/security-ajax.php';
$conn = db($db);
if ($_SERVER['REQUEST_METHOD'] == 'POST') {

            $status = 0 ;
            $data = 0 ;
            $caseLogin = null ;
            $logged = 1 ;

        if ($status == 0) {

                $sql = "SELECT * FROM `admin` where logged = $logged  ORDER BY `id` DESC  LIMIT 1 " ;
                $stmt = $conn->query($sql);
                if ($stmt->num_rows > 0) {
                    $data = $stmt->fetch_assoc(); 
                    $status = 200 ; 
            $caseLogin = 'admin' ;
                }else {
                    $sql = "SELECT * FROM `users` where logged = $logged  ORDER BY `id` DESC  LIMIT 1 " ;
                    $stmt = $conn->query($sql);
                    if ($stmt->num_rows > 0) {
                $status = 200 ; 
                $caseLogin = 'users' ;

                        $data = $stmt->fetch_assoc(); 
                    }else {
                        $status = 100 ; 

                    }
                }

            }
            $data['caseLogin'] = $caseLogin;

echo json_encode(['status' => $status , 
'data' => $data ,
'caseLogin' => $caseLogin 
]);
// $conn->close();

}
