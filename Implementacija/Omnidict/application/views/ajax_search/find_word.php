<?php

$wordPiece = $_REQUEST['q'];

$connection = mysqli_connect('localhost', 'root', '', 'omnidict');
if (!$connection) {
    die('Could not connect: ' . mysqli_error($connection));
}

session_start();
if (!isset($_SESSION['username']))
    die('Nema sessije?!');
$username = $_SESSION['username'];

// Selektuj sve jezike za datog korisnika
$sql = "SELECT lang.languageId FROM language lang WHERE lang.user='" . $username . "'";
$sqlRes = mysqli_query($connection, $sql);

$lanugages;
foreach ($sqlRes as $arr) {
    foreach ($arr as $lang) {
        $languages[] = $lang;
    }
}


$hint = "";
// Tu se nalaze sve rijeci koje korisnik ima
$tables = null;
// Za svaki jezik selektuj sve rijeci (tabelu)
foreach ($languages as $lang) {
    $sql = "SELECT wt.word FROM wordtypefrontendtable wt WHERE wt.language='" . $lang . "'";
    $sqlRes = mysqli_query($connection, $sql);

    foreach ($sqlRes as $arr) {
        foreach ($arr as $tab) {
            $tables[] = $tab;
        }
    }
}
mysqli_close($connection);
// Ako ima rijeci u bazi
if ($tables != null) {
// Pronadji poklapanje
    if ($wordPiece !== "") {
        $wordPiece = strtolower($wordPiece);
        $len = strlen($wordPiece);
        // Za svaku tabelu uzmi po jednu rijec i uporedi sa $wordPiece
        foreach ($tables as $name) {
            if (stristr($wordPiece, substr($name, 0, $len))) {
                if ($hint === "") {
                    $hint = $name;
                } else {
                    $hint .= ", $name";
                }
            }
        }
    }
}

echo $hint === "" ? "nema predloga" : $hint;
?>
