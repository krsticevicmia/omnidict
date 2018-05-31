<?php
/**
 * @author Stefan
 */

/**
 * Postavlja unutar layout-a u gornjem desnom uglu login formu ako niko nije ulogovan
 * odnosno korisnicko ime ako jeste
 */
if (isset($_SESSION['logedin']) && $_SESSION['logedin'] == true){
    require_once 'views/loged_in_user.php';
}
else{
    require_once 'views/login.php';
}

?>