<?php

//Include the function library
require 'Include/Config.php';
require 'Include/Functions.php';
require 'Include/CanvassUtilities.php';

//Add classes
use ChurchCRM\Utils\InputUtils;
use ChurchCRM\Authentication\AuthenticationManager;

//Set page title
$sPageTitle = gettext('Assign Assets');

if (!AuthenticationManager::GetCurrentUser()->isAddRecordsEnabled()) {
    header('Location: AssetList.php');
}

require 'Include/Header.php';

//Get asset ID from the query string
if (array_key_exists('assetID', $_GET)) {
    $assetID = InputUtils::LegacyFilterInput($_GET['assetID'], 'int');
} else {
    $assetID = 0;
}


//Add fields
if (isset($_POST['Assign'])) {
    $sassetName = InputUtils::LegacyFilterInput($_POST['assetName']);
    $sassigned_to = InputUtils::LegacyFilterInput($_POST['assigned_to']);
    $sassigned_by = InputUtils::LegacyFilterInput($_POST['assigned_by']);
    $sasset_description = InputUtils::LegacyFilterInput($_POST['sasset_description']);
    $sassign_date = InputUtils::LegacyFilterInput($_POST['assign_date']);
    $sassign_date = str_replace('/', '-', $sassign_date);
    $sassign_date = date('Y-m-d', strtotime($sassign_date));

    $sreturn_date = InputUtils::LegacyFilterInput($_POST['return_date']);
    $sreturn_date = str_replace('/', '-', $sreturn_date);
    $sreturn_date = date('Y-m-d', strtotime($sreturn_date));


    //New asset assign
    if ($assignment_id  == 0) {
        $sSQL = "INSERT INTO asset_assignment(assetName, assigned_to, assigned_by, sasset_description, assign_date, return_date)
                VALUES('" . $sassetName . "', '" . $sassigned_to . "', '" . $sassigned_by . "', '" . $sasset_description . "', '" . $sassign_date . "', '" . $sreturn_date . "')";
    }

    //Execute the SQL
    RunQuery($sSQL);


} elseif (isset($_GET['reassign'])) {  // Reasign an asset
    $assignment_id  = $_GET['reassign'];

    $sSQL = "SELECT * FROM asset_assignment where assignment_id ='$assignment_id '";
    $result = RunQuery($sSQL);
    // $resultCheck = mysqli_num_rows($result);

    $row = mysqli_fetch_array($result);
    extract($row);

    $sassetName = $assetName;
    $sassigned_to = $assigned_to;
    $sassigned_by = $assigned_by;
    $sasset_description = $sasset_description;
    $sassign_date = $assign_date;
    $sreturn_date = $return_date;

} elseif (isset($_POST['SaveReassign'])) {
    $assignment_id  = InputUtils::LegacyFilterInput($_POST['assignment_id '], 'int');
    $sassetName = $_POST['assetName'];
    $sassigned_to = $_POST['assigned_to'];
    $sassigned_by = $_POST['assigned_by'];
    $sasset_description = $_POST['sasset_description'];
    $sassign_date = $_POST['assign_date'];
    $sreturn_date = $_POST['return_date'];

    $sSQL = "UPDATE asset_assignment SET assetName = '" . $sassetName . "', assigned_to = '" . $sassigned_to . "',  assigned_by = '" . $sassigned_by . "',  asset_description = '" . $sasset_description . "',  assign_date = '" . $sassign_date . "', return_date = '" . $sreturn_date . "', reassign = 'TRUE'
    WHERE assignment_id  = '$assignment_id ' LIMIT 1
    ";

    RunQuery($sSQL);
}

?>
<div id="assignasset">

    <form method="post" action="AssetsAssign.php">
        <input type="hidden" name="assignment_id " value="<?= ($assignment_id ) ?>">
        <div class="box box-info clearfix">

            <div class="box-body">
                <div class="form-group">

                    <div class="row">
                        <div class="col-md-6">
                            <label for="Asset_name"><?= gettext('Asset Name') ?>:</label>
                            <select name='assetName' id="assetName" value="<?php echo $row['assetName'] ?>"
                                class='form-control'>
                                <option><?= gettext('Select asset'); ?></option>

                                <?php
                        $sSQL = 'SELECT assetName FROM assets WHERE assetID = "$assetID"';
                        $rsasset = RunQuery($sSQL);
                        while ($aRow = mysqli_fetch_array($rsasset)) {
                            extract($aRow);
                            echo "<option value='" . $assetID . "' >" . $assetName . '</option>';
                        } ?>

                            </select>
                        </div>
                    </div>

                    <div class="row pt-3 pb-3 ">
                        <div class="col-md-6">
                            <label for="Assigned To"><?= gettext('Assigned To') ?>:</label>
                            <select name='' id="assigned_to" value="<?php echo $row['assigned_to'] ?>"
                                class='form-control'>
                                <option><?= gettext('Select staff member'); ?></option>
                                <?php
                        $sSQL = 'SELECT Concat (per_FirstName, " ", per_LastName,  " ", per_MiddleName) AS per_fullName FROM person_per ';
                        $rsstaffmember = RunQuery($sSQL);
                        while ($aRow = mysqli_fetch_array($rsstaffmember)) {
                            extract($aRow);
                            echo "<option value='" . $per_fullName . "' >" . $per_fullName .  '</option>';
                        } ?>
                            </select>

                        </div>
                    </div>
                    <p />

                    <div class="row pt-3 pb-3 ">
                        <div class="col-md-6">
                            <label for="Assigned By"><?= gettext('Assigned By') ?>:</label>
                            <select name='assigned_by' id="assigned_by" value="<?php echo $row['assigned_by'] ?>"
                                class='form-control'>
                                <option><?= gettext('Select admin'); ?></option>

                                <?php
                        $sSQL = 'SELECT * FROM person_per WHERE per_LastName = "Admin"';
                        $rsadmin = RunQuery($sSQL);
                        while ($aRow = mysqli_fetch_array($rsadmin)) {
                            extract($aRow);
                            echo "<option value='" . $per_LastName . "' >" . $per_LastName . '</option>';
                        } ?>

                            </select>

                        </div>
                    </div>
                    <p />

                    <div class="row pb-3">
                        <div class="col-md-6">
                            <label for="Asset Description"><?= gettext('Asset Description') ?>:</label>
                            <textarea name="asset_description" id="asset_description" placeholder="Asset Description"
                                value="<?= htmlentities(stripslashes($sasset_description), ENT_NOQUOTES, 'UTF-8') ?>"
                                class="form-control"></textarea>
                        </div>
                    </div>
                    <p />

                    <div class="row pb-3">
                        <div class="col-md-6">
                            <label for="Assign Date"><?= gettext('Assign Date') ?>:</label>
                            <input type="date" name="assign_date" id="assign_date"
                                value="<?= htmlentities(stripslashes($sassign_date), ENT_NOQUOTES, 'UTF-8') ?>"
                                class="form-control">
                        </div>
                    </div>
                    <p />

                    <div class="row pb-3">
                        <div class="col-md-6">
                            <label for="Return Date"><?= gettext('Return Date') ?>:</label>
                            <input type="date" name="return_date" id="return_date"
                                value="<?= htmlentities(stripslashes($sreturn_date), ENT_NOQUOTES, 'UTF-8') ?>"
                                class="form-control">
                        </div>
                    </div>
                    <p />

                </div>
                <input type="submit" class="btn btn-primary" id="AssignSaveButton" value="<?= gettext('Assign') ?>"
                    name="Assign">
                <?php if (AuthenticationManager::GetCurrentUser()->isAddRecordsEnabled()) {
            echo '<input type="submit" class="btn btn-primary" value="' . gettext('Reassign') . '" name="SaveReassign">';
        } ?>
                <a href="AssetsAssignList.php" class="btn btn-primary" value="<?= gettext('Go to Assignment List') ?>">Go
                    to Assignment List</a>

            </div>
    </form>
</div>

<?php require 'Include/Footer.php' ?>