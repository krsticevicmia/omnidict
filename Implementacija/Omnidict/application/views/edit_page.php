<?php
/**
* @author Mia Krsticevic 2015/0655
*/
?>


<form name="addRemoveForm" method="post" action="<?php echo $_SERVER['PHP_SELF']; ?>?controller=home&action=formAction">

    <table style=" padding-top: 110px" >
        <tr>
            <td>
                <table cellspacing="30" style="padding-right: 70px" >

                    <tr>
                        <td>
                            <font color = 'red'>
                            <?php
                            if (isset($_SESSION['lang_error_msg']))
                                echo($_SESSION['lang_error_msg']);
                            $_SESSION['lang_error_msg'] = '';
                            ?>
                            </font>
                        </td>
                    </tr>
                    <td>
                        Unesite naziv jezika
                    </td>
                    <td>
                        <input type="text" name="language"/>
                    </td>
                    <td>
                        <input type="submit" name="addLanguage" value ="Dodaj"/>
                    </td>
                    <td>
                        <input type="submit" name="deleteLanguage" value ="Ukloni"/>
                    </td>
        </tr>
        <tr>
            <td>
                Unesite tabelu
            </td>
            <td>
                <input type="text" name="table" value="" >
            </td>
        </tr>

        <tr>
            <td>
                Unesite reč koju ste naučili
            </td>
            <td>
                <input type="text" name="word">
            </td>
        </tr>
        <tr>
            <td>
                Unesite prevod reci
            </td>
            <td>
                <input type="text" name="wordTranslation">
            </td>
            <td>
                <input type="submit" name="addWord" value="Dodaj"/>
            </td>
            <td>
                <input type="submit" name="deleteWord" value="Ukloni"/>
            </td>
        </tr>

    </table>
</td>
</form>
<td>
    <table cellspacing="20">
        <tr>
            <td>
                <select id="editLangOpt" onchange="getWordType()">
                <?php
                /**
                 * @author Stefan Boskovic 2014/0659
                 */
                // Dohvatiti sve jezike za korisnika
                $connection = mysqli_connect('localhost', 'root', '', 'omnidict');
                session_start();
                $username = $_SESSION['username'];
                
                $sql = "SELECT lang.name FROM language lang WHERE lang.user='" . $username . "'";
                $sqlRes = mysqli_query($connection, $sql);
                $lanugages;
                foreach ($sqlRes as $arr) {
                    $languages[] = $arr;
                }
                
                mysqli_close($connection);

                $i = 0;
                foreach ($languages as $lang) {
                    echo '<option id="langOpt' . $i . '" value="' . $lang['name'] . 
                            '" label="'.$lang['languageId'].'">' . $lang['name'] . '</option>';
                    $i++;
                }
                ?>
                </select>
            </td>
            <td>
                <span id="wordsOptionsHolder"></span>
            </td>
        </tr>
        <tr>
            
            <td colspan="3">
                <span id="editTablePlaceHolder"></span>
            </td>  
        </tr>
        </form>
    </table>

</td>
</tr>   
</table>



