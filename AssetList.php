<?php
require 'Include/Config.php';
require 'Include/Functions.php';

use ChurchCRM\Utils\InputUtils;
use ChurchCRM\Authentication\AuthenticationManager;

///////////////////////
require 'Include/Header.php';

// display all assets
$sSQL = "SELECT * from assets WHERE asset_deleted='False'";
$result = RunQuery($sSQL);
$resultCheck = mysqli_num_rows($result);


if (isset($_POST['Action']) && isset($_POST['asset_id']) && AuthenticationManager::GetCurrentUser()->isAddRecordsEnabled()) {
  $asset_id = InputUtils::LegacyFilterInput($_POST['asset_id'], 'int');
  $action = InputUtils::LegacyFilterInput($_POST['Action']);

  if ($action == 'Delete' && $asset_id) {
    $sSQL = "UPDATE assets SET asset_deleted = 'True' WHERE asset_id='$asset_id'  LIMIT 1";
    RunQuery($sSQL);
    
  } 
 
}
?>

<!-- HTML TABLE -->
<div class="box box-warning">
    <div class="box-body">
        <table id="assetlist" class='table data-table table-striped table-bordered table-responsive'>
            <thead>
                <tr>
                    <th><?= gettext('Name') ?></th>
                    <th><?= gettext('Make') ?></th>
                    <th><?= gettext('Quantity') ?></th>
                    <th><?= gettext('Category') ?></th>
                    <th><?= gettext('Action') ?></th>
                </tr>
            </thead>

            <tbody>

                <!--Populate the table with asset details -->
                <?php
        while ($row = mysqli_fetch_assoc($result)) {
        ?>
                <tr>
                    <td><?php echo $row['asset_name'] ?></td>
                    <td><?php echo $row['asset_make'] ?></td>
                    <td><?php echo $row['asset_quantity'] ?></td>
                    <td><?php echo $row['asset_category'] ?></td>
                    <td>
                        <a href="AssetView.php?view=<?php echo $row['asset_id']; ?>" class="btn btn-info"
                            name="view"><span class="fa fa-eye"></span></a>

                        <form style="display:inline-block" name="DeleteAsset" action="AssetList.php" method="POST">
                            <input type="hidden" name="asset_id" value="<?= $row['asset_id']; ?>">
                            <button type="submit" name="Action" title="<?= gettext('Delete') ?>" data-tooltip
                                value="Delete" class="btn btn-danger"
                                onClick="return confirm('Deleting an asset will also delete all assignments for that asset.  Are you sure you want to DELETE asset ID: <?= $row['asset_id']; ?>')">
                                <i class='fa fa-trash'></i>
                            </button>
                        </form>

                    </td>
                </tr>
                <?php } ?>
            </tbody>
        </table>
    </div>
</div>


<?php
require 'Include/Footer.php'
?>