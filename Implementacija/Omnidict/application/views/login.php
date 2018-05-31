<?php
    /**
     * @author Stefan
     *
     */
?>
<form name="loignform" action="<?php echo $_SERVER['PHP_SELF']; ?>?controller=home&action=login" method="post">
    <!-- Ovakav style je neophodan zbog poravnanja elemenata -->
    <td style="text-align: left; width:10%; padding-right: 20px">						
        Korisnicko ime<br/>
        <input type="text" name="login_username" value="<?php if(isset($login_username)) echo $login_username; ?>"/>
    </td>
    <td style="text-align: left; width: 10%; padding-right: 20px">
        Lozinka<br/>
        <input type="password" name="login_password"/>
    </td>
    <td style="text-align: left; width:30%">
        <br/>
        <input type="submit" value="Prijavite se"/>
    </td>
</form>