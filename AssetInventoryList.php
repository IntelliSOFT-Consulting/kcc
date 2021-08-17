<?php
require 'Include/Config.php';
require 'Include/Functions.php';

use ChurchCRM\Utils\InputUtils;
use ChurchCRM\Authentication\AuthenticationManager;

///////////////////////
require 'Include/Header.php';

// display all assets
$sSQL = "SELECT * from asset_inventory WHERE inventory_deleted='False'";
$result = RunQuery($sSQL);
$resultCheck = mysqli_num_rows($result);


if (isset($_POST['Action']) && isset($_POST['inventory_id']) && AuthenticationManager::GetCurrentUser()->isAddRecordsEnabled()) {
  $inventory_id = InputUtils::LegacyFilterInput($_POST['inventory_id'], 'int');
  $action = InputUtils::LegacyFilterInput($_POST['Action']);

  if ($action == 'Delete' && $inventory_id) {
    $sSQL = "UPDATE asset_inventory SET inventory_deleted = 'True' WHERE inventory_id='$inventory_id'  LIMIT 1";
    RunQuery($sSQL);    
  } 
 
}
?>

<!-- HTML TABLE -->
<div class="box box-warning">
    <div class="box-body">
        <table id="inventoryList" class='table data-table table-striped table-bordered table-responsive'>
            <thead>
                <tr>
                    <th><?= gettext('Name') ?></th>
                    <th><?= gettext('Serial Number') ?></th>
                    <th><?= gettext('Quantity') ?></th>
                    <th><?= gettext('Unit Cost') ?></th>
                    <th><?= gettext('Total Cost') ?></th>
                    <th><?= gettext('Location') ?></th>
                    <th><?= gettext('Movement') ?></th>
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
                    <td><?php echo $row['serial_number'] ?></td>
                    <td><?php echo $row['asset_quantity'] ?></td>
                    <td><?php echo $row['unit_cost'] ?></td>
                    <td><?php echo $row['total_cost'] ?></td>
                    <td><?php echo $row['location_code'] ?></td>
                    <td><?php echo $row['movement_type'] ?></td>
                    <td>

                        <a href="AssetInventoryEditor.php?edit=<?php echo $row['inventory_id']; ?>" class="btn btn-info"
                            name="edit"><span class="fa fa-edit"></span></a>

                        <form style="display:inline-block" name="DeleteInventory" action="AssetInventoryList.php"
                            method="POST">
                            <input type="hidden" name="inventory_id" value="<?= $row['inventory_id']; ?>">
                            <button type="submit" name="Action" title="<?= gettext('Delete') ?>" data-tooltip
                                value="Delete" class="btn btn-danger"
                                onClick="return confirm('Deleting an asset in inventory will also delete all assignments for that asset.  Are you sure you want to DELETE asset ID: <?= $row['inventory_id']; ?>')">
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