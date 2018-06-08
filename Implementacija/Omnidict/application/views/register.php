<?php
/**
 * @author Stefan
 *
 */
?>
<table id="register">
    <form name="registerform" action="<?php echo $_SERVER['PHP_SELF']; ?>?controller=home&action=register" method="post">
        <tr>
            <td>
                &nbsp;
            </td>
            <!-- Ovakav style je neophodan zbog poravnanja elemenata -->
            <td style="text-align: left; width:10%; padding-bottom: 25px; padding-right: 20px">
                Korisnicko ime<br/>
                <input required type="text" name="register_username" value="<?php if (isset($register_username)) echo $register_username; ?>"/>
            </td>
            <td style="text-align: left; width:10%; padding-bottom: 25px; padding-right: 20px">
                Email<br/>
                <input required type="text" name="register_email" value="<?php if (isset($register_email)) echo $register_email; ?>"/>
            </td>
            <td style="text-align: left; width:30%; padding-bottom: 25px">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
            <td style="text-align: left; width:10%; padding-bottom: 25px">
                Sifra<br/>
                <input required type="password" name="register_password"/>
            </td>
            <td style="text-align: left; width:10%; padding-bottom: 25px">
                Potvrdi sifru<br/>
                <input required type="password" name="register_password_repeat"/>
            </td>
            <td style="text-align: left; width:30%; padding-bottom: 25px">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
            <td style="padding-bottom: 15px">
                <input type="radio" name="register_type" value="s" checked="true">Ucenik
            </td>
            <td style="padding-bottom: 15px">
                <input type="radio" name="register_type" value="p">Nastavnik
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                <input type="submit" value="Registrujte se" name="submit">
                
                <br><?php if (isset($_SESSION['msg']))echo($_SESSION['msg']); 
                $_SESSION['msg']='';
                ?>
                <br><font color = 'red'><?php if (isset($_SESSION['register_error_msg']))echo($_SESSION['register_error_msg']);
                $_SESSION['register_error_msg']='';?></font>

            </td>
        </tr>        
    </form>
</table>