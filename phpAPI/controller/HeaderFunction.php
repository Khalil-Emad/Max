<?php 
  function error_page($msg) {
    $style = '<style>
    html, body {
    height: 100%;
  }
  body {
    display: -webkit-flex;
    display: -ms-flexbox;
    display: flex;
    -webkit-align-items: center;
        -ms-flex-align: center;
            align-items: center;
    -webkit-justify-content: center;
        -ms-flex-pack: center;
            justify-content: center;
  }
  
  .spinner {
    -webkit-animation: rotator 1.4s linear infinite;
            animation: rotator 1.4s linear infinite;
  }
  
  @-webkit-keyframes rotator {
    0% {
      -webkit-transform: rotate(0deg);
              transform: rotate(0deg);
    }
    100% {
      -webkit-transform: rotate(270deg);
              transform: rotate(270deg);
    }
  }
  
  @keyframes rotator {
    0% {
      -webkit-transform: rotate(0deg);
              transform: rotate(0deg);
    }
    100% {
      -webkit-transform: rotate(270deg);
              transform: rotate(270deg);
    }
  }
  .path {
    stroke-dasharray: 187;
    stroke-dashoffset: 0;
    -webkit-transform-origin: center;
        -ms-transform-origin: center;
            transform-origin: center;
    -webkit-animation: dash 1.4s ease-in-out infinite, colors 5.6s ease-in-out infinite;
            animation: dash 1.4s ease-in-out infinite, colors 5.6s ease-in-out infinite;
  }
  
  @-webkit-keyframes colors {
    0% {
      stroke: #4285F4;
    }
    25% {
      stroke: #DE3E35;
    }
    50% {
      stroke: #F7C223;
    }
    75% {
      stroke: #1B9A59;
    }
    100% {
      stroke: #4285F4;
    }
  }
  
  @keyframes colors {
    0% {
      stroke: #4285F4;
    }
    25% {
      stroke: #DE3E35;
    }
    50% {
      stroke: #F7C223;
    }
    75% {
      stroke: #1B9A59;
    }
    100% {
      stroke: #4285F4;
    }
  }
  @-webkit-keyframes dash {
    0% {
      stroke-dashoffset: 187;
    }
    50% {
      stroke-dashoffset: 46.75;
      -webkit-transform: rotate(135deg);
              transform: rotate(135deg);
    }
    100% {
      stroke-dashoffset: 187;
      -webkit-transform: rotate(450deg);
              transform: rotate(450deg);
    }
  }
  @keyframes dash {
    0% {
      stroke-dashoffset: 187;
    }
    50% {
      stroke-dashoffset: 46.75;
      -webkit-transform: rotate(135deg);
              transform: rotate(135deg);
    }
    100% {
      stroke-dashoffset: 187;
      -webkit-transform: rotate(450deg);
              transform: rotate(450deg);
    }
  }
    </style>
    <svg class="spinner" width="65px" height="65px" viewBox="0 0 66 66" xmlns="http://www.w3.org/2000/svg">
     <circle class="path" fill="none" stroke-width="6" stroke-linecap="round" cx="33" cy="33" r="30"></circle>
  </svg>';
  
    echo $style . $msg;
    echo '<script> goBack() </script>';
  
    exit;
  }



function siteName() {
  $conn = db (IsConn);
  $usersSQL = "SELECT `nameWeb`  FROM `settings` WHERE id = 1 ";
  $usersRE = $conn->query($usersSQL);
  if ($usersRE->num_rows > 0) {
   $users = $usersRE->fetch_assoc();
    return $users['nameWeb'];
  }
  return 'Meydan Masr';
} 



  
  function lastSenOne($diff) {
    $lastSen = null ;
    if ($diff->y > 0) {
      $lastSen .= $diff->y.'سنة ';
    }
    if ($diff->m > 0) {
      $lastSen .= $diff->m.' شهر ';
    }
    if ($diff->d > 0) {
      $lastSen .=  $diff->d.' يوم ';
    }
    if ($diff->h > 0) {
      $lastSen .=  $diff->h.' ساعة ';
    }

    if ($diff->i > 0) {
      $lastSen .=  $diff->i.' دقيقة ';
    }

    if ($diff->s > 0) {
  //    $lastSen .=  $diff->s.' ثانية ';

    }
    return $lastSen;
  }  

  function lastSen($date) {
    $datetime1 = new DateTime(date('Y-m-d H:i:s', $date));
    $datetime2 = new DateTime(date('Y-m-d H:i:s'));
    $lastSen = '';
    $diff = $datetime1->diff($datetime2);
    return lastSenOne($diff);
  }

  


 function DateBetween($One , $two ) {
  $date1_ts = strtotime($One);
  $date2_ts = strtotime($two);
  $diff = $date2_ts - $date1_ts;
  return round($diff / 86400);
//   $datetime1 = new DateTime($One);
//   $datetime2 = new DateTime($two);
//   $difference = $datetime1->diff($datetime2);
//  return $difference->d ;
 }


function arabicDate($time) {
  $months = ["Jan" => "يناير", "Feb" => "فبراير", "Mar" => "مارس", "Apr" => "أبريل", "May" => "مايو", "Jun" => "يونيو", "Jul" => "يوليو", "Aug" => "أغسطس", "Sep" => "سبتمبر", "Oct" => "أكتوبر", "Nov" => "نوفمبر", "Dec" => "ديسمبر"];
  $days = ["Sat" => "السبت", "Sun" => "الأحد", "Mon" => "الإثنين", "Tue" => "الثلاثاء", "Wed" => "الأربعاء", "Thu" => "الخميس", "Fri" => "الجمعة"];
  $am_pm = ['AM' => 'صباحاً', 'PM' => 'مساءً'];

  $day = $days[date('D', $time)];
  $month = $months[date('M', $time)];
  $am_pm = $am_pm[date('A', $time)];
  $date = $day . ' ' . date('d', $time) . ' - ' . $month . ' - ' . date('Y', $time) . '   ' . date('h:i', $time) . ' ' . $am_pm;
  $numbers_ar = ["٠", "١", "٢", "٣", "٤", "٥", "٦", "٧", "٨", "٩"];
  $numbers_en = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

  return str_replace($numbers_en, $numbers_ar, $date);
}




function wordFilter($name ) {
  $conn = db (IsConn);
  $sql = "SELECT id FROM `wordFilter` WHERE where name ='$name'";
  $RE = $conn->query($sql);
  if ($RE->num_rows > 0) {
    return true ;
    }else {
    return false;
  } 
}

    function checkWordFilter($txt) {
      $tx_filter = filter_var($txt, FILTER_SANITIZE_STRING);
      $wordFilter = explode(" ", $tx_filter);
      foreach ($wordFilter as $word) {
        $name = trim($word);
        if (wordFilter($name) == true) {
          return true;
          break;
        } else {
          return false;
        }
      }
    }