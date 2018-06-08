<?php

session_start();
$connection = mysqli_connect('localhost', 'root', '', 'omnidict');
$lang_name = $_REQUEST['lang_name'];
$word_type = $_REQUEST['word_type'];
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

// Za jezik i word_type selektuj sve rijeci
$sqlRes = null;
$sql = "SELECT * FROM wordTypeFrontendTable wt WHERE wt.language='".$language."' AND wt.word_type='" .$word_type."'";
$sqlRes = mysqli_query($connection, $sql);



echo '<table id="tableDisplay" width="90%">';
echo '<th id="headerDisplay" colspan="2">'.$word_type.'</th>';
if ($sqlRes != null){
    foreach ($sqlRes as $tab){
        echo '<tr>'
        . '<td id="cellDisplay">'.$tab['word'].
                '</td><td  id="cellDisplay">'.$tab['translation'].'</td>'
          . '</tr>';
    }
}
echo '</table>';
