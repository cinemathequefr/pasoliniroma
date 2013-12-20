<?php
header("Content-type:text/html; charset=utf-8");
require_once("../classes/nDOM.php");
$xmlDoc = new nDOMDocument();
$xmlDoc->load("../data/data.xml");
$h = $xmlDoc->transformNode("view.xsl", null);
?>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title></title>
        <style>
            table {
                width: 900px;
                border: solid 1px #111;
                border-collapse: collapse;
            }
            th, td {
                font-family: Arial;
                font-size: 14px;
                border: solid 1px #111;
                padding: 2px;
            }
            
            .w5 {width: 5%;}
            .w10 {width: 10%;}
            .w20 {width: 20%;}
            .c  {text-align: center;}

            .bg0 { background-color: #999999; }
            .bg1 { background-color: #e6ff99; }
            .bg2 { background-color: #ffc399; }
            .bg3 { background-color: #ffaa99; }
            .bg4 { background-color: #99ffe5; }
            .bg5 { background-color: #99e5ff; }
            .bg6 { background-color: #d0ccff; }
            .bg7 { background-color: #99c3ff; }
            .bg8 { background-color: #ffe599; }
            .bg9 { background-color: #ff99e5; }
            

        </style>
    </head>
    <body>
        <?php echo($h) ?>
        <script src="http://code.jquery.com/jquery.min.js"></script>
        <script></script>
    </body>
</html>

