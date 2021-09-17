<?php
//Include the function library
require 'Include/Config.php';
require 'Include/Functions.php';
require 'Include/CanvassUtilities.php';

//Utility classes
use ChurchCRM\Utils\InputUtils;
use ChurchCRM\Authentication\AuthenticationManager;

//Set page title
$sPageTitle = gettext('View Asset');

if (!AuthenticationManager::GetCurrentUser()->isAddRecordsEnabled()) {
    header('Location: AssetList.php');
}

require 'Include/Header.php';


if (isset($_GET['view'])) {
    $asset_id = $_GET['view'];

    $sSQL = "SELECT * FROM assets where asset_id='$asset_id'";
    $result = RunQuery($sSQL);
    // $resultCheck = mysqli_num_rows($result);

    $row = mysqli_fetch_array($result);
    extract($row);

    $sasset_name = $asset_name;
    $sasset_make = $asset_make;
    $squantity = $quantity;
    $sasset_condition = $asset_condition;
    $sasset_category =  $asset_category;
    $sasset_description = $asset_description;
    $spurchase_date = $purchase_date;
}

?>

<div class="container-fluid">

    <div class="child">
        <h4 class="text-left">
            Asset Name: <?= ($sasset_name) ?>
        </h4>

        <!-- <img src="uploads/<?= ($bassetImage) ?>" style="width:200px; height:200px;" class="img-fluid img-thumbnail" /> -->

        <p class=" text-left p-2">
            Asset Make: <?= ($sasset_make) ?>
        </p>

        <p class=" text-left p-2">
            Asset Quantity: <?= ($sasset_quantity) ?>
        </p>

        <p class=" text-left p-2">
            Asset Description: <?= ($sasset_description) ?>
        </p>

        <p class=" text-left p-2">
            Asset Category: <?= ($sasset_category) ?>
        </p>

        <p class=" text-left p-2">
            Asset Purchase Date: <?= ($spurchase_date) ?>
        </p>

    </div>
    <div>
        <a href="AssetsEditor.php?edit=<?php echo $row['asset_id']; ?>" class="btn btn-primary" name="edit">Edit</a>
        <a href="AssetsAssign.php?assign=<?php echo $row['asset_id']; ?>" class="btn btn-primary"
            name="assign">Assign</a>
        <a href="AssetInventoryEditor.php?inventory=<?php echo $row['asset_id']; ?>" class="btn btn-primary"
            name="assign">Inventory</a>
        <a href="AssetHistory.php?history=<?php echo $row['asset_id']; ?>" class="btn btn-primary"
            name="history">History</a>
        <a href="AssetList.php" class="btn btn-primary" value="<?= gettext('Go to Asset List') ?>">Go to Asset List</a>


    </div>


</div>


<?php require 'Include/Footer.php' ?>