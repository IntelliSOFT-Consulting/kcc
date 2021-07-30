<?php
require 'Include/Config.php';
require 'Include/Functions.php';

use ChurchCRM\Utils\InputUtils;
use ChurchCRM\Authentication\AuthenticationManager;

///////////////////////
require 'Include/Header.php';

// display all assets
$sSQL = "SELECT * from assets WHERE assetDeleted='False'";
$result = RunQuery($sSQL);
$resultCheck = mysqli_num_rows($result);


if (isset($_POST['Action']) && isset($_POST['assetID']) && AuthenticationManager::GetCurrentUser()->isAddRecordsEnabled()) {
  $assetID = InputUtils::LegacyFilterInput($_POST['assetID'], 'int');
  $action = InputUtils::LegacyFilterInput($_POST['Action']);

  if ($action == 'Delete' && $assetID) {
    $sSQL = "UPDATE assets SET assetDeleted = 'True' WHERE assetID='$assetID'  LIMIT 1";
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
            <td><?php echo $row['assetName'] ?></td>
            <td><?php echo $row['make'] ?></td>
            <td><?php echo $row['quantity'] ?></td>
            <td><?php echo $row['assetCategory'] ?></td>
            <td>
            <a href="AssetView.php?view=<?php echo $row['assetID']; ?>" class="btn btn-info" name="view"><span class="fa fa-eye"></span></a>

              <form style="display:inline-block" name="DeleteAsset" action="AssetList.php" method="POST">
                <input type="hidden" name="assetID" value="<?= $row['assetID']; ?>">
                <button type="submit" name="Action" title="<?= gettext('Delete') ?>" data-tooltip value="Delete" class="btn btn-danger" onClick="return confirm('Deleting an asset will also delete all assignments for that asset.  Are you sure you want to DELETE asset ID: <?= $row['assetID']; ?>')">
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