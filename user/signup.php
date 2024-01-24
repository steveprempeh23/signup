<?php
// Allow requests from any origin
header("Access-Control-Allow-Origin: *");

// Allow specified methods (GET, POST, etc.)
header("Access-Control-Allow-Methods: POST");

// Allow specified headers
header("Access-Control-Allow-Headers: Content-Type");

// Set content type to JSON
header("Content-Type: application/json");

// Include database connection
include "../connection.php";

// Retrieve data from the POST request
$userName = $_POST['username'];
$userEmail = $_POST['user_email'];
$userPassword = md5($_POST['user_password']);

// SQL query to insert data into the database
$sqlQuery = "INSERT INTO users_table SET user_name ='$userName',user_email ='$userEmail',user_password = '$userPassword'";

// Execute the SQL query
$resultofQuery = $connection->query($sqlQuery);

// Check for errors and log them
if ($resultofQuery) {
    echo json_encode(array("success" => true));
} else {
    $error_message = mysqli_error($connection);
    error_log("Error in signup.php: " . $error_message);

    echo json_encode(array("success" => false));
}
?>
