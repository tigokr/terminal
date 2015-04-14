<?php
/**
 * Created by PhpStorm.
 * User: Artem
 * Date: 08.04.2015
 * Time: 17:53
 */
!defined('DIRECTORY_SEPARATOR') && define ('DIRECTORY_SEPARATOR', "/");
!defined('DS') && define ('DS', DIRECTORY_SEPARATOR);
!defined('ROOT') && define('ROOT', dirname(dirname(__FILE__)));

function d($var = false, $showHtml = false, $showFrom = true){
    echo '<pre>';
    if ($showFrom) {
        $calledFrom = debug_backtrace();
        echo $calledFrom[0]['file'].' (line ' . $calledFrom[0]['line'] . ")\n";
    }
    $var = print_r($var, true);
    if ($showHtml) {
        $var = str_replace('<', '&lt;', str_replace('>', '&gt;', $var));
    }
    echo $var . "\n";
    echo '</pre>';
}