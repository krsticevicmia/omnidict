<?php
/**
 * @author Stefan
 */


if (isset($_SESSION['logedin']) && $_SESSION['logedin'] == true){
    // Iz $_SESSION niza izvlaciti naziv stranice na kojoj se nalzimo
    if (isset($_SESSION['contet']))
        require_once $_SESSION['content'];
}
else{
    require_once 'views/register.php';
}

?>