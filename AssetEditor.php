<?php
//Include the function library
require 'Include/Config.php';
require 'Include/Functions.php';
require 'Include/CanvassUtilities.php';

use ChurchCRM\dto\SystemConfig;
use ChurchCRM\Note;
use ChurchCRM\Utils\InputUtils;
use ChurchCRM\Emails\NewPersonOrFamilyEmail;
use ChurchCRM\PersonQuery;
use ChurchCRM\dto\Photo;
use ChurchCRM\dto\SystemURLs;
use ChurchCRM\Utils\RedirectUtils;
use ChurchCRM\Utils\LoggerUtils;
use ChurchCRM\Authentication\AuthenticationManager;

//Set page title
$sPageTitle = gettext('Asset Editor');


//New asset add



require 'Include/Header.php';


//DB fields
if (isset($_POST['AssetSubmit']) || isset($_POST['AssetSubmitAndAdd'])) {
    //Get all the variables from the request object and assign them locally
    $sassetName = InputUtils::LegacyFilterInput($_POST['assetName']);
    $sserialNumber = InputUtils::LegacyFilterInput($_POST['serialNumber']);
    $iassetCondition = InputUtils::LegacyFilterInput($_POST['assetCondition'], 'int');
    $sassetDescription = InputUtils::LegacyFilterInput($_POST['assetDescription']);
    $sassetCategory= InputUtils::LegacyFilterInput($_POST['assetCategory']);
    $bassetImage = InputUtils::LegacyFilterInput($_POST['assetImage']);
   $dpurchaseDate2 = date('Y-m-d h:i:s', strtotime($dpurchaseDate));
}

?>

<form method="post" action="AssetEditor.php" name="AssetEditor">
    <div class="box box-info clearfix">
        <div class="box-header">
            <h3 class="box-title"><?= gettext('Add Assets') ?></h3>
        </div>

        <div class="box-body">
            <div class="form-group">
                <div class="row">
                    <div class="col-md-6">
                        <label for="Asset Name"><?= gettext('Asset Name') ?>:</label>
                        <input type="text" name="assetName" id="assetName"
                            value="<?= htmlentities(stripslashes($sassetName), ENT_NOQUOTES, 'UTF-8') ?>"
                            class="form-control">
                    </div>
                </div>
                <p />

                <div class="row">
                    <div class="col-md-6">
                        <label for="Serial Number"><?= gettext('Serial Number') ?>:</label>
                        <input type="text" name="serialNumber" id="serialNumber"
                            value="<?= htmlentities(stripslashes($sserialNumber), ENT_NOQUOTES, 'UTF-8') ?>"
                            class="form-control">
                    </div>
                </div>
                <p />

                <div class="row">
                    <div class="col-md-6">
                        <label for="Asset Condition"><?= gettext('Asset Condition') ?>:</label>
                        <input type="text" name="assetCondition" id="assetCondition"
                            value="<?= htmlentities(stripslashes($iassetCondition), ENT_NOQUOTES, 'UTF-8') ?>"
                            class="form-control">
                    </div>
                </div>
                <p />

                <div class="row">
                    <div class="col-md-6">
                        <label for="Asset Description"><?= gettext('Asset Description') ?>:</label>
                        <input type="text" name="assetDescription" id="assetDescription"
                            value="<?= htmlentities(stripslashes($sassetDescription), ENT_NOQUOTES, 'UTF-8') ?>"
                            class="form-control">
                    </div>
                </div>
                <p />

                <div class="row">
                    <div class="col-md-6">
                        <label for="Asset Category"><?= gettext('Asset Category') ?>:</label>
                        <input type="text" name="assetCategory" id="assetCategory"
                            value="<?= htmlentities(stripslashes($sassetCategory), ENT_NOQUOTES, 'UTF-8') ?>"
                            class="form-control">
                    </div>
                </div>
                <p />

                <div class="row">
                    <div class="col-md-6">
                        <label for="Asset Image"><?= gettext('Asset Image') ?>:</label>
                        <input type="file" name="assetImage" id="assetImage"
                            value="<?= htmlentities(stripslashes($bassetImage), ENT_NOQUOTES, 'UTF-8') ?>"
                            class="form-control">
                    </div>
                </div>
                <p />

                <div class="row">
                    <div class="col-md-6">
                        <label for="Purchase Date"><?= gettext('Purchase Date') ?>:</label>
                        <input type="date" name="purchaseDate" id="purchaseDate"
                            value="<?= htmlentities(stripslashes($dpurchaseDate), ENT_NOQUOTES, 'UTF-8') ?>"
                            class="form-control">
                    </div>
                </div>
                <p />

            </div>
            <input type="submit" class="btn btn-primary" id="AssetSaveButton" value="<?= gettext('Save') ?>"
                name="AssetSubmit">
            <?php if (AuthenticationManager::GetCurrentUser()->isAddRecordsEnabled()) {
                    echo '<input type="submit" class="btn btn-primary" value="' . gettext('Save and Add') . '" name="AssetSubmitAndAdd">';
                } ?>
            <input type="button" class="btn btn-primary" value="<?= gettext('Cancel') ?>" name="AssetCancel">

        </div>


</form>

<?php require 'Include/Footer.php' ?>