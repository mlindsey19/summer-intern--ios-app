<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

class DB_Func
{
    private $conn;

    //constructor
    function __construct()
    {
        require_once 'DB_conn.php';
        $db = new DB_Connect();
        $this->conn = $db->connect();
    }

    function __destruct()
    {
    }

    /**
     * @param $firstName
     * @param $lastName
     * @param $desiredUsername
     * @param $mobileNumber
     * @param $email
     * @param $password
     * @return bool
     */
    function storeUser($firstName, $lastName, $desiredUsername, $mobileNumber, $email, $password)
    {
        //uniqueID, hash, salt
        $uniqueID = uniqid(' ', true);
        $hash = $this->hashSSHA($password);
        // add salt and encrypt pass
        $encryptedPassword = $hash["encrypted"];
        $salt = $hash["salt"];


        //prepare sql //ADD salt and encrypted password
        $stmt = $this->conn->prepare("INSERT INTO users(uniqueID, firstName, lastName, desiredUsername, 
                                    mobileNumber, email, encryptedPassword, salt, createdAt)
                                     VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW())");
        $stmt->bind_param("ssssssss", $uniqueID, $firstName, $lastName, $desiredUsername,
            $mobileNumber, $email, $encryptedPassword, $salt);
        $result = $stmt->execute();
        $stmt->close();

        //check for successful store
        if ($result) {
            return $this->isSuccessful($email);
        } else {
            return false;
        }
    }


    //Encrypting password
    public function hashSSHA($password)
    {
        $salt = sha1(rand());
        $salt = substr($salt, 0, 10);
        $encrypted = base64_encode(sha1($password . $salt, true) . $salt);
        $hash = array("salt" => $salt, "encrypted" => $encrypted);
        return $hash;
    }

    public function checkHashSSHA($salt, $password)
    {
        $encrypted = base64_encode(sha1($password . $salt, true) . $salt);
        return $encrypted;
    }

    public function isUserInfoUnique($email, $desiredUsername)
    {
        //check email
        $stmt = $this->conn->prepare("SELECT email from users WHERE email = ?");
        $stmt->bind_param("s", $email);
        $stmt->execute();
        $stmt->store_result();
        $existingInfo['emailExists'] = $stmt->num_rows();
        $stmt->close();

        //check username
        $stmt = $this->conn->prepare("SELECT desiredUsername from users WHERE desiredUsername = ?");
        $stmt->bind_param("s", $desiredUsername);
        $stmt->execute();
        $stmt->store_result();
        $existingInfo['usernameExists'] = $stmt->num_rows();
        $stmt->close();

        return $existingInfo;
    }

    public function updateUserProfile($firstName, $lastName, $desiredUsername, $email, $mobileNumber, $photoStorage,
                                      $uniqueID)
    {

        //TODO: get user unique ID
        $stmt = $this->conn->prepare("UPDATE users SET firstName = ?, lastName = ?, desiredUsername = ?,
                                              email = ?, mobileNumber = ?, photoStorage = ?, 
                                              updatedAT = NOW() WHERE uniqueID = ?");

        $stmt->bind_param('sssssss', $firstName, $lastName, $desiredUsername, $email, $mobileNumber,
            $photoStorage, $uniqueID);


        $result = $stmt->execute(); //TODO: is store successful
        $stmt->close();

        if ($result) {
            $user = $this->isSuccessful($email);
            return $user;
        } else {
            return false;
        }
    }


    public function isSuccessful($email)
    {
        $id = $uniqueID = $firstName = $lastName = $desiredUsername = $mobileNumber = $encryptedPassword = $salt
            = $createdAt = $updatedAt = $photoStorage = 0;


        $stmt = $this->conn->prepare("SELECT * FROM users WHERE email = ?");
        $stmt->bind_param("s", $email);
        $stmt->execute();
        $stmt->bind_result($id, $uniqueID, $firstName, $lastName, $desiredUsername, $mobileNumber, $email,
            $encryptedPassword, $salt, $createdAt, $updatedAt, $photoStorage);

        $stmt->fetch();

        //store in array $user
        $user['id'] = $id;
        $user['uniqueID'] = $uniqueID;
        $user['firstName'] = $firstName;
        $user['lastName'] = $lastName;
        $user['desiredUsername'] = $desiredUsername;
        $user['mobileNumber'] = $mobileNumber;
        $user['email'] = $email;
        $user['photoStorage'] = $photoStorage;
        $user['encryptedPassword'] = $encryptedPassword;
        $user['salt'] = $salt;
        $user['createAt'] = $createdAt;
        $user['updatedAt'] = $updatedAt;

        $stmt->close();

        return $user;
    }

    public function getUserByEmailAndPassword($email, $password)
    {

        //$hash = $this->hashSSHA($password);
        //$encryptedPassword = $hash['encrypted'];
        //$salt = $hash["salt"];

        $stmt = $this->conn->prepare('SELECT *FROM users WHERE email = ?');
        $stmt->bind_param('s', $email);
        $result = $stmt->execute();
        $stmt->close();

        if ($result) {
            $user = $this->isSuccessful($email);

            $salt = $user['salt'];
            $encryptedPassword = $user['encryptedPassword'];

            $validPassword = $this->checkHashSSHA($salt, $password);


            if ($validPassword == $encryptedPassword) {
                return $user;
            } else {
                return FALSE;
            }
        }
    }


    public function addToRatingTable($userEmail, $targetEmail, $ratingValue, $ratingKey)
    {

        $ratingID = uniqid(' ', true);

        $sql = "INSERT INTO ratings(userEmail, targetEmail, ratingID, ratingKey, ratingValue)
                                     VALUES (?, ?, ?, ?, ?)";

        if ($stmt = $this->conn->prepare($sql)) {


            $stmt->bind_param("sssss", $userEmail, $targetEmail, $ratingID, $ratingKey, $ratingValue);
        } else {
            $error = $stmt->errno . ' ' . $stmt->error;
            echo $error;
        }
        $result = $stmt->execute();
        $stmt->close();

//check for successful store
        if ($result) {
            return true;
        } else {
            return false;
        }
    }


    public function getTrait($traitNumber)
    {
        $inUseBool = 0;
        $trait['message'] ="no more traits";
        $sql = "SELECT traitName, traitKey, inUseBool FROM traits WHERE traitCount = ?";
        //get number of rows
        $sqlCount = "SELECT MAX(traitCount) FROM traits";
        $stmtCount = $this->conn->prepare($sqlCount);
        $stmtCount->execute();
        $stmtCount->bind_result($maxTraitNumber);
        $stmtCount->fetch();
        $stmtCount->close();


        while ($inUseBool == 0) {
            //returns if last trait
            if ($maxTraitNumber < $traitNumber) {
               $trait['error'] = true;
                return $trait;
            } else {
                $stmt = $this->conn->prepare($sql);
                $stmt->bind_param("s", $traitNumber);
                $stmt->execute();
                $stmt->bind_result($name, $traitKey, $inUseBool);

                $stmt->fetch();

                $trait['error'] = false;
                $trait['traitName'] = $name;
                $trait['traitKey'] = $traitKey;
                $trait['inUseBool'] = $inUseBool;


                $stmt->close();


            }
        }
        return $trait;


    }
}