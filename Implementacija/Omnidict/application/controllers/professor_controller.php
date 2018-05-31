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
        require_once 'application/views/layout.php';
    }
}

?>
