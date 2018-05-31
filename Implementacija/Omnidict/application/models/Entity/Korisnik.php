<?php

/**
 * Description of Korisnik
 *
 * @author Stefan Boskovic 2014/0659
 * @Entity
 * @Table(name="korisnik")
 */
class Korisnik {
    /**
     * @Id
     * @Column (type="string", nullable=false)
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
}
