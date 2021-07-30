<?php
require 'Include/Config.php';
require 'Include/Functions.php';

use ChurchCRM\Utils\InputUtils;
use ChurchCRM\Authentication\AuthenticationManager;

//Set page title
$sPageTitle = gettext('Asset Location');


require 'Include/Header.php';

// Get the locationID out of the querystring
if (array_key_exists('locationID', $_GET)) {
    $locationID = InputUtils::LegacyFilterInput($_GET['locationID'], 'int');
} else {
    $locationID = 0;
}


//Add a location
if (isset($_POST['AddLocation'])) {
    $slocation = InputUtils::LegacyFilterInput($_POST['location']);
    $slocationCode = InputUtils::LegacyFilterInput($_POST['locationCode']);


    if ($locationID == 0) {
        $sSQL = "INSERT INTO asset_location (location, locationCode)
                VALUES('" . $slocation . "', '" . $slocationCode . "')";
    }
    
    //Execute the SQL
    RunQuery($sSQL);

} elseif (isset($_GET['edit'])) {
    $locationID = $_GET['edit'];

    $sSQL = "SELECT * FROM asset_location where locationID='$locationID'";
    $result = RunQuery($sSQL);

    $row = mysqli_fetch_array($result);
    extract($row);

    $slocation = $location;
    $slocationCode = $locationCode;

} elseif (isset($_POST['Update'])) {
    $locationID = InputUtils::LegacyFilterInput($_POST['locationID'], 'int');

    $slocation = $_POST['location'];
    $slocationCode = $_POST['locationCode'];

    $sSQL = "UPDATE asset_location SET location = '" . $slocation . "', locationCode = '" . $slocationCode . "'
    WHERE locationID = '$locationID' LIMIT 1 ";

    RunQuery($sSQL);
    
}


// display a list of all categories
$sSQL = "SELECT * from asset_location WHERE locationDeleted='False'";
$result = RunQuery($sSQL);
$resultCheck = mysqli_num_rows($result);

//Delete one location 

if (isset($_POST['Action']) && isset($_POST['locationID']) && AuthenticationManager::GetCurrentUser()->isAddRecordsEnabled()) {
    $locationID = InputUtils::LegacyFilterInput($_POST['locationID'], 'int');
    $action = InputUtils::LegacyFilterInput($_POST['Action']);

    if ($action == 'Delete' && $locationID) {
        $sSQL = "UPDATE asset_location SET locationDeleted = 'True' WHERE locationID='$locationID'  LIMIT 1";

        RunQuery($sSQL);
    }
}
?>

<!-- form for adding categories -->
<div class="box box-warning clearfix">

    <div class="box-header">
        <h3 class="box-title"><?= gettext('Add New Location') ?></h3>
    </div>

    <form method="post" action="Assetlocation.php">
        <input type="hidden" name="locationID" value="<?= ($locationID) ?>">

        <div class="row">
            <div class="col-md-4 ml-3">
                <label><?= gettext('Location') ?>:</label>
                <input type="text" name="location" id="location" value="<?= htmlentities(stripslashes($slocation), ENT_NOQUOTES, 'UTF-8') ?>" class="form-control">
            </div>

            <div class="col-md-4 ml-3">
                <label><?= gettext('Location Code') ?>:</label>
                <input type="text" name="locationCode" id="locationCode" value="<?= htmlentities(stripslashes($slocationCode), ENT_NOQUOTES, 'UTF-8') ?>" class="form-control">
            </div>

        </div>

        <div class="ml-5">
            <input type="submit" class="btn btn-primary mt-3" id="AddLocation" value="<?= gettext('Save') ?>" name="AddLocation">
            <input type="submit" class="btn btn-primary mt-3" value=<?= gettext("Update") ?> name="Update">
        </div>


        <p />

    </form>

</div>



<!-- HTML TABLE -->
<div class="box box-warning">
    <div class="box-body">
        <table id="assetlocation" class='table data-table table-striped table-bordered table-responsive'>
            <thead>
                <tr>
                    <th><?= gettext('location ID') ?></th>
                    <th><?= gettext('location Name') ?></th>
                    <th><?= gettext('location Code') ?></th>
                    <th><?= gettext('Action ') ?></th>
                </tr>
            </thead>

            <tbody>

                <?php
                while ($row = mysqli_fetch_assoc($result)) {
                ?>
                    <tr>
                        <td><?php echo $row['locationID'] ?></td>
                        <td><?php echo $row['location'] ?></td>
                        <td><?php echo $row['locationCode'] ?></td>

                        <td>
                            <a href="Assetlocation.php?edit=<?php echo $row['locationID']; ?>" class="btn btn-primary" name="edit">Edit</a>

                            <form style="display:inline-block" name="Deletelocation" action="Assetlocation.php" method="POST">
                                <input type="hidden" name="locationID" value="<?= $row['locationID']; ?>">
                                <button type="submit" name="Action" title="<?= gettext('Delete') ?>" data-tooltip value="Delete" class="btn btn-danger" onClick="return confirm('Are you sure you want to DELETE location ID: <?= $row['locationID']; ?>')">
                                    <i class='fa fa-trash'></i>
                                </button>
                            </form>
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