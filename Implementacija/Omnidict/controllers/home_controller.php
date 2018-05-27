<?php
/**
 * @author Stefan
 *
 */
class HomeController{
    
    
    function __construct() {
        session_start();
    }
    
    /**
     * Ova funkcija treba neulogovanog korisnika preusmjeri na login stranu,
     * a ulogovanog korisnika na njegovu pocetnu stranu
     */
    function index(){
        // U konstruktoru se pokrece ili dohvata sessija, tako da unutar
        // $_SESSION niza treba postaviti ime stranice na koju se prelazi,
        // zbog postavljanja sadrzaja stranice u layout-u
        $_SESION['contet'] = 'views/register.php';
        
        require_once 'views/layout.php';
        
        /*
        if (isset($_SESSION['user'])){
            if ($_SESSION['user']->type == 'professor'){
                header("Location: ?controller=professor&action=index");
            }
            else{
                header("Location: ?controller=student&action=index");
            }
        }*/
    }
    
    /**
     * Funkcija koja preusmjerava korisnika na njegovu pocetnu stranu
     */
    function login(){
        // Za sada hardcodovani kredencijali, kasnije se povezati sa bazom!!!
        if ($_POST['login_username'] == "user" && $_POST['login_password'] == "123"){
            $_SESSION['logedin'] = true;
            $_SESSION['username'] = "user";
            header('Location: ?controller=professor&action=index');
        }
        else
            header('Location: ?controller=home&action=index');
    }
    
    function logout(){
        session_destroy();
        header('Location: ?controller=home&action=index');
    }
    
    function greska(){
        require_once 'views/greska.php';
    }
    
}

?>