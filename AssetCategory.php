<?php
require 'Include/Config.php';
require 'Include/Functions.php';

use ChurchCRM\Utils\InputUtils;
use ChurchCRM\Authentication\AuthenticationManager;

///////////////////////
require 'Include/Header.php';

// Get the categoryID out of the querystring
if (array_key_exists('categoryID', $_GET)) {
    $categoryID = InputUtils::LegacyFilterInput($_GET['categoryID'], 'int');
} else {
    $categoryID = 0;
}


//Add a category
if (isset($_POST['AddCategory'])) {
    $scategoryName = InputUtils::LegacyFilterInput($_POST['categoryName']);

    if ($categoryID == 0) {
        $sSQL = "INSERT INTO asset_category (categoryName)
                VALUES('" . $scategoryName . "')";
    }

    //Execute the SQL
    RunQuery($sSQL);

} elseif (isset($_GET['edit'])) {
    $categoryID = $_GET['edit'];

    $sSQL = "SELECT * FROM asset_category where categoryID='$categoryID'";
    $result = RunQuery($sSQL);

    $row = mysqli_fetch_array($result);
    extract($row);

    $scategoryName = $categoryName;
    
} elseif (isset($_POST['Update'])) {
    $categoryID = InputUtils::LegacyFilterInput($_POST['categoryID'], 'int');

    $scategoryName = $_POST['categoryName'];

    $sSQL = "UPDATE asset_category SET categoryName = '" . $scategoryName . "'
            WHERE categoryID = '$categoryID' LIMIT 1 ";

    RunQuery($sSQL);
}


// display a list of all categories
$sSQL = "SELECT * from asset_category WHERE categoryDeleted='False'";
$result = RunQuery($sSQL);
$resultCheck = mysqli_num_rows($result);

//Delete one category 

if (isset($_POST['Action']) && isset($_POST['categoryID']) && AuthenticationManager::GetCurrentUser()->isAddRecordsEnabled()) {
    $categoryID = InputUtils::LegacyFilterInput($_POST['categoryID'], 'int');
    $action = InputUtils::LegacyFilterInput($_POST['Action']);

    if ($action == 'Delete' && $categoryID) {
        $sSQL = "UPDATE asset_category SET categoryDeleted = 'True' WHERE categoryID='$categoryID'  LIMIT 1";
        RunQuery($sSQL);
    }
}
?>

<!-- form for adding categories -->
<div class="box box-warning clearfix">
    <div class="box-header">
        <h3 class="box-title"><?= gettext('Add New Category') ?></h3>
    </div>
    <div class="container mt-3 mb-3">
        <div class="row">
            <div class="col-md-4">
                <div class="card mx-auto" style="width: 100%; height: 100%;">
                    <div class=" card-body">
                        <a href="#" data-toggle="modal" data-target="#form_categories" class="btn btn-primary">Add </a>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <!-- Add Asset category modal -->

    <!-- Modal -->
    <div class="modal fade" id="form_categories" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Category</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form method="post" action="AssetCategory.php" id="form_category" onsubmit="return false">
                        <input type="hidden" name="categoryID" value="<?= ($categoryID) ?>">
                        <div class="form-group">
                            <label>Category Name</label>
                            <input type="text" name="categoryName" id="categoryName"
                                value="<?= htmlentities(stripslashes($scategoryName), ENT_NOQUOTES, 'UTF-8') ?>"
                                class="form-control" placeholder="Category Name">
                            <small id="cat_error" class="form-text text-muted"></small>
                        </div>
                        <div class="form-group">
                            <label>Parent category</label>
                            <select class="form-control" name="parent_cat" id="parent_cat">
                                <option value="0">Root</option>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-primary" id="addCategory" value="<?= gettext('Save') ?>"
                            name="AddCategory">Add</button>
                        <button type="submit" class="btn btn-primary" value=<?= gettext("Update") ?>
                            name="Update">Update</button>

                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <!-- end of add asset category modal -->

    <form method="post" action="AssetCategory.php">
        <input type="hidden" name="categoryID" value="<?= ($categoryID) ?>">

        <div class="row">
            <div class="col-md-4 ml-3">
                <label><?= gettext('Add a Category') ?>:</label>
                <input type="text" name="categoryName" id="categoryName"
                    value="<?= htmlentities(stripslashes($scategoryName), ENT_NOQUOTES, 'UTF-8') ?>"
                    class="form-control">
                <input type="submit" class="btn btn-primary mt-3" id="addCategory" value="<?= gettext('Save') ?>"
                    name="AddCategory">
                <input type="submit" class="btn btn-primary mt-3" value=<?= gettext("Update") ?> name="Update">
            </div>
        </div>

        <p />

    </form>

</div>



<!-- HTML TABLE -->
<div class="box box-warning">
    <div class="box-body">
        <table id="assetCategory" class='table data-table table-striped table-bordered table-responsive'>
            <thead>
                <tr>
                    <th><?= gettext('Category ID') ?></th>
                    <th><?= gettext('Category Name') ?></th>
                    <th><?= gettext('Action ') ?></th>
                </tr>
            </thead>

            <tbody>

                <?php
                while ($row = mysqli_fetch_assoc($result)) {
                ?>
                <tr>
                    <td><?php echo $row['categoryID'] ?></td>
                    <td><?php echo $row['categoryName'] ?></td>
                    <td>
                        <a href="AssetCategory.php?edit=<?php echo $row['categoryID']; ?>" class="btn btn-primary"
                            name="edit">Edit</a>

                        <form style="display:inline-block" name="DeleteCategory" action="AssetCategory.php"
                            method="POST">
                            <input type="hidden" name="categoryID" value="<?= $row['categoryID']; ?>">
                            <button type="submit" name="Action" title="<?= gettext('Delete') ?>" data-tooltip
                                value="Delete" class="btn btn-danger"
                                onClick="return confirm('Are you sure you want to DELETE Category ID: <?= $row['categoryID']; ?>')">
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