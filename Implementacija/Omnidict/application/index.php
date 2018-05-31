<?php
    /**
     * @author Stefan
     *
     */

    /**
     * Iz url-a, odnosno get niza izvlaci promjenljive kontroler i action
     */
     if (isset($_GET['controller']) && isset($_GET['action'])){
         $controller = $_GET['controller'];
         $action = $_GET['action'];
     }
     else{
         $controller = 'home';
         $action = 'index';
     }
     
     require_once 'routes.php';
     
?>