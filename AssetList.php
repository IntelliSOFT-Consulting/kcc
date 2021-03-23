<?php

//Include the function library
require 'Include/Config.php';
require 'Include/Functions.php';
require 'Include/CanvassUtilities.php';



//Set page title
$sPageTitle = gettext('All Assets');


require 'Include/Header.php';

//Database connection


//View all assets


//delete assets


//Update assets



?>


<!-- HTML TABLE -->
<table class="table">
  <thead>
    <tr>
      <th scope="col">Id</th>
      <th scope="col">Asset Name</th>
      <th scope="col">Serial Num</th>
      <th scope="col">Condition</th>
      <th scope="col">Category</th>
      <th scope="col">Purchase Date</th>
      <th scope="col">History</th>
      <th scope="col">Actions</th>

    </tr>
  </thead>
  <tbody>
    <tr>
      <th scope="row">1</th>
      <td></td>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <th scope="row">2</th>
      <td></td>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <th scope="row">3</th>
      <td></td>
      <td></td>
    </tr>
  </tbody>
</table> 



<?php require 'Include/Footer.php' ?>