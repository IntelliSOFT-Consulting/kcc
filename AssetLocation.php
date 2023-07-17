<?php
require 'Include/Config.php';
require 'Include/Functions.php';

use ChurchCRM\Utils\InputUtils;
use ChurchCRM\Authentication\AuthenticationManager;

//Set page title
$sPageTitle = gettext('Asset Location');


require 'Include/Header.php';

// Get the location_id out of the querystring
if (array_key_exists('location_id', $_GET)) {
    $location_id = InputUtils::LegacyFilterInput($_GET['location_id'], 'int');
} else {
    $location_id = 0;
}


//Add a location
if (isset($_POST['AddLocation'])) {
    $slocation_name = InputUtils::LegacyFilterInput($_POST['location_name']);
    $slocation_code = InputUtils::LegacyFilterInput($_POST['location_code']);


    if ($location_id == 0) {
        $sSQL = "INSERT INTO asset_location (location_name, location_code)
                VALUES('" . $slocation_name . "', '" . $slocation_code . "')";
    }
    
    //Execute the SQL
    RunQuery($sSQL);

} elseif (isset($_GET['edit'])) {
    $location_id = $_GET['edit'];

    $sSQL = "SELECT * FROM asset_location where location_id='$location_id'";
    $result = RunQuery($sSQL);

    $row = mysqli_fetch_array($result);
    extract($row);

    $slocation_name = $location_name;
    $slocation_code = $location_code;

} elseif (isset($_POST['Update'])) {
    $location_id = InputUtils::LegacyFilterInput($_POST['location_id'], 'int');

    $slocation_name = $_POST['location_name'];
    $slocation_code = $_POST['location_code'];

    $sSQL = "UPDATE asset_location SET location_name = '" . $slocation_name . "', location_code = '" . $slocation_code . "'
    WHERE location_id = '$location_id' LIMIT 1 ";

    RunQuery($sSQL);
    
}


// display a list of all categories
$sSQL = "SELECT * from asset_location WHERE locationDeleted='False'";
$result = RunQuery($sSQL);
$resultCheck = mysqli_num_rows($result);

//Delete one location 
if (isset($_GET['delete'])) {
    $location_id = $_GET['delete'];

    $sSQL = "UPDATE asset_location SET locationDeleted = 'True' WHERE location_id='$location_id'  LIMIT 1";
    RunQuery($sSQL);
    header("Location: AssetLocation.php");
}
?>

<!-- form for adding categories -->
<div class="box box-warning clearfix">

    <div class="box-header">
        <h3 class="box-title"><?= gettext('Add New Location') ?></h3>
    </div>

    <form method="post" action="AssetLocation.php">
        <input type="hidden" name="location_id" value="<?= ($location_id) ?>">

        <div class="row">
            <div class="col-md-4 ml-3">
                <label><?= gettext('Location') ?>:</label>
                <input type="text" name="location_name" id="location_name"
                    value="<?= htmlentities(stripslashes($slocation_name), ENT_NOQUOTES, 'UTF-8') ?>"
                    class="form-control">
            </div>

            <div class="col-md-4 ml-3">
                <label><?= gettext('Location Code') ?>:</label>
                <input type="text" name="location_code" id="location_code"
                    value="<?= htmlentities(stripslashes($slocation_code), ENT_NOQUOTES, 'UTF-8') ?>"
                    class="form-control">
            </div>

        </div>

        <div class="ml-5">
            <input type="submit" class="btn btn-primary mt-3" id="AddLocation" value="<?= gettext('Save') ?>"
                name="AddLocation">
            <input type="submit" class="btn btn-primary mt-3" value="<?= gettext('Update') ?>" name="Update">
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
                    <td><?php echo $row['location_id'] ?></td>
                    <td><?php echo $row['location_name'] ?></td>
                    <td><?php echo $row['location_code'] ?></td>

                    <td>
                        <a href="AssetLocation.php?edit=<?php echo $row['location_id']; ?>" class="btn btn-primary"
                            name="edit"><i class='fa fa-pencil'></i></a>

                        <a href="AssetLocation.php?delete=<?php echo $row['location_id']; ?>" class="btn btn-danger"
                            name="delete" id="delete"
                            onClick="return confirm('Sure you want to delete this location? This cannot be undone later.')">
                            <i class="fa fa-trash"></i> </a>
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