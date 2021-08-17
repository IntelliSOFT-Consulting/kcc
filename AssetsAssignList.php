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
  $assignment_id = $_GET['delete'];
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
                    <th scope="col">Return Date</th>

                    <th scope="col">Action</th>

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
                    <td>
                        <a href="AssetsAssignList.php?delete=<?php echo $row['assignment_id']; ?>"
                            class="btn btn-danger" name="delete">Delete</a>
                        <a href="#" data-toggle="modal" data-target="#return_assets" class="btn btn-primary">Return </a>

                    </td>
                </tr>
                <?php } ?>
            </tbody>
        </table>
    </div>
</div>

<!-- Modal -->
<div class="modal" tabindex="-1" role="dialog" id="return_assets">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Return Asset</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <label>Return Date</label>
                        <input type="date" class="form-control" id="return_date" required>
                        <small id="date_error" class="form-text text-muted"></small>
                    </div>
                    <button type="submit" class="btn btn-primary">Submit</button>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<?php
require 'Include/Footer.php'
?>