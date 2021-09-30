<?php
//Include the function library
require 'Include/Config.php';
require 'Include/Functions.php';
require 'Include/CanvassUtilities.php';

//Utility classes
use ChurchCRM\Utils\InputUtils;
use ChurchCRM\Authentication\AuthenticationManager;

//Set page title
$sPageTitle = gettext('Asset Editor');

if (!AuthenticationManager::GetCurrentUser()->isAddRecordsEnabled()) {
    header('Location: AssetList.php');
}

require 'Include/Header.php';

// Get the asset_id out of the querystring
if (array_key_exists('asset_id', $_GET)) {
    $asset_id = InputUtils::LegacyFilterInput($_GET['asset_id'], 'int');
} else {
    $asset_id = 0;
}

//DB fields
if (isset($_POST['SaveAsset'])) {
    $sasset_name = InputUtils::LegacyFilterInput($_POST['asset_name']);
    $sasset_make  = InputUtils::LegacyFilterInput($_POST['asset_make']);
    $sasset_condition = InputUtils::LegacyFilterInput($_POST['asset_condition']);
    $sasset_description = InputUtils::LegacyFilterInput($_POST['asset_description']);
    $sasset_category = InputUtils::LegacyFilterInput($_POST['asset_category']);
    $basset_file = InputUtils::LegacyFilterInput($_POST['asset_file']);
    $spurchase_date = InputUtils::LegacyFilterInput($_POST['purchase_date']);
    $spurchase_date = str_replace('/', '-', $spurchase_date);
    $spurchase_date = date('Y-m-d', strtotime($spurchase_date));

    //New asset add
    if ($asset_id == 0) {
        $sSQL = "INSERT INTO assets(asset_name, asset_make, asset_condition, asset_description, asset_category, asset_file, purchase_date)
            VALUES('" . $sasset_name . "', '" . $sasset_make  . "', '" . $sasset_condition . "', '" . $sasset_description . "', '" . $sasset_category . "', '" . $basset_file . "', '" . $spurchase_date . "')";
    }

    //Execute the SQL
    RunQuery($sSQL);
    
} elseif (isset($_GET['edit'])) {
    $asset_id = $_GET['edit'];

    $sSQL = "SELECT * FROM assets where asset_id='$asset_id'";
    $result = RunQuery($sSQL);

    $row = mysqli_fetch_array($result);
    extract($row);

    $sasset_name = $asset_name;
    $sasset_make  = $asset_make;
    $sasset_condition = $asset_condition;
    $sasset_category =  $asset_category;
    $sasset_description = $asset_description;
    $basset_file = $asset_file;
    $spurchase_date = $purchase_date;

} elseif (isset($_POST['Update'])) {
    $asset_id = InputUtils::LegacyFilterInput($_POST['asset_id'], 'int');
    $sasset_name = $_POST['asset_name'];
    $sasset_make  = $_POST['asset_make'];
    $sasset_condition = $_POST['asset_condition'];
    $sasset_description = $_POST['asset_description'];
    $sasset_category =  $_POST['asset_category'];
    $basset_file = $_POST['asset_file'];
    $spurchase_date = $_POST['purchase_date'];
    $sreassigned = $_POST['reassigned'];

    // Calculate asset quantity


    $sSQL = "UPDATE assets SET asset_name = '" . $sasset_name . "', asset_make  = '" . $sasset_make . "' , asset_condition = '" . $sasset_condition . "', asset_category = '" . $sasset_category . "' , asset_description = '" . $sasset_description . "', asset_file = '" . $basset_file . "', purchase_date = '" . $spurchase_date . "'
        WHERE asset_id = '$asset_id' LIMIT 1 ";

    RunQuery($sSQL);
}

?>

<<<<<<< HEAD <form method="post" action="AssetsEditor.php" name="AssetEditor" enctype="multipart/form-data">
    =======
    <form method="post" action="AssetEditor.php" name="AssetEditor" enctype="multipart/form-data">
        >>>>>>> LilianMathu-addAssets
        <input type="hidden" name="asset_id" value="<?= ($asset_id) ?>">
        <div class="box box-info clearfix">
            <div class="box-header">
                <h3 class="box-title"><?= gettext('Add Assets') ?></h3>
            </div>

            <div class="box-body">
                <div class="form-group">
                    <div class="row">
                        <div class="col-md-6">
                            <label for="Asset Name"><?= gettext('Asset Name') ?>:</label>
                            <input type="text" name="asset_name" id="asset_name" value="<?= ($sasset_name) ?>"
                                placeholder="<?= htmlentities(stripslashes($sasset_name), ENT_NOQUOTES, 'UTF-8') ?>"
                                class="form-control" required>
                        </div>
                    </div>
                    <p />

                    <div class="row">
                        <div class="col-md-6">
                            <label for="Asset Make"><?= gettext('Asset Make') ?>:</label>
                            <input type="text" name="asset_make" id="asset_make" value="<?= ($sasset_make) ?>"
                                placeholder="<?= htmlentities(stripslashes($sasset_make), ENT_NOQUOTES, 'UTF-8') ?>"
                                class="form-control" required>
                        </div>
                    </div>
                    <p />

                    <div class="row">
                        <div class="col-md-6">
                            <label for="Asset Condition"><?= gettext('Asset Condition') ?>:</label>
                            <input type="text" name="asset_condition" id="asset_condition"
                                value="<?= ($sasset_condition) ?>"
                                placeholder="<?= htmlentities(stripslashes($sasset_condition), ENT_NOQUOTES, 'UTF-8') ?>"
                                class="form-control" required>
                        </div>
                    </div>
                    <p />

                    <div class="row">
                        <div class="col-md-6">
                            <label for="Asset Description"><?= gettext('Asset Description') ?>:</label>
                            <textarea type="text" name="asset_description" id="asset_description"
                                value="<?= ($sasset_description) ?>"
                                placeholder="<?= htmlentities(stripslashes($sasset_description), ENT_NOQUOTES, 'UTF-8') ?>"
                                class="form-control"></textarea>
                        </div>
                    </div>
                    <p />

                    <div class="row pb-3 ">
                        <div class="col-md-6">
                            <label for="Asset Category"><?= gettext('Asset Category') ?>:</label>
                            <select name='asset_category' id="asset_category"
                                value="<?php echo $row['asset_category'] ?>" class='form-control'>
                                <option><?= gettext('Select Category'); ?></option>
                                <?php

                            $sSQL = "SELECT * FROM asset_category WHERE category_deleted='False'";
                            $rsasset_category = RunQuery($sSQL);
                            while ($aRow = mysqli_fetch_array($rsasset_category)) {
                                extract($aRow);
                                echo "<option value='" . $category_name . "' >" . $category_name . '</option>';
                            } ?>
                            </select>

                        </div>
                    </div>
                    <p />

                    <div class="row">
                        <div class="col-md-6">
                            <label for="Asset Files"><?= gettext('Asset Files') ?>:</label>
                            <input type="file" name="asset_file" id="asset_files" value="<?= ($basset_file) ?>"
                                placeholder="<?= htmlentities(stripslashes($basset_file), ENT_NOQUOTES, 'UTF-8') ?>"
                                class="form-control">
                        </div>
                    </div>
                    <p />

                    <div class="row">
                        <div class="col-md-6">
                            <label for="Purchase Date"><?= gettext('Purchase Date') ?>:</label>
                            <input type="date" name="purchase_date" id="purchase_date" value="<?= ($spurchase_date) ?>"
                                placeholder="<?= htmlentities(stripslashes($spurchase_date), ENT_NOQUOTES, 'UTF-8') ?>"
                                class="form-control" required>
                        </div>
                    </div>
                    <p />

                </div>

                <input type="submit" class="btn btn-primary" id="save" value="Save" name="SaveAsset">
                <?php if (AuthenticationManager::GetCurrentUser()->isAddRecordsEnabled()) {
                echo '<input type="submit" class="btn btn-primary" value="' . gettext('Update') . '" name="Update">';
            } ?>
                <a href="AssetList.php" class="btn btn-primary" value="<?= gettext('Go to Asset List') ?>">Go to Asset
                    List</a>
            </div>

    </form>

    <?php require 'Include/Footer.php' ?>