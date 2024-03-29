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
if (array_key_exists('assignment_id', $_GET)) {
    $assignment_id  = InputUtils::LegacyFilterInput($_GET['assignment_id'], 'int');
} else {
    $assignment_id = 0;
}

if(isset($_GET['assign'])) {
    $asset_id = $_GET['assign'];
}

//Add fields
if (isset($_POST['Assign'])) {
    $asset_id = InputUtils::LegacyFilterInput($_POST['asset_id']);
    $sassigned_to = InputUtils::LegacyFilterInput($_POST['assigned_to']);
    $sassigned_by = InputUtils::LegacyFilterInput($_POST['assigned_by']);
    $sasset_condition = InputUtils::LegacyFilterInput($_POST['asset_condition']);
    $sassign_date = InputUtils::LegacyFilterInput($_POST['assign_date']);
    $sassign_date = str_replace('/', '-', $sassign_date);
    $sassign_date = date('Y-m-d', strtotime($sassign_date));

    $sreturn_date = InputUtils::LegacyFilterInput($_POST['return_date']);
    $sreturn_date = str_replace('/', '-', $sreturn_date);
    $sreturn_date = date('Y-m-d', strtotime($sreturn_date));


    //New asset assign
    if ($assignment_id == 0) {
        $sSQL = "INSERT INTO asset_assignment(asset_id, assigned_to, assigned_by, asset_condition, assign_date, return_date)
                VALUES('". $asset_id ."', '" . $sassigned_to . "', '" . $sassigned_by . "', '" . $sasset_condition . "', '" . $sassign_date . "', '" . $sreturn_date . "')";
    }

    //Execute the SQL
    $result = RunQuery($sSQL);
    
} 
?>


<div id="assignasset">

    <form method="post" action="AssetsAssign.php">
        <input type="hidden" name="assignment_id" value="<?= ($assignment_id) ?>">
        <div class="box box-info clearfix">

            <div class="box-body">
                <div class="form-group">

                    <div class="row">
                        <div class="col-md-6">
                            <label for="Asset Name"><?= gettext('Asset Name') ?>:</label>
                            <select name='asset_id' id="asset_id" value="<?php echo $row['asset_id'] ?>"
                                class='form-control'>
                                <option><?= gettext('Select Asset Name'); ?></option>

                                <?php
                                        $sSQL = "SELECT asset_name FROM assets WHERE asset_id='$asset_id'";
                                        $rsasset_name = RunQuery($sSQL);
                                        while ($aRow = mysqli_fetch_array($rsasset_name)) {
                                        extract($aRow);
                                        echo "<option value='" . $asset_id . "' >" . $asset_name . '</option>';
                                        }                             
                                ?>

                            </select>
                        </div>
                    </div>

                    <div class="row pt-3 pb-3 ">
                        <div class="col-md-6">
                            <label for="Assigned To"><?= gettext('Assigned To') ?>:</label>
                            <select name='assigned_to' id="assigned_to" value="<?php echo $row['assigned_to'] ?>"
                                class='form-control'>
                                <option><?= gettext('Select staff member'); ?></option>

                                <?php
                                    $sSQL = 'SELECT Concat (per_FirstName, " ", per_LastName,  " ", per_MiddleName) AS per_fullName FROM person_per ';
                                    $rsstaffmember = RunQuery($sSQL);
                                    while ($aRow = mysqli_fetch_array($rsstaffmember)) {
                                        extract($aRow);
                                        echo "<option value='" . $per_fullName . "' >" . $per_fullName .  '</option>';
                                    } 
                                ?>

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
                                    } 
                                ?>

                            </select>
                        </div>
                    </div>
                    <p />

                    <div class="row pb-3">
                        <div class="col-md-6">
                            <label for="Asset condition"><?= gettext('Asset condition') ?>:</label>
                            <textarea name="asset_condition" id="asset_condition" placeholder="Asset condition"
                                value="<?= htmlentities(stripslashes($sasset_condition), ENT_NOQUOTES, 'UTF-8') ?>"
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

                <a href="AssetsAssignList.php" class="btn btn-primary"
                    value="<?= gettext('Go to Assignment List') ?>">Go
                    to Assignment List</a>

            </div>
    </form>
</div>

<?php require 'Include/Footer.php' ?>