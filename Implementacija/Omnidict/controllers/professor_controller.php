<?php

/**
 * @author Stefan
 *
 */

class ProfessorController{
    
    function __construct(){
        session_start();
    }
    
    function index(){
        require_once 'views/layout.php';
    }
}

?>
