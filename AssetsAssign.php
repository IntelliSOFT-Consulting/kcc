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
$sPageTitle = gettext('Assign Assets');


require 'Include/Header.php';

?>

<form method="post" action="AssignAssets.php">
    <div class="box box-info clearfix">
        <div class="box-header">
            <h3 class="box-title"><?= gettext('Assign Assets') ?></h3>
        </div>

        <div class="box-body">
            <div class="form-group">

                <div class="row">
                    <div class="col-md-6 form-group">
                        <label> Assets Description</label>
                        <textarea name="description" class="form-control" placeholder="Description" required
                            value=""></textarea>
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

                <div class="row">
                    <div class="col-md-6 form-group">
                        <label>Assigned to: </label>
                        <input type="text" value="" class="form-control" placeholder="assigned to" name="asset_img"
                            id="up_img">
                    </div>
                </div>
                <br>

                <div class="row">
                    <div class="col-md-6 form-group">
                        <label>Assigned date: </label>
                        <input type="date" value="" class="form-control" name="asset_img" id="up_img">
                    </div>
                </div>
                <br>

                <div class="pull-right"><br />
                    <input type="submit" class="btn btn-primary" value="<?= gettext('Save') ?>" name="FamilySubmit">
                </div>

            </div>
        </div>
</form>