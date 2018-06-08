<?php
/**
* @author Mia Krsticevic 2015/0655
*/
?>

<table style=" padding-top: 110px" >
<tr>
    <td>
        <table cellspacing="20">
            <tr>
                <td>
                    Nedavno dodate reči:
                </td>
                <td>
                    <select id="langOpt" onchange="loadTable()">
                        <?php

                        require_once 'application/controllers/search_controller.php';
                        $search = new SearchController();
                        $languages = $search->findLanguages();

                        $i = 0;
                        foreach ($languages as $lang) {
                            echo '<option id="langOpt' . $i . '" value="' . $lang->get('name') . '">' . $lang->get('name') . '</option>';
                            $i++;
                        }
                        ?>
                    </select>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div style="overflow-x:auto">
                        <span id="tablePlaceHolder"></span>
                    </div>
                </td>
            </tr>
        </table>
    </td>
    <td>
        <table cellspacing="20">
            <tr>
                <td colspan="2"> 
                    <button onclick="location.href = 'http://localhost/omnidict/index.php?controller=student&action=edit'"  name="Izmene" style="width:44%">
                        Izmene
                    </button>
                </td>
                  <br><?php if (isset($_SESSION['new_lang_msg']))echo($_SESSION['new_lang_msg']); 
                    $_SESSION['new_lang_msg']='';
                    ?>
                <td> Moji kursevi</td>
            </tr>
            <tr>
                <td><button onclick="popup()" style="width:100%">Pregled kursa</button></td>

                <td><button onclick="popup()" style="width:100%">Brisanje kursa</button></td>
                <td><select>
                        <option>deutsch insitut</option>
                    </select>
                </td>
            </tr>

        </table>
    </td>
</tr>   
</table>



