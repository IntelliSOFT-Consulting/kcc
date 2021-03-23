<?php

//Include the function library
require 'Include/Config.php';
require 'Include/Functions.php';
require 'Include/CanvassUtilities.php';


//Set page title
$sPageTitle = gettext('Assign Assets');

require 'Include/Header.php';

//Add fields


//Database connection
$conn = new mysqli('localhost', 'root', '', 'churchcrm');
if ($conn->connect_error) {
    die('Connection failed: ' . $conn->connect_error);
} 

?>

<form method="post" action="AssignAssets.php">
    
</form>

<?php require 'Include/Footer.php' ?>