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

// Get the assetID out of the querystring
if (array_key_exists('assetID', $_GET)) {
    $assetID = InputUtils::LegacyFilterInput($_GET['assetID'], 'int');
} else {
    $assetID = 0;
}

//DB fields
if (isset($_POST['SaveAsset'])) {
    $sassetName = InputUtils::LegacyFilterInput($_POST['assetName']);
    $smake = InputUtils::LegacyFilterInput($_POST['make']);
    $sassetCondition = InputUtils::LegacyFilterInput($_POST['assetCondition']);
    $sassetDescription = InputUtils::LegacyFilterInput($_POST['assetDescription']);
    $sassetCategory = InputUtils::LegacyFilterInput($_POST['assetCategory']);
    $bassetFile = InputUtils::LegacyFilterInput($_POST['assetFile']);
    $spurchaseDate = InputUtils::LegacyFilterInput($_POST['purchaseDate']);
    $spurchaseDate = str_replace('/', '-', $spurchaseDate);
    $spurchaseDate = date('Y-m-d', strtotime($spurchaseDate));

    //New asset add
    if ($assetID == 0) {
        $sSQL = "INSERT INTO assets(assetName, make, assetCondition, assetDescription, assetCategory, assetFile, purchaseDate)
            VALUES('" . $sassetName . "', '" . $smake . "', '" . $sassetCondition . "', '" . $sassetDescription . "', '" . $sassetCategory . "', '" . $bassetFile . "', '" . $spurchaseDate . "')";
    }

    //Execute the SQL
    RunQuery($sSQL);
    
} elseif (isset($_GET['edit'])) {
    $assetID = $_GET['edit'];

    $sSQL = "SELECT * FROM assets where assetID='$assetID'";
    $result = RunQuery($sSQL);

    $row = mysqli_fetch_array($result);
    extract($row);

    $sassetName = $assetName;
    $smake = $make;
    $sassetCondition = $assetCondition;
    $sassetCategory =  $assetCategory;
    $sassetDescription = $assetDescription;
    $bassetFile = $assetFile;
    $spurchaseDate = $purchaseDate;

} elseif (isset($_POST['Update'])) {
    $assetID = InputUtils::LegacyFilterInput($_POST['assetID'], 'int');
    $sassetName = $_POST['assetName'];
    $smake = $_POST['make'];
    $sassetCondition = $_POST['assetCondition'];
    $sassetDescription = $_POST['assetDescription'];
    $sassetCategory =  $_POST['assetCategory'];
    $bassetFile = $_POST['assetFile'];
    $spurchaseDate = $_POST['purchaseDate'];
    $sreassigned = $_POST['reassigned'];

    $sSQL = "UPDATE assets SET assetName = '" . $sassetName . "', make = '" . $smake . "' ,   assetCondition = '" . $sassetCondition . "', assetCategory = '" . $sassetCategory . "' , assetDescription = '" . $sassetDescription . "', assetFile = '" . $bassetFile . "', purchaseDate = '" . $spurchaseDate . "'
        WHERE assetID = '$assetID' LIMIT 1 ";

    RunQuery($sSQL);
}


?>

<form method="post" action="AssetEditor.php" name="AssetEditor" enctype="multipart/form-data">
    <input type="hidden" name="assetID" value="<?= ($assetID) ?>">
    <div class="box box-info clearfix">
        <div class="box-header">
            <h3 class="box-title"><?= gettext('Add Assets') ?></h3>
        </div>

        <div class="box-body">
            <div class="form-group">
                <div class="row">
                    <div class="col-md-6">
                        <label for="Asset Name"><?= gettext('Asset Name') ?>:</label>
                        <input type="text" name="assetName" id="assetName" value="<?= ($sassetName) ?>" placeholder="<?= htmlentities(stripslashes($sassetName), ENT_NOQUOTES, 'UTF-8') ?>" class="form-control">
                    </div>
                </div>
                <p />

                <div class="row">
                    <div class="col-md-6">
                        <label for="Make"><?= gettext('Make') ?>:</label>
                        <input type="text" name="make" id="make" value="<?= ($smake) ?>" placeholder="<?= htmlentities(stripslashes($smake), ENT_NOQUOTES, 'UTF-8') ?>" class="form-control">
                    </div>
                </div>
                <p />

                <div class="row">
                    <div class="col-md-6">
                        <label for="Asset Condition"><?= gettext('Asset Condition') ?>:</label>
                        <input type="text" name="assetCondition" id="assetCondition" value="<?= ($sassetCondition) ?>" placeholder="<?= htmlentities(stripslashes($sassetCondition), ENT_NOQUOTES, 'UTF-8') ?>" class="form-control">
                    </div>
                </div>
                <p />

                <div class="row">
                    <div class="col-md-6">
                        <label for="Asset Description"><?= gettext('Asset Description') ?>:</label>
                        <input type="text" name="assetDescription" id="assetDescription" value="<?= ($sassetDescription) ?>" placeholder="<?= htmlentities(stripslashes($sassetDescription), ENT_NOQUOTES, 'UTF-8') ?>" class="form-control">
                    </div>
                </div>
                <p />

                <div class="row pb-3 ">
                    <div class="col-md-6">
                        <label for="Asset Category"><?= gettext('Asset Category') ?>:</label>
                        <select name='assetCategory' id="assetCategory" value="<?php echo $row['assetCategory'] ?>" class='form-control'>
                            <option><?= gettext('Select Category'); ?></option>
                            <?php

                            $sSQL = "SELECT * FROM asset_category WHERE categoryDeleted='False'";
                            $rsassetCategory = RunQuery($sSQL);
                            while ($aRow = mysqli_fetch_array($rsassetCategory)) {
                                extract($aRow);
                                echo "<option value='" . $categoryName . "' >" . $categoryName . '</option>';
                            } ?>
                        </select>

                    </div>
                </div>
                <p />

                <div class="row">
                    <div class="col-md-6">
                        <label for="Asset Files"><?= gettext('Asset Files') ?>:</label>
                        <input type="file" name="assetfile" id="assetFiles" value="<?= ($bassetFile) ?>" placeholder="<?= htmlentities(stripslashes($bassetFile), ENT_NOQUOTES, 'UTF-8') ?>" class="form-control">
                    </div>
                </div>
                <p />

                <div class="row">
                    <div class="col-md-6">
                        <label for="Purchase Date"><?= gettext('Purchase Date') ?>:</label>
                        <input type="date" name="purchaseDate" id="purchaseDate" value="<?= ($spurchaseDate) ?>" placeholder="<?= htmlentities(stripslashes($spurchaseDate), ENT_NOQUOTES, 'UTF-8') ?>" class="form-control">
                    </div>
                </div>
                <p />

            </div>

            <input type="submit" class="btn btn-primary" id="save" value="Save" name="SaveAsset">
            <?php if (AuthenticationManager::GetCurrentUser()->isAddRecordsEnabled()) {
                echo '<input type="submit" class="btn btn-primary" value="' . gettext('Update') . '" name="Update">';
            } ?>
            <a href="AssetList.php" class="btn btn-primary" value="<?= gettext('Go to Asset List') ?>">Go to Asset List</a>
        </div>

</form>

<?php require 'Include/Footer.php' ?>