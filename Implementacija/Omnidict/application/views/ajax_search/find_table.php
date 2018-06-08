<?php


$connection = mysqli_connect('localhost', 'root', '', 'omnidict');

session_start();

$request = $_REQUEST['lang'];
$username = $_SESSION['username'];

// Za naziv jezika i korisnika dovuci jezik
$sqlRes = null;
$sql = "SELECT lang.languageId FROM language lang WHERE lang.user='".$username  ."' AND lang.name='".$request."'";
$sqlRes = mysqli_query($connection, $sql);


$lanugages;
foreach ($sqlRes as $arr) {
    foreach ($arr as $lang) {
        $languages[] = $lang;
    }
}
$language = $languages[0];


// Za dati jezik selektuj sve tabele

$sql = "SELECT * FROM wordTypeFrontendTable wt WHERE wt.language='" . $language . "'";
$sqlRes = null;
$sqlRes = mysqli_query($connection, $sql);

// Zaglavlje
echo  '<table width="100%" id="tableDisplay">';
echo  '<th colspan="3" style=" height: 50px; background-color: lightgray ;">'. $request .'</th>';
// Elemetni tabele
if ($sqlRes != null){
    foreach ($sqlRes as $tab){
        echo '<tr>'
        . '<td id="cellDisplay">'.$tab['word_type'].'</td><td  id="cellDisplay">'.$tab['word'].
                '</td><td  id="cellDisplay">'.$tab['translation'].'</td>'
          . '</tr>';
    }
}
echo '</table>';
mysqli_close($connection);