<?php
/**
 * @author Stefan Boskovic 2014/0659
 */

/**
 * Funkcija koja za odredjeni kontroler poziva metoud
 * koja ucitava stranicu 
 * 
 * @param string $controller
 * @param string $action
 */
function call($controller, $action){
    require_once 'application/controllers/'.$controller.'_controller.php';
    
    // VAZNO!!! Ne zaboravi ovdje da dodas novi kontroler
    switch($controller){
        case 'home':            
            // Obratiti paznju da je ovo ime klase a ne .php fajla!
            $controller = new HomeController();            
            break;
        case 'professor':
            $controller = new ProfessorController();
            break;
        case 'student':
              $controller = new StudentController();
              break;
        default:
            $controller = new HomeController();
            break;
    }
    
    $controller->{ $action }();
}

// Niz imena svih kontrolera, i za svaki kontroler niz metoda
// VAZNO!!! Ne zaboravi da dodas novi kontroler i / ili nove funkcije i ovdje
$controllers = array('home' => ['index', 'login', 'error', 'logout', 'register', 'insertLanguage','insertWordTypeFrontendTable',
    'formAction'],
                        'professor' => ['index','edit'], 
                        'student'=> ['index','edit'] );

/**
 * Na osnovu postavljenjih vrijednosti promjenljivih $controller
 * i $method u index.php poziva se odgovarajuci kontroler
 */
if (array_key_exists($controller, $controllers)){
    if (in_array($action, $controllers[$controller])){
        call($controller, $action);
    }
    else{
        call('home', 'error');
    }
}
else{
    call('home', 'error');
}
