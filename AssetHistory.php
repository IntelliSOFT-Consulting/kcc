<?php

//Include the function library
require 'Include/Config.php';
require 'Include/Functions.php';
require 'Include/CanvassUtilities.php';

//Classes


//Set page title
$sPageTitle = gettext('Asset History');

require 'Include/Header.php';

// Display List
if(isset($_GET['history'])){
  $asset_id = $_GET['history'];
    $sSQL = "SELECT asset_assignment.asset_id, asset_assignment.assigned_to, asset_assignment.assigned_by, 
    asset_assignment.assign_date, asset_assignment.return_date, asset_assignment.returned, assets.asset_id, assets.asset_name 
    FROM assets, asset_assignment 
    WHERE assets.asset_id='$asset_id'
    AND assign_deleted= 'FALSE' 
    -- AND returned = 'TRUE'
    ";

    $result = RunQuery($sSQL);
    $resultCheck = mysqli_num_rows($result);
}


//Execute the SQL
RunQuery($sSQL);


?>

<!-- HTML TABLE -->
<div class="box box-warning">
    <div class="box-body">
        <table id="members" class="table table-striped table-bordered data-table" cellspacing="0" width="100%">
            <thead>
                <tr>
                    <th scope="col">Asset Name</th>
                    <th scope="col">Assigned To</th>
                    <th scope="col">Assigned By</th>
                    <th scope="col">Assign Date</th>
                    <th scope="col">Return Date</th>
                    <th scope="col">Status</th>
                </tr>
            </thead>
            <tbody>
                <!--Populate the table with asset details -->
                <?php       
        while($row = mysqli_fetch_assoc($result)){
       ?>
                <tr>
                    <td><?php echo $row['asset_name'] ?></td>
                    <td><?php echo $row['assigned_to'] ?></td>
                    <td><?php echo $row['assigned_by'] ?></td>
                    <td><?php echo $row['assign_date'] ?></td>
                    <td><?php echo $row['return_date'] ?></td>
                    <td> <?php echo $row['returned'] =='TRUE' ?  "<span class='badge badge-returned'>Returned</span>" :  "<span class='badge badge-active'>Active</span>" ?>

                    </td>

                </tr>
                <?php } ?>
            </tbody>
        </table>
    </div>
</div>



<?php
require 'Include/Footer.php'
?>