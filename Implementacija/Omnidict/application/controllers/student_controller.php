<?php

/**
 * 
 */


class StudentController{
    
    function __construct(){
        session_start();
    }
    
    function index(){
        if (isset($_SESSION['user_type']) && $_SESSION['user_type'] == "s"){
            $_SESSION['content'] = 'application/views/student_content.php';;
        } else {
            header("Location: ?controller=home&action=error");
        }
        
         
        
        require_once 'application/views/layout.php';
    }
       function edit(){
        
        if (isset($_SESSION['user_type']) && $_SESSION['user_type'] == "s"){
            $_SESSION['content'] = 'application/views/edit_page.php';
        } else {
            header("Location: ?controller=home&action=error");
        }
        
        require_once 'application/views/layout.php';
    }
}

?>
