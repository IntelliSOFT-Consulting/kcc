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
    $assetID = $_GET['view'];

    $sSQL = "SELECT * FROM assets where assetID='$assetID'";
    $result = RunQuery($sSQL);
    // $resultCheck = mysqli_num_rows($result);

    $row = mysqli_fetch_array($result);
    extract($row);

    $sassetName = $assetName;
    $smake = $make;
    $squantity = $quantity;
    $sassetCondition = $assetCondition;
    $sassetCategory =  $assetCategory;
    $sassetDescription = $assetDescription;
    $spurchaseDate = $purchaseDate;
}

?>

<div class="container-fluid">

    <div class="child">
        <h4 class="text-left">
            Asset Name: <?= ($sassetName) ?>
        </h4>

        <!-- <img src="uploads/<?= ($bassetImage) ?>" style="width:200px; height:200px;" class="img-fluid img-thumbnail" /> -->

        <p class=" text-left p-2">
            Asset Make: <?= ($smake) ?>
        </p>

        <p class=" text-left p-2">
            Asset Quantity: <?= ($squantity) ?>
        </p>

        <p class=" text-left p-2">
            Asset Description: <?= ($sassetDescription) ?>
        </p>

        <p class=" text-left p-2">
            Asset Category: <?= ($sassetCategory) ?>
        </p>

        <p class=" text-left p-2">
            Asset Purchase Date: <?= ($spurchaseDate) ?>
        </p>

    </div>
    <div>
        <a href="AssetEditor.php?edit=<?php echo $row['assetID']; ?>" class="btn btn-primary" name="edit">Edit</a>
        <a href="AssetsIssuance.php?assign=<?php echo $row['assetID']; ?>" class="btn btn-primary"
            name="assign">Assign</a>
        <a href="AssetHistory.php?history=<?php echo $row['assetID']; ?>" class="btn btn-primary"
            name="history">History</a>
        <a href="AssetList.php" class="btn btn-primary" value="<?= gettext('Go to Asset List') ?>">Go to Asset List</a>


    </div>


</div>


<?php require 'Include/Footer.php' ?>