<?php

/**
 * @author Stefan Boskovic 2014/0659
 */
?>
<script>
function showHint(str) {
    
    if (str.length == 0) { 
        document.getElementById("searchBox").innerHTML = "";
        return;
    } else {
        var xmlhttp = new XMLHttpRequest();
        xmlhttp.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                document.getElementById("searchBox").innerHTML = this.responseText;
            }
        };
        xmlhttp.open("GET", "application/views/ajax_search/find_word?q=" + str, true);
        xmlhttp.send();
    }
    
}
</script>

<form action="<?php echo $_SERVER['PHP_SELF']; ?>?controller=home&action=logout" method="post">
    <td style="text-align: right; width:20%; padding-right: 20px">
        <input type="text" placeholder="Potrazite rec" onkeyup="showHint(this.value)">
    </td>
    <td style="text-align: left; width:60%; padding-right: 20px">
        <!--<input type="button" value="potrazi">-->
        &nbsp;Sugestije: <span id="searchBox"></span>
    </td>
    <td style="text-align: right; width:10%; padding-right: 20px">
        <input type="button" onclick="location.href = 'http://localhost/omnidict/index.php?controller=home&action=index'"
               name="" value="<?php if(isset($_SESSION['username'])) echo $_SESSION['username']; ?>"/>
    </td>
    <td style="text-align: left; width: 10%; padding-right: 20px">
        <input type="submit" name="" value="Odjavite se"/>
    </td>
</form>