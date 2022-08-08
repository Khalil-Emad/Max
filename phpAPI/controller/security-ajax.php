<?php 
if(isset($_REQUEST['g-recaptcha-response'])){
	unset($_REQUEST['g-recaptcha-response']);
}

if(isset($_REQUEST['hiddenRecaptcha'])){
	unset($_REQUEST['hiddenRecaptcha']);
}

if(isset($_REQUEST['form_botcheck'])){
	unset($_REQUEST['form_botcheck']);
}

if(isset($_REQUEST['PHPSESSID'])){
	unset($_REQUEST['PHPSESSID']);
}

if(isset($_REQUEST['timezone'])){
	unset($_REQUEST['timezone']);
}

if(isset($_REQUEST['cpsession'])){
	unset($_REQUEST['cpsession']);
}

if(isset($_REQUEST['lang'])){
	unset($_REQUEST['lang']);
}  

if(isset($_REQUEST['googtrans'])){
	unset($_REQUEST['googtrans']);
}  

if(isset($_REQUEST['admin_login'])){
	unset($_REQUEST['admin_login']);
}  

if(isset($_REQUEST['G_ENABLED_IDPS'])){
	unset($_REQUEST['G_ENABLED_IDPS']);
}  

if(isset($_REQUEST['pos_login'])){
	unset($_REQUEST['pos_login']);
}  
?>