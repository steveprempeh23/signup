<?php
include "../connection.php";

$userEmail = $_POST['user_email'];

"SELECT * FROM user_table WHERE email = $ '$userEmail'";

$resultofQuery = $connection->query($sqlQuery);

if($resultofQuery->num_rows > 0)
{ 
    echo json_encode(array("emailFound"=>true));
}
else{
    echo json_encode(array("emailFound"=>false));
}