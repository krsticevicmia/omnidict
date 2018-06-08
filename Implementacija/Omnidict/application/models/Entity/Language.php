<?php

/**
 * Description of Language
 *
 * @author Jovana Trifunovic 2014/0589
 * @Entity
 * @Table(name="language")
 */
class Language {
    /**
     * @Id
     * @Column (type="integer", nullable=false)
     * @GeneratedValue (strategy="AUTO")
     */
    private $languageId;
    /**
     * @Column (type="string", nullable=false)
     */
    private $name;
    
    
    /**
     * @ManyToOne(targetEntity="User", inversedBy="languages")
     * @JoinColumn(name="user", referencedColumnName="username")
     */
    protected $languageOwner;
    /*
     * @OneToMany(targetEntity="WordTypeFrontendTable", mappedBy="languageOrigin")
     */
   // protected $wordTypes;
    
    function setLanguageName($name){
        $this->name = $name;
    }
    
    function setLanguageId($id){
        $this->languageId = $id;
    }
    
    function setLanguageOwner($owner){
        $this->languageOwner = $owner;
    }
    
    function get($arg){
        return $this->$arg;
    }
}


