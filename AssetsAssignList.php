<?php

//Include the function library
require 'Include/Config.php';
require 'Include/Functions.php';
require 'Include/CanvassUtilities.php';

//Classes


//Set page title
$sPageTitle = gettext('Asset Assignment list');

require 'Include/Header.php';

// Display List
$sSQL = "SELECT * from asset_assignment WHERE assign_deleted= 'False'";
$result = RunQuery($sSQL);
$resultCheck = mysqli_num_rows($result);


//Delete assets
if(isset($_GET['delete'])){
  $assignment_id  = $_GET['delete'];
  $sSQL = "UPDATE asset_assignment SET assign_deleted = 'TRUE' WHERE assignment_id='$assignment_id'";
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
                    <th scope="col">Action</th>

                </tr>
            </thead>
            <tbody>
                <!--Populate the table with asset details -->
                <?php       
        while($row = mysqli_fetch_assoc($result)){
       ?>
                <tr>
                    <td><?php echo $row['assetName'] ?></td>
                    <td><?php echo $row['assigned_to'] ?></td>
                    <td><?php echo $row['assigned_by'] ?></td>
                    <td><?php echo $row['assign_date'] ?></td>
                    <td><?php echo $row['assign_date'] ?></td>
                    <td>
                        <a href="AssetsAssign.php?reassign=<?php echo $row['assignment_id ']; ?>" class="btn btn-info"
                            name="reasign">Reassign</a>
                        <a href="AssetsAssignList.php?delete=<?php echo $row['assignment_id ']; ?>" class="btn btn-danger"
                            name="delete">Delete</a>
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