<?php

//Include the function library
require 'Include/Config.php';
require 'Include/Functions.php';
require 'Include/CanvassUtilities.php';

//Add classes

use ChurchCRM\dto\SystemConfig;
use ChurchCRM\Note;
use ChurchCRM\Utils\InputUtils;
use ChurchCRM\dto\SystemURLs;
use ChurchCRM\Emails\NewPersonOrFamilyEmail;
use ChurchCRM\Utils\RedirectUtils;
use ChurchCRM\Bootstrapper;
use ChurchCRM\Authentication\AuthenticationManager;

//Set page title
$sPageTitle = gettext('Assets Editor');


require 'Include/Header.php';

?>

<form method="post" action="AddAssets.php">
    <div class="box box-info clearfix">
        <div class="box-header">
            <h3 class="box-title"><?= gettext('Assets Info') ?></h3>
        </div>

        <div class="box-body">
            <div class="form-group">
                <div class="row">
                    <div class="col-md-6 form-group">
                        <label><?= gettext('Asset Name') ?>:</label>
                        <input type="text" Name="Name" id="AssetName" value="<?= htmlentities(stripslashes($sAssetName), ENT_NOQUOTES, 'UTF-8') ?>" maxlength="48" class="form-control">
                        <?php if ($sAssetNameError) {
                        ?><font color="red"><?= $sAssetNameError ?></font><?php
                                                                        }                       ?>
                    </div>
                </div>
                <br>

                <div class="row">
                    <div class="col-md-6 form-group">
                        <label> Assets Description</label>
                        <textarea name="description" class="form-control" required value="">enter your text here</textarea>
                    </div>
                </div>
                <br>

                <div class="row">
                    <div class=" col-md-6 form-group">
                        <label> Quantity </label>
                        <input type="number" min="0" class="form-control" value="" name="a_num" placeholder="Type Product Name">
                    </div>
                </div>
                <br>

                <div class="row">
                    <div class="col-md-6 form-group">
                        <label>Asset Image </label>
                        <input type="file" value="" class="form-control" name="asset_img" id="up_img">
                    </div>
                </div>
                <br>

                <div class="pull-right"><br />
                    <input type="submit" class="btn btn-primary" value="<?= gettext('Save') ?>" name="FamilySubmit">
                </div>

            </div>
        </div>
</form>