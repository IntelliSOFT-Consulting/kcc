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
$sSQL = "SELECT asset_assignment.assignment_id, asset_assignment.asset_id, asset_assignment.assigned_to, asset_assignment.assigned_by, asset_assignment.assign_date, asset_assignment.return_date, assets.asset_id, assets.asset_name FROM assets, asset_assignment WHERE asset_assignment.asset_id=assets.asset_id AND assign_deleted= 'FALSE' ";
$result = RunQuery($sSQL);
$resultCheck = mysqli_num_rows($result);

//Delete assets
if(isset($_GET['delete'])){
    $assignment_id = $_GET['delete'];
    $sSQL = "UPDATE asset_assignment SET assign_deleted = 'TRUE' WHERE assignment_id='$assignment_id'";
    RunQuery($sSQL);
    header("Location: AssetsAssignList.php");
}

// Capture asset return
if (isset($_POST["returnAsset"])) {
    $sreturn_date = $_POST['return_date'];

    $sSQL = "UPDATE asset_assignment SET returned = 'TRUE' WHERE assignment_id='$assignment_id'";
    $result = RunQuery($sSQL);

}

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
            <tbody id="return-asset">
                <?php       
                    while($row = mysqli_fetch_assoc($result)){
                ?>
                <tr data-item="<?php echo $row['asset_id']?>">
                    <td><?php echo $row['asset_name'] ?></td>
                    <td><?php echo $row['assigned_to'] ?></td>
                    <td><?php echo $row['assigned_by'] ?></td>
                    <td><?php echo $row['assign_date'] ?></td>
                    <td><?php echo $row['return_date'] ?></td>
                    <td>
                        <a href="AssetsAssignList.php?delete=<?php echo $row['assignment_id']; ?>"
                            class="btn btn-danger" name="delete"
                            onClick="return confirm('Sure you want to delete this assignment? This cannot be undone later.')">
                            Delete</a>
                        <a href="#" data-toggle="modal" data-target="#return_assets" class="btn btn-primary">Return </a>
                        <a href="AssetHistory.php?history=<?php echo $row['asset_id']; ?>" class="btn btn-success"
                            name="history">History</a>
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
                <form id="modal_form" method="POST" action="AssetsAssignList.php">
                    <div class="form-group">
                        <label>Return Date</label>
                        <input type="date" class="form-control" id="return_date" required>
                        <small id="date_error" class="form-text text-muted"></small>
                    </div>
                    <!--Give  modal value of asset_id-->
                    <!-- <input type="hidden" name="asset_id" id="modal_assetID"> -->
                    <button type="submit" class="btn btn-primary" name="returnAsset">Submit</button>
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