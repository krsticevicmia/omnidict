function popup() {
    alert("Izrada u toku");
}

// On page load
function loadTable(){
    // Dohvatis opciju
    var language = document.getElementById("langOpt").value;
    // Posaljes je kao argument serveru da selektuje tabelu

    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
        document.getElementById("tablePlaceHolder").innerHTML = this.responseText;
    }
    };
    xmlhttp.open("GET", "application/views/ajax_search/find_table?lang=" + language, true);
    xmlhttp.send();
}

    // Onchange language get selected language, display all word_types it contains
function getWordType(){
    var language = document.getElementById("editLangOpt").value;

    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
        document.getElementById("wordsOptionsHolder").innerHTML = this.responseText;
    }
    };
    xmlhttp.open("GET", "application/views/ajax_search/find_all_word_types?lang_name=" + language, true);
    xmlhttp.send();
}

// Onchange word_type 
function loadEditTable(){
    var language = document.getElementById("editLangOpt").value;
    var word_type = document.getElementById("editWordTypeOption").value;

    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
        document.getElementById("editTablePlaceHolder").innerHTML = this.responseText;
    }
    };
    xmlhttp.open("GET", "application/views/ajax_search/find_words_lang_tab?lang_name=" + language+ "&word_type=" + word_type, true);
    xmlhttp.send();
}