<!DOCTYPE html>
<?php
    /**
     * @author Stefan
     *
     */
?>
<html>
<head>
        <meta http-equiv="Content-type" content="text/html; charset=utf-8">
	<title>Omnidict</title>
        <!- application/resources/custom.css -->
        <link rel="stylesheet" type="text/css" href="<?php echo base_url(); ?>/application/resources/custom.css"/>
</head>

<body>
    <div class="navbar">
        <table style="width : 100%">
            <tr>                
                <td>
                    <h2>Omnidict</h2>
                </td>
                <?php
                    // TODO: routes za zaglavlje - login ili korisnicko ime
                    require_once 'application/routes_header.php';
                ?>
            </tr>
        </table>
    </div>
    <div class="body">
        <?php
            // TODO: routes za body
            require_once 'application/routes_content.php';
        ?>
    </div>
</body>
<?php
    require_once 'application/views/footer.php'
?>
</html>
