<?php
require 'Include/Config.php';
require 'Include/Functions.php';

///////////////////////
require 'Include/Header.php';

// display all assets in inventory
$sSQL = "SELECT asset_inventory.*, assets.asset_name 
        FROM asset_inventory 
        JOIN assets 
        WHERE asset_inventory.asset_id = assets.asset_id
        AND inventory_deleted='False'";
        
$result = RunQuery($sSQL);
$resultCheck = mysqli_num_rows($result);

// Delete an asset in inventory
if(isset($_GET['delete'])){
  $inventory_id = $_GET['delete'];
  $sSQL = "UPDATE asset_inventory SET inventory_deleted = 'True' WHERE inventory_id='$inventory_id'  LIMIT 1";
    RunQuery($sSQL);
    header("Location: AssetInventoryList.php");
}

?>

<!-- HTML TABLE -->
<div class="box box-warning">
    <div class="box-body">
        <table id="inventoryList" class='table data-table table-striped table-bordered table-responsive'>
            <thead>
                <tr>
                    <th><?= gettext('Asset Name') ?></th>
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
                            name="edit"><span class="fa fa-pencil"></span></a>
                        <a href="AssetInventoryList.php?delete=<?php echo $row['inventory_id']; ?>"
                            class="btn btn-danger" name="delete"
                            onClick="return confirm('Sure you want to delete this inventory? This cannot be undone later.')">
                            <span class="fa fa-trash"></span>
                        </a>

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