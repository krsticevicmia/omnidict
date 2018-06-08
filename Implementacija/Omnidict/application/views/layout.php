<!DOCTYPE html>
<?php
    /**
     * @author Stefan Boskovic 2014/0659
     *
     */
?>
<html>
<head>
        <meta http-equiv="Content-type" content="text/html; charset=utf-8">
	<title>Omnidict</title>
        <!- application/resources/custom.css -->
        <link rel="stylesheet" type="text/css" href="<?php echo base_url(); ?>/application/resources/custom.css"/>
        <script src="<?php echo base_url(); ?>/application/resources/ajax_loaders.js" ></script>
</head>

<body onload="loadTable(); getWordType();">
    <div class="navbar">
        <table style="width : 100%">
            <tr>                
                <td>
                    <h2>Omnidict</h2>
                </td>
                <?php
                    require_once 'application/routes_header.php';
                ?>
            </tr>
        </table>
    </div>
    <div class="body">
        <?php
            require_once 'application/routes_content.php';
        ?>
    </div>
</body>
<?php
    require_once 'application/views/footer.php'
?>
</html>
