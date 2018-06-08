<?php

/**
 * Description of WordTypeFrontendTable
 *
 * @author Jovana Trifunovic 2014/0589
 * @Entity
 * @Table(name="WordTypeFrontendTable")
 */
class WordTypeFrontendTable {
    /**
     * @Id
     * @Column (type="integer", nullable=false)
     * @GeneratedValue (strategy="AUTO")
     */
    private $word_type_id;
    
    /**
     * @Column (type="string",length=30) 
     */
    private $word_type;
    
    /**
     * @Column (type="string",length=30)
     */
    private $word = "null";
    
    
    /**
     * @Column (type="string", length=30)
     */
    private $translation = "null";
    /**
     * @ManyToOne(targetEntity="Language", inversedBy="wordTypes")
     * @JoinColumn(name="language", referencedColumnName="languageId")
     */
    protected $languageOrigin;
    
    
    function setWord_type($word_type){
        $this->word_type = $word_type;
    }
    
       function setTranslation($translation){
        $this->translation = $translation;
    }
    
    function setWord($word){
        $this->word = $word;
    }
            
    function setLanguageOrigin($languageOrigin){
        $this->languageOrigin=$languageOrigin;
    }
    
    function get($arg){
        return $this->$arg;
    }
} 
