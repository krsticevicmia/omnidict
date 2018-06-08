<?php

/**
 * Description of User
 *
 * @author Stefan Boskovic 2014/0659
 * @Entity
 * @Table(name="user")
 */
class User {
    /**
     * @Id
     * @Column (type="string", nullable=false, length=30)
     */
    private $username;

    /**
     * @Column (type="string", nullable=false, length=30)
     */
    private $password;

    /**
     * @Column (type="string", nullable=false, length=30)
     */
    private $email;

    /**
     * @Column (type="string", nullable=false, length=1)
     */
    private $type;
    

    /*
     * @OneToMany(targetEntity="Language", mappedBy="languageOwner")
     */
    //protected $languages=null;
    
    
    function get($name) {
        return $this->$name;
    }

    function setUsername($username){
        $this->username = $username;
    }
    
    function setPassword($password){
        $this->password = $password;
    }
    
    function setEmail($email){
        $this->email = $email;
    }
    
    function setType($type){
        $this->type = $type;
    }
}
