<?php

session_start();
$connection = mysqli_connect('localhost', 'root', '', 'omnidict');
$lang_name = $_REQUEST['lang_name'];
$username = $_SESSION['username'];

// Za korisnika i naziv jezika selektuj jezik
$sqlRes = null;
$sql = "SELECT lang.languageId FROM language lang WHERE lang.user='".$username  ."' AND lang.name='".$lang_name."'";
$sqlRes = mysqli_query($connection, $sql);

$lanugages;
foreach ($sqlRes as $arr) {
    foreach ($arr as $lang) {
        $languages[] = $lang;
    }
}
$language = $languages[0];

// Za dati jezik selektuj sve tabele
$sql = "SELECT DISTINCT wt.word_type FROM wordTypeFrontendTable wt WHERE wt.language='" . $language . "'";
$sqlRes = null;
$sqlRes = mysqli_query($connection, $sql);

echo '<select id="editWordTypeOption" onchange="loadEditTable()">';
if ($sqlRes != null){
    foreach ($sqlRes as $tab){
        //echo $tab['word_type']. " ";
        //echo '<option>'.$tab['word_type'].'</option>';
        echo '<option>'.$tab['word_type'].'</option>';
    }
}
else echo 'nema';
echo '</select>';

mysqli_close($connection);