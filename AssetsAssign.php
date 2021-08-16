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
    $sassignedTo = InputUtils::LegacyFilterInput($_POST['assignedTo']);
    $sassignedBy = InputUtils::LegacyFilterInput($_POST['assignedBy']);
    $sassetDescription = InputUtils::LegacyFilterInput($_POST['assetDescription']);
    $sassetCondition = InputUtils::LegacyFilterInput($_POST['assetCondition']);
    $sassignDate = InputUtils::LegacyFilterInput($_POST['assignDate']);
    $sassignDate = str_replace('/', '-', $sassignDate);
    $sassignDate = date('Y-m-d', strtotime($sassignDate));

    $sreturnDate = InputUtils::LegacyFilterInput($_POST['returnDate']);
    $sreturnDate = str_replace('/', '-', $sreturnDate);
    $sreturnDate = date('Y-m-d', strtotime($sreturnDate));


    //New asset assign
    if ($assignID == 0) {
        $sSQL = "INSERT INTO assign_assets(assetName, assignedTo, assignedBy, assetDescription, assetCategory, assignDate, returnDate)
                VALUES('" . $sassetName . "', '" . $sassignedTo . "', '" . $sassignedBy . "', '" . $sassetDescription . "', '" . $sassetCategory . "', '" . $sassignDate . "', '" . $sreturnDate . "')";
    }

    //Execute the SQL
    RunQuery($sSQL);


} elseif (isset($_GET['reassign'])) {  // Reasign an asset
    $assignID = $_GET['reassign'];

    $sSQL = "SELECT * FROM assign_assets where assignID='$assignID'";
    $result = RunQuery($sSQL);
    // $resultCheck = mysqli_num_rows($result);

    $row = mysqli_fetch_array($result);
    extract($row);

    $sassetName = $assetName;
    $sassignedTo = $assignedTo;
    $sassignedBy = $assignedBy;
    $sassetDescription = $assetDescription;
    $sassetCategory =  $assetCategory;
    $sassignDate = $assignDate;
    $sreturnDate = $returnDate;

} elseif (isset($_POST['SaveReassign'])) {
    $assignID = InputUtils::LegacyFilterInput($_POST['assignID'], 'int');
    $sassetName = $_POST['assetName'];
    $sassignedTo = $_POST['assignedTo'];
    $sassignedBy = $_POST['assignedBy'];
    $sassetDescription = $_POST['assetDescription'];
    $sassignDate = $_POST['assignDate'];
    $sreturnDate = $_POST['returnDate'];

    $sSQL = "UPDATE assign_assets SET assetName = '" . $sassetName . "', assignedTo = '" . $sassignedTo . "',  assignedBy = '" . $sassignedBy . "',  assetDescription = '" . $sassetDescription . "',  assignDate = '" . $sassignDate . "', returnDate = '" . $sreturnDate . "', reassign = 'TRUE'
    WHERE assignID = '$assignID' LIMIT 1
    ";

    RunQuery($sSQL);
}

?>
<div id="assign_modal">

    <form method="post" action="AssetsIssuance.php">
        <input type="hidden" name="assignID" value="<?= ($assignID) ?>">
        <div class="box box-info clearfix">

            <div class="box-body">
                <div class="form-group">

                    <div class="row pt-3 pb-3 ">
                        <div class="col-md-6">
                            <label for="Assigned To"><?= gettext('Assigned To') ?>:</label>
                            <select name='' id="assignedTo" value="<?php echo $row['assignedTo'] ?>"
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
                            <select name='assignedBy' id="assignedBy" value="<?php echo $row['assignedBy'] ?>"
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
                            <textarea name="assetDescription" id="assetDescription" placeholder="Asset Description"
                                value="<?= htmlentities(stripslashes($sassetDescription), ENT_NOQUOTES, 'UTF-8') ?>"
                                class="form-control"></textarea>
                        </div>
                    </div>
                    <p />

                    <div class="row pb-3">
                        <div class="col-md-6">
                            <label for="Assign Date"><?= gettext('Assign Date') ?>:</label>
                            <input type="date" name="assignDate" id="assignDate"
                                value="<?= htmlentities(stripslashes($sassignDate), ENT_NOQUOTES, 'UTF-8') ?>"
                                class="form-control">
                        </div>
                    </div>
                    <p />

                    <div class="row pb-3">
                        <div class="col-md-6">
                            <label for="Return Date"><?= gettext('Return Date') ?>:</label>
                            <input type="date" name="returnDate" id="returnDate"
                                value="<?= htmlentities(stripslashes($sreturnDate), ENT_NOQUOTES, 'UTF-8') ?>"
                                class="form-control">
                        </div>
                    </div>
                    <p />

                </div>
                <input type="submit" class="btn btn-primary" id="AssignSaveButton" value="<?= gettext('Assign') ?>"
                    name="IssueAsset">
                <?php if (AuthenticationManager::GetCurrentUser()->isAddRecordsEnabled()) {
            echo '<input type="submit" class="btn btn-primary" value="' . gettext('Reassign') . '" name="SaveReassign">';
        } ?>
                <a href="AssetIssuanceList.php" class="btn btn-primary"
                    value="<?= gettext('Go to Assignment List') ?>">Go to Assignment List</a>

            </div>
    </form>
</div>

<?php require 'Include/Footer.php' ?>