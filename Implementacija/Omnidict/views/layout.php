<!DOCTYPE html>
<?php
    /**
     * @author Stefan
     *
     */
?>
<html>
<head>
	<title>Omnidict</title>
        <link rel="stylesheet" type="text/css" href="resources/custom.css">
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
                    require_once 'routes_header.php';
                ?>
            </tr>
        </table>
    </div>
    <div class="body">
        <?php
            // TODO: routes za body
            require_once 'routes_content.php';
        ?>
    </div>
</body>
<?php
    require_once 'footer.php'
?>
</html>
