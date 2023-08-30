<?php
require 'Include/Config.php';
require 'Include/Functions.php';

///////////////////////
require 'Include/Header.php';

// display all assets
$sSQL = "SELECT * from assets WHERE asset_deleted='False'";
$result = RunQuery($sSQL);
$resultCheck = mysqli_num_rows($result);

//delete an asset
if(isset($_GET['delete'])){
  $asset_id = $_GET['delete'];
  $sSQL = "UPDATE assets SET asset_deleted = 'True' WHERE asset_id='$asset_id'  LIMIT 1";
    RunQuery($sSQL);
    header("Location: AssetList.php");
}
?>

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
                    <td><?php echo $row['make'] ?></td>
                    <td><?php echo $row['asset_quantity'] ?></td>
                    <td><?php echo $row['asset_category'] ?></td>
                    <td>
                        <a href="AssetView.php?view=<?php echo $row['asset_id']; ?>" class="btn btn-info"
                            name="view"><span class="fa fa-eye"></span>
                        </a>

                        <a href="AssetEditor.php?edit=<?php echo $row['asset_id']; ?>" class="btn btn-primary"
                            name="edit"><span class="fa fa-pencil"></span>
                        </a>

                        <a href="AssetList.php?delete=<?php echo $row['asset_id']; ?>" class="btn btn-danger"
                            name="delete"
                            onClick="return confirm('Sure you want to delete this asset? This cannot be undone later.')">
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