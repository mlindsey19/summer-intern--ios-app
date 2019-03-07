<?php
/**
 * Created by PhpStorm.
 * User: mlind
 * Date: 7/10/2018
 * Time: 5:18 PM
 */
require_once 'DB_Func.php';
$db = new DB_Func();


$response = array("error" => "FALSE");

if (isRequiredParametersSet()) {

    $email = $_POST['email'];
    //$password = $_POST['password'];
    $firstName = $_POST['firstName'];
    $lastName = $_POST['lastName'];
    $desiredUsername = $_POST['desiredUsername'];
    $mobileNumber = $_POST['mobileNumber'];
    $photoStorage = $_POST['photoStorage'];
    $uniqueID = $_POST['uniqueID'];


   // $user = $db->getUserByEmailAndPassword($email, $password);
    $user = $db->updateUserProfile($firstName, $lastName, $desiredUsername, $email, $mobileNumber, $photoStorage,
         $uniqueID);

    if ($user) {
        $response['error'] = FALSE;
        $response['uniqueID'] = $user['uniqueID'];
        $response['firstName'] = $user['firstName'];
        $response['lastName'] = $user['lastName'];
        $response['desiredUsername'] = $user['desiredUsername'];
        $response['mobileNumber'] = $user['mobileNumber'];
        $response['email'] = $user['email'];
        $response['createdAt'] = $user['createdAt'];
        $response['photoStorage'] = $user['photoStorage'];
        $response['message'] = "Update Successful";
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
    if (isset($_POST['firstName']) &&
        isset($_POST['lastName']) &&
        isset($_POST['desiredUsername']) &&
        isset($_POST['mobileNumber']) &&
        isset($_POST['email']) &&
        //isset($_POST['password']) &&
        isset($_POST['photoStorage']) &&
        isset($_POST['uniqueID'])) {
        return true;
    } else
        return false;

}

?>