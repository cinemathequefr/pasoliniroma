<?php
header("Content-type:text/html; charset=utf-8");
require_once("../classes/nDOM.php");

$xmlDoc = new nDOMDocument();
$xmlDoc->load("../data/data.xml");
$h = $xmlDoc->transformNode("texts.xsl", null);
?>


<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <style>
        @media print {

            body {
                font-size: 12pt;
                font-family: "Times New Roman";

            }

            a {
                color: black;
            }

            section {
                page-break-before: always;
            }

            .text {
                margin-top: 1cm;
            }


        }
        </style>
    </head>
    <body>
        <?php echo($h) ?>
    </body>
</html>