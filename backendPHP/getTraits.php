<?php
/**
 * Created by PhpStorm.
 * User: mlind
 * Date: 8/17/2018
 * Time: 1:03 PM
 */


require_once 'DB_Func.php';
$db = new DB_Func();

$response['error'] = true;

if (isset($_POST['traitNumber'])) {

    $traitNumber = $_POST['traitNumber'];

    $trait = $db->getTrait($traitNumber);

    if ( $trait['error'] == false) {

        $response['traitName'] = $trait['traitName'];
        $response['traitKey'] = $trait['traitKey'];
        $response['inUseBool'] = $trait['inUseBool'];
        $response['error'] = $trait['error'];
        $response['message'] = "Fetch Successful";
    } else {
        $response['error'] = TRUE;
        $response['message'] = "Could not retrieve user";
    }
    echo json_encode($response);


}


?>