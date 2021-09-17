<?php
//Include the function library
require 'Include/Config.php';
require 'Include/Functions.php';
require 'Include/CanvassUtilities.php';

//Utility classes
use ChurchCRM\Utils\InputUtils;
use ChurchCRM\Authentication\AuthenticationManager;

//Set page title
$sPageTitle = gettext('Asset Inventory');

if (!AuthenticationManager::GetCurrentUser()->isAddRecordsEnabled()) {
    header('Location: AssetInventory.php');
}

require 'Include/Header.php';

// Get the assetID out of the querystring
if(isset($_GET['inventory'])) {
    $asset_id = $_GET['inventory'];
}

//DB fields
if (isset($_POST['SaveInventory'])) {
    $asset_id  = InputUtils::LegacyFilterInput($_POST['asset_id']);
    $sserial_number = InputUtils::LegacyFilterInput($_POST['serial_number']);
    $iasset_quantity = InputUtils::LegacyFilterInput($_POST['asset_quantity']);
    $iunit_cost = InputUtils::LegacyFilterInput($_POST['unit_cost']);
    $itotal_cost = InputUtils::LegacyFilterInput($_POST['total_cost']);
    $slocation_code = InputUtils::LegacyFilterInput($_POST['location_code']);
    $smovement_type = InputUtils::LegacyFilterInput($_POST['movement_type']);
    $smovement_comment = InputUtils::LegacyFilterInput($_POST['movement_comment']);
    $calculated_cost = $iunit_cost * $iasset_quantity;

    //New asset add
    if ($inventory_id == 0) {
        $sSQL = "INSERT INTO asset_inventory(asset_id, serial_number, asset_quantity, unit_cost, total_cost, location_code, movement_type, movement_comment)
            VALUES('" . $asset_id . "', '" . $sserial_number  . "', '".$iasset_quantity."', '" . $iunit_cost . "', '" . $calculated_cost . "', '" . $slocation_code . "', '" . $smovement_type . "', '".$movement_comment."')";
    }

    //Execute the SQL
    RunQuery($sSQL);

   
    
} elseif (isset($_GET['edit'])) {
    $inventory_id = $_GET['edit'];

    $sSQL = "SELECT * FROM asset_inventory where inventory_id='$inventory_id'";
    $result = RunQuery($sSQL);

    $row = mysqli_fetch_array($result);
    extract($row);

    $sassetName = $assetName;
    $sserial_number = $serial_number;
    $iasset_quantity = $asset_quantity;
    $iunit_cost = $unit_cost;
    $itotal_cost = $calculated_cost;
    $slocation_code = $location_code;
    $smovement_type = $movement_type;
    $smovement_comment = $movement_comment;

} elseif (isset($_POST['Update'])) {
    $inventory_id = InputUtils::LegacyFilterInput($_POST['inventory_id'], 'int');
    $sassetName = $_POST['assetName'];
    $sserial_number = $_POST['serial_number'];
    $iasset_quantity = $_POST['asset_quantity'];
    $iunit_cost = $_POST['unit_cost'];
    $calculated_cost =  $_POST['total_cost'];
    $slocation_code = $_POST['location_code'];
    $smovement_type = $_POST['movement_type'];
    $smovement_comment = $_POST['movement_comment'];

    $sSQL = "UPDATE assets SET asset_inventory = '" . $sassetName . "', serial_number = '" . $sserial_number . "' ,   asset_quantity = '" . $iasset_quantity . "',  unit_cost = '" . $iunit_cost . "', total_cost = '".$calculated_cost."', location_code = '" . $slocation_code . "', movement_type = '" . $smovement_type . "', movement_comment = '". $smovement_comment ."' 
        WHERE inventory_id = '$inventory_id' LIMIT 1 ";

    RunQuery($sSQL);
}

?>

<form method="post" action="AssetInventoryEditor.php" name="AssetInventoryEditor" enctype="multipart/form-data">
    <input type="hidden" name="assetID" value="<?= ($assetID) ?>">
    <input type="hidden" name="inventory_id" value="<?= ($inventory_id) ?>">

    <div class="box box-info clearfix">
        <div class="box-header">
            <h3 class="box-title"><?= gettext('Add Assets') ?></h3>
        </div>

        <div class="box-body">
            <div class="form-group">
                <div class="row">
                    <div class="col-md-6">
                        <label for="Asset Name"><?= gettext('Asset Name') ?>:</label>
                        <select name='asset_id' id="asset_id" value="<?php echo $row['asset_id'] ?>"
                            class='form-control'>
                            <option><?= gettext('Select Asset Name'); ?></option>

                            <?php
                                        $sSQL = "SELECT * FROM assets WHERE asset_id='$asset_id'";
                                        $rsasset_name = RunQuery($sSQL);
                                        while ($aRow = mysqli_fetch_array($rsasset_name)) {
                                        extract($aRow);
                                        echo "<option value='" . $asset_id . "' >" . $asset_name . '</option>';
                                        }                         
                                    
                            ?>

                        </select>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <label for="Serial Number"><?= gettext('Serial Number') ?>:</label>
                        <input type="text" name="serial_number" id="serial_number" value="<?= ($sserial_number) ?>"
                            placeholder="<?= htmlentities(stripslashes($sserial_number), ENT_NOQUOTES, 'UTF-8') ?>"
                            class="form-control">
                    </div>
                </div>
                <p />

                <div class="row">
                    <div class="col-md-6">
                        <label for="Asset Quantity"><?= gettext('Asset Quantity') ?>:</label>
                        <input type="text" name="asset_quantity" id="asset_quantity" value="<?= ($iasset_quantity) ?>"
                            placeholder="<?= htmlentities(stripslashes($iasset_quantity), ENT_NOQUOTES, 'UTF-8') ?>"
                            class="form-control">
                    </div>
                </div>
                <p />

                <div class="row">
                    <div class="col-md-6">
                        <label for="Unit Cost"><?= gettext('Unit Cost') ?>:</label>
                        <input type="text" name="unit_cost" id="unit_cost" value="<?= ($iunit_cost) ?>"
                            placeholder="<?= htmlentities(stripslashes($iunit_cost), ENT_NOQUOTES, 'UTF-8') ?>"
                            class="form-control">
                    </div>
                </div>
                <p />

                <div class="row">
                    <div class="col-md-6">
                        <label for="Total Cost"><?= gettext('Total Cost') ?>:</label>
                        <input type="text" name="total_cost" id="total_cost" value="<?= ($calculated_cost) ?>"
                            readonly="true"
                            placeholder="<?= htmlentities(stripslashes($itotal_cost), ENT_NOQUOTES, 'UTF-8') ?>"
                            class="form-control">
                    </div>
                </div>
                <p />

                <div class="row pb-3 ">
                    <div class="col-md-6">
                        <label for="Asset Location"><?= gettext('Asset Location') ?>:</label>
                        <select name='location_code' id="location_code" value="<?php echo $row['location_code'] ?>"
                            class='form-control'>
                            <option><?= gettext('Select Location'); ?></option>
                            <?php

                            $sSQL = "SELECT * FROM asset_location WHERE location_deleted='False'";
                            $rsasset_location = RunQuery($sSQL);
                            while ($aRow = mysqli_fetch_array($rsasset_location)) {
                                extract($aRow);
                                echo "<option value='" . $location_code . "' >" . $location_code . '</option>';
                            } ?>
                        </select>

                    </div>
                </div>
                <p />

                <div class="row">
                    <div class="col-md-6 mt-3 mb-3">
                        <label for="Movement Type"><?= gettext('Movement Type') ?>:</label>
                        <select name="movement_type" id="movement_type" value="<?= ($smovement_type) ?>">
                            <option value="0">Choose movement Type</option>
                            <option value="1">Incoming</option>
                            <option value="2">Outgoing</option>
                        </select>
                    </div>
                </div>
                <p />

                <div class="row">
                    <div class="col-md-6">
                        <label for="Movement Comment"><?= gettext('Movement Comment') ?>:</label>
                        <input type="text" name="movement_comment" id="movement_comment"
                            value="<?= ($smovement_comment) ?>"
                            placeholder="<?= htmlentities(stripslashes($smovement_comment), ENT_NOQUOTES, 'UTF-8') ?>"
                            class="form-control">
                    </div>
                </div>
                <p />

            </div>

            <input type="submit" class="btn btn-primary" id="save" value="Save" name="SaveInventory">
            <?php if (AuthenticationManager::GetCurrentUser()->isAddRecordsEnabled()) {
                echo '<input type="submit" class="btn btn-primary" value="' . gettext('Update') . '" name="Update">';
            } ?>
            <a href="AssetInventoryList.php" class="btn btn-primary" value="<?= gettext('Go to Inventory List') ?>">Go
                to
                Inventory
                List</a>
        </div>

</form>

<?php require 'Include/Footer.php' ?>