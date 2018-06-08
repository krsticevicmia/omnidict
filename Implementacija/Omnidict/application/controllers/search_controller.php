<?php


/**
 * Description of search_controller
 *
 * @author Stefan Boskovic 2014/0659
 */
class SearchController extends CI_Controller {
    
    
    function __construct() {
        parent::__construct();
        $this->load->library('Doctrine');
        $this->load->model('Entity/User');
        //session_start();
    }
    
    function findTable(){
        $username = $_SESSION['username'];        
        $language = null;
        if (isset($_SESSION['textLanguage']))
            $language = $_SESSION['textLanguage'];
        else 
            return null;  
        
        $table = null;
        if (isset($_SESSION['textTable']))
           $table = $_SESSION['textTable'];
        else 
            // Treba dohvatiti iz baze prvu tabelu koja postoji
            $table = 'noun';
             
        require_once 'application/models/Entity/Language.php';
        require_once 'application/models/Entity/WordTypeFrontendTable.php';
        
        
        //dohvatamo referencu na korisnika koji zeli da ubaci jezik
        $user = $this->doctrine->em->getRepository('User')->findBy(array('username' => $username));
        $user1 = $user[0];
        //dohvatamo referencu na jezik za datog korisnika
        $languages = $this->doctrine->em->getRepository('Language')->findBy(array('languageOwner' => $user1->get('username'),
            'name' => $language));
        
        $tables = $this->doctrine->em->getRepository('WordTypeFrontendTable')->findBy(array('languageOrigin' => $languages[0],
            'word_type' => $table));
        
        return $tables;
    }
    
    function findLanguages(){
        $username = $_SESSION['username'];
        
        require_once 'application/models/Entity/User.php';
        require_once 'application/models/Entity/Language.php';
        require_once 'application/models/Entity/WordTypeFrontendTable.php';
        
        $user = $this->doctrine->em->getRepository('User')->findBy(array('username' => $username));
        $user1 = $user[0];
        //dohvatamo referencu na jezik za datog korisnika
        $languages = $this->doctrine->em->getRepository('Language')->findBy(array('languageOwner' => $user1->get('username')));
        
        return $languages;
    }
    

}
