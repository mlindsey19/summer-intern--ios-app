<?php

require_once 'DB_Func.php';
$db = new DB_Func();

function isRequiredParametersSet(){
    if (isset($_POST['firstName']) &&
        isset($_POST['lastName']) &&
        isset($_POST['desiredUsername']) &&
        isset($_POST['mobileNumber']) &&
        isset($_POST['email']) &&
        isset($_POST['password'])){
            return true;
    }
    else
        return false;

}

    if (isRequiredParametersSet()) {
    $firstName = $_POST['firstName'];
    $lastName = $_POST['lastName'];
    $desiredUsername = $_POST['desiredUsername'];
    $mobileNumber = $_POST['mobileNumber'];
    $email = $_POST['email'];
    $password = $_POST['password'];

    //check if user exists, then if desired username is available
    $existingInfo = $db->isUserInfoUnique($email, $desiredUsername);

        if ($existingInfo['emailExists'] > 0 || $existingInfo['usernameExists'] > 0){
        $response["error"] = TRUE;
        if ($existingInfo['emailExists'] > 0 && $existingInfo['usernameExists'] > 0) {
            $response["errorMessage"] = "Both Username and Email already exist.";
                echo json_encode($response);
                print_r($existingInfo);
        } else{     //if at least one is true but not both, then larger of the two is the duplicate
            $response["errorMessage"] = ($existingInfo['emailExists'] > $existingInfo['usernameExists']) ? "Email already exists" : "Username already exists";
            echo json_encode($response);
           // print_r($response);
            //print_r($existingInfo);
        }
    }
    //if email and desired name do not exists, create new user.
        else {

        $user = $db->storeUser($firstName, $lastName, $desiredUsername, $mobileNumber, $email, $password);
    }
        if ($user) {
            $response['uniqueID'] = $user['uniqueID'];
            $response['firstName'] = $user['firstName'];
            $response['lastName'] = $user['lastName'];
            $response['desiredUsername'] = $user['desiredUsername'];
            $response['mobileNumber'] = $user['mobileNumber'];
            $response['email'] = $user['email'];
            //$response['createdAt'] = $user['createdAt'];
            $response['photoStorage'] = $user['photoStorage'];
            $response['error'] = FALSE;
            $response['message'] = "Registered Successfully";

        echo json_encode($response);
    }
    else {
        $response['error'] = TRUE;
        $response['message'] = "Error with registration";
        echo json_encode($response);
    }

}
else{
    $response['error'] = TRUE;
    $response['errorMessage'] = "Parameters not set"; //TODO: validate this on app!
   // print_r($response);
    echo json_encode($response);
}
 ?>