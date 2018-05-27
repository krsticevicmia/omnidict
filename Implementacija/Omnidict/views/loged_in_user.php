<?php
/**
 * @author Stefan
 */
?>
<form action="<?php echo $_SERVER['PHP_SELF']; ?>?controller=home&action=logout" method="post">
    <td style="text-align: right; width:10%; padding-right: 20px">
        <input type="button" name="" value="<?php if(isset($_SESSION['username'])) echo $_SESSION['username']; ?>"/>
    </td>
    <td style="text-align: left; width: 10%; padding-right: 20px">
        <input type="submit" name="" value="Odjavite se"/>
    </td>
</form>