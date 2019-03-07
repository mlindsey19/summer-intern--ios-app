<?php
/**
 * Created by PhpStorm.
 * User: mlind
 * Date: 8/13/2018
 * Time: 12:50 PM
 */

require_once 'DB_Func.php';
$db = new DB_Func();


$response = array("error" => FALSE);

if (isRequiredParametersSet()) {

    $userEmail = $_POST['userEmail'];
    $targetEmail = $_POST['targetEmail'];
  //  $ratingID = $_POST['ratingID'];
    $ratingValue = $_POST['ratingValue'];
    $ratingKey = $_POST['ratingKey'];


   // $user = $db->getUserByEmailAndPassword($email, $password);
    $user = $db->addToRatingTable($userEmail, $targetEmail, $ratingValue, $ratingKey);

    if ($user) {
        $response['error'] = FALSE;
        $response['message'] = "Successful Addition";
    } else {
        $response['error'] = TRUE;
    }
    echo json_encode($response);

} else {
    $response['message'] = "parameters not set";
    echo json_encode($response);
}

function isRequiredParametersSet()
{
    if (isset($_POST['userEmail']) &&
        isset($_POST['targetEmail']) &&
       // isset($_POST['ratingID']) &&
        isset($_POST['ratingValue']) &&
        isset($_POST['ratingKey']) )
    {
        return true;
    }

    else
        return false;

}



?>