<?php

/**
 * @author Stefan Boskovic 2014/0659, Jovana Trifunovic 2014/0589, Mia Krsticevic 2015/0655
 *
 */
use Doctrine\Common\Collections\Criteria;
class HomeController extends CI_Controller {

    public function __construct() {
        parent::__construct();
        $this->load->library('Doctrine');
        $this->load->model('Entity/User');
        session_start();
    }

    /**
     * Ova funkcija treba neulogovanog korisnika preusmjeri na login stranu.
     */
    public function index() {
        // U konstruktoru se pokrece ili dohvata sessija, tako da unutar<br/>
        // $_SESSION niza treba postaviti ime stranice sadrzaja koji ce da se prikazuje,<br/>
        // zbog postavljanja sadrzaja stranice u layout-u<br>
        $_SESSION['content'] = 'application/views/register.php';

        $this->initDatabase();

        require_once 'application/views/layout.php';
        

        $this->redirect('index');
    }

    /**
     * Funkcija koja nakon logovanja preusmjerava korisnika na njegovu pocetnu stranu
     */
    public function login() {
        $username = $_POST['login_username'];
        $password = $_POST['login_password'];
        $user = $this->doctrine->em->getRepository('User')->findBy(array('username' => $username, 'password' => $password));
        if ($user != null) {
            $_SESSION['logedin'] = true;
            $_SESSION['username'] = $username;
            $_SESSION['user_type'] = $user[0]->get('type');
            if ($_SESSION['user_type'] == "p")
                header('Location: ?controller=professor&action=index');
            else
                header('Location: ?controller=student&action=index');
        } else {
            $_SESSION['login_error_msg'] = 'Pogresno korisnicko ime ili lozinka!';
            header('Location: ?controller=home&action=index');
        }
    }

    public function register() {
        $username = $_POST['register_username'];
        $password = $_POST['register_password'];
        $password_repeat = $_POST['register_password_repeat'];
        $email = $_POST['register_email'];
        $type = $_POST['register_type'];


        // Sifre moraju da se poklapaju
        if ($password == $password_repeat) {
            // Korisnik ne smije vec da postoji u bazi
            if (!$this->doctrine->em->getRepository('User')->findBy(array('username' => $username))) {
                $newUser = new User;
                $newUser->setUsername($username);
                $newUser->setPassword($password);
                $newUser->setEmail($email);
                $newUser->setType($type);
                $this->doctrine->em->persist($newUser);
                $this->doctrine->em->flush();
                $_POST['register_success'] = 'Registracija je uspesna, mozete da se prijavite';
                header('Location: ?controller=home&action=index');
                $msg = 'Registracija je uspesna - ulogujte se na sistem!';
            } // U suprotnom obavjestiti korisnika da je username zauzet
            else {
                $msg = 'Registracija je neuspesna';
                $register_error_msg = 'Korisnicko ime je zauzeto';
            }
        } // U suptornom obavjestiti korisnika da se sifre ne poklapaju
        else {
            $msg = 'Registracija je neuspesna';
            $register_error_msg = 'Sifre se ne poudaraju';
        }
        $_SESSION['msg'] = $msg;
        $_SESSION['register_error_msg'] = $register_error_msg;
        header('Location:?controller = home&action=index');
    }

    public function logout() {
        session_destroy();
        header('Location: ?controller=home&action=index');
    }

    /**
     * Funkcija koja vodi na stranicu za ispis greske
     */
    public function error() {
        require_once 'application/views/error.php';
    }


    private function initDatabase() {
        /**
         * @var string[]
         */
        $data = [['username' => 'Jovana', 'password' => 'jovana', 'email' => 'tj140@gmail.com', 'type' => 'p'],
                ['username' => 'Stefan', 'password' => 'stefan', 'email' => 'bs140@gmail.com', 'type' => 's'],
                ['username' => 'Mia', 'password' => 'mia', 'email' => 'km150@gmail.com', 'type' => 's']];
        $users_data = ['Jovana', 'Mia', 'Stefan'];
        require_once 'application/models/Entity/Language.php';
        foreach ($data as $user) {
            if (!$this->doctrine->em->getRepository('User')->findBy(array('username' => $user['username']))) {
                /**
                 * @var User
                 */
                $newUser = new User();
                $newUser->setUsername($user['username']);
                $newUser->setPassword($user['password']);
                $newUser->setEmail($user['email']);
                $newUser->setType($user['type']);
                $this->doctrine->em->persist($newUser);
            }
            $this->doctrine->em->flush();
        }
        foreach ($users_data as $username) {
            $user = $this->doctrine->em->getRepository('User')->findBy(array('username' => $username));
            $user1 = $user[0];
            $lan_data = [
                'engleski',
                'nemacki',
                'latinski'
            ];
            foreach ($lan_data as $language) {
                if (!$this->doctrine->em->getRepository('Language')->findBy(array('languageOwner' => $user1->get('username'),
                            'name' => $language))) {

                    // Create new entity Language
                    $newLanguage = new Language();
                    $newLanguage->setLanguageName($language);
                    $newLanguage->setLanguageOwner($user1);

                    // Insert newLaguage into database
                    $this->doctrine->em->persist($newLanguage);
                    $this->doctrine->em->flush();
                }
            }
        }
    }

    /**
     * Function for inserting language for user
     */
    function insertLanguage() {
        $username = $_SESSION['username'];

        $language = null;
        if (isset($_POST['language']))
            $language = $_POST['language'];
        else
            return null;

        require_once 'application/models/Entity/Language.php';

        //dohvatamo referencu na korisnika koji zeli da ubaci jezik
        $user = $this->doctrine->em->getRepository('User')->findBy(array('username' => $username));
        $user1 = $user[0];

        //provera
        if (!$this->doctrine->em->getRepository('Language')->findBy(array('languageOwner' => $user1->get('username'),
                    'name' => $language))) {

            // Create new entity Language
            $newLanguage = new Language();
            $newLanguage->setLanguageName($language);
            $newLanguage->setLanguageOwner($user1);

            // Insert newLaguage into database
            $this->doctrine->em->persist($newLanguage);
            $this->doctrine->em->flush();
            // Remain on edit page
            $_SESSION['new_error_msg'] = "Jezik je uspesno dodat!";
            $this->redirect('edit');
        } else {
            $_SESSION['lang_error_msg'] = "Jezik vec postoji!";
            $this->redirect('edit');
        }
    }

    /**
     * Function for inserting word type in database, for specific user and language
     */
    function insertWordTypeFrontendTable() {
        $username = $_SESSION['username'];
        $language = null;
        if (isset($_POST['language']))
            $language = $_POST['language'];
        else
            return null;

        $table = null;
        if (isset($_POST['table']))
            $table = $_POST['table'];
        else
            return null;

        $word = null;
        if (isset($_POST['word']))
            $word = $_POST['word'];
        else
            return null;

        $wordTranslation = null;
        if (isset($_POST['wordTranslation']))
            $wordTranslation = $_POST['wordTranslation'];
        else return null;


        require_once 'application/models/Entity/Language.php';
        require_once 'application/models/Entity/WordTypeFrontendTable.php';
        

        //dohvatamo referencu na korisnika koji zeli da ubaci jezik
        $user = $this->doctrine->em->getRepository('User')->findBy(array('username' => $username));
        $user1 = $user[0];
        //dohvatamo referencu na jezik za datog korisnika
        $languages = $this->doctrine->em->getRepository('Language')->findBy(array('languageOwner' => $user1->get('username'),
            'name' => $language));
        // Provjera
        if ($languages) {
            $language1 = $languages[0];
            // Create new entity Word...Table
            $newTable = new WordTypeFrontendTable();
            $newTable->setWord_type($table);
            $newTable->setLanguageOrigin($language1);
            $newTable->setWord($word);
            $newTable->setTranslation($wordTranslation);

            $_SESSION['lang_error_msg'] = "Rec i prevod su uspesno dodati!";

            // Insert newTable into database
            $this->doctrine->em->persist($newTable);
            $this->doctrine->em->flush();

            // Remain on edit page
            $this->redirect('edit');
        } else {
            $_SESSION['lang_error_msg'] = "Zadati jezik ne postoji!";
            $this->redirect('edit');
        }
    }

    function deleteWordTypeFrontendTable() {
        // Prvo iz post niza uzeti lanugage koji se brise

        $username = $_SESSION['username'];
        $language = null;
        if (isset($_POST['language']))
            $language = $_POST['language'];
        else
            return null;

        $table = null;
        if (isset($_POST['table']))
            $table = $_POST['table'];
        else
            return null;

        $word = null;
        if (isset($_POST['word']))
            $word = $_POST['word'];
        else
            return null;
        
        $wordTranslation = null;
        if (isset($_POST['wordTranslation']))
            $wordTranslation = $_POST['wordTranslation'];
        else return null;

        require_once 'application/models/Entity/Language.php';
        require_once 'application/models/Entity/WordTypeFrontendTable.php';

        $user = $this->doctrine->em->getRepository('User')->findBy(array('username' => $username));
        $user1 = $user[0];
        //dohvatamo referencu na jezik za datog korisnika
        $languages = $this->doctrine->em->getRepository('Language')->findBy(array('languageOwner' => $user1->get('username'),
            'name' => $language));
        // Provjera da li postoji jezik
        if ($languages) {
            $language1 = $languages[0];
            //ako postoji provera da li postoji tabela
            $tables = $this->doctrine->em->getRepository('WordTypeFrontendTable')->findBy(array('languageOrigin' => $language1,
                'word_type' => $table));
            if ($tables) {
                foreach ($tables as $row) {
                    if ($row->get('word') == $word && $row->get('translation') == $wordTranslation) {
                        $this->doctrine->em->remove($row);
                        $this->doctrine->em->flush();
                        $_SESSION['lang_error_msg'] = "Tabela je uspesno obrisan!";
                    }
                }
            }
        } else
            $_SESSION['lang_error_msg'] = "Tabela ne postoji u bazi!";
        $this->redirect('edit');
    }

    function deleteLanguage() {
        // Prvo iz post niza uzeti lanugage koji se brise
        $username = $_SESSION['username'];
        $languageName = null;
        if (isset($_POST['language']))
            $languageName = $_POST['language'];
        else
            return null;

        require_once 'application/models/Entity/Language.php';


        // Drugo provjeriti da li se nalazi u bazi za tog user-a
        $user = $this->doctrine->em->getRepository('User')->findBy(array('username' => $username));
        // Mora ref na korisnika jer je languageOwner referenca, username je primarni kljuc
        $language = $this->doctrine->em->getRepository('Language')->findBy(array('languageOwner' => $user[0]->get('username'),
            'name' => $languageName));

        // Trece obrisati ako postoji ako ne iskulirati
        if ($language) {

            $this->doctrine->em->remove($language[0]);
            $this->doctrine->em->flush();
            $_SESSION['lang_error_msg'] = "Jezik je uspesno obrisan!";
        } else
            $_SESSION['lang_error_msg'] = "Jezik ne postoji u bazi!";
        $this->redirect('edit');
    }

    /**
     * Form action based upon form on edit page
     */
    function formAction() {
        // POZIVAM AKCIJU NA OSNOVU SUBMIT BUTTON-A
        if (isset($_POST['addLanguage'])){
        //header('Location: ?controller=home&action=insertLanguage');
            $this->insertLanguage();
        }
        else if (isset($_POST['addWord'])){
            $this->insertWordTypeFrontendTable();
        }
        else if (isset($_POST['deleteLanguage'])){
            $this->deleteLanguage();
        }
        else if (isset($_POST['deleteWord'])){
            $this->deleteWordTypeFrontendTable();
        }
        else if (isset($_POST['showTable'])){
            $_SESSION['textLanguage'] = $_POST['textLanguage'];
            $_SESSION['textTable'] = $_POST['textTable'];
            $this->redirect('edit');
        }
        else if (isset($_POST['professorSelect'])){
            $_SESSION['textLanguage'] = $_POST['professorSelect'];
            $this->redirect('index');
        }
    }

    function redirect($action) {
        if (isset($_SESSION['logedin'])) {
            $url = 'http://localhost/omnidict/index.php?controller=home&action=index' . $action;
            if ($_SESSION['user_type'] == "p") {
                $url = 'http://localhost/omnidict/index.php?controller=professor&action=' . $action;
                echo("<script>location.href='" . $url . "'</script>");
            } else {
                $url = 'http://localhost/omnidict/index.php?controller=student&action=' . $action;
                echo("<script>location.href='" . $url . "'</script>");
            }
        }
    }

}
