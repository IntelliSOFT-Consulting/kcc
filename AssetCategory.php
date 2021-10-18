<?php
require 'Include/Config.php';
require 'Include/Functions.php';

use ChurchCRM\Utils\InputUtils;
use ChurchCRM\Authentication\AuthenticationManager;

///////////////////////
require 'Include/Header.php';

// Get the category_id out of the querystring
if (array_key_exists('category_id', $_GET)) {
    $category_id = InputUtils::LegacyFilterInput($_GET['category_id'], 'int');
} else {
    $category_id = 0;
}


//Add a category
if (isset($_POST['AddCategory'])) {
    $scategory_name = InputUtils::LegacyFilterInput($_POST['category_name']);

    if ($category_id == 0) {
        $sSQL = "INSERT INTO asset_category (category_name)
                VALUES('" . $scategory_name . "')";
    }

    //Execute the SQL
    RunQuery($sSQL);

} elseif (isset($_GET['edit'])) {
    $category_id = $_GET['edit'];

    $sSQL = "SELECT * FROM asset_category where category_id='$category_id'";
    $result = RunQuery($sSQL);

    $row = mysqli_fetch_array($result);
    extract($row);

    $scategory_name = $category_name;
    
} elseif (isset($_POST['Update'])) {
    $category_id = InputUtils::LegacyFilterInput($_POST['category_id'], 'int');

    $scategory_name = $_POST['category_name'];

    $sSQL = "UPDATE asset_category SET category_name = '" . $scategory_name . "'
            WHERE category_id = '$category_id' LIMIT 1 ";

    RunQuery($sSQL);
}


// display a list of all categories
$sSQL = "SELECT * from asset_category WHERE category_deleted='False'";
$result = RunQuery($sSQL);
$resultCheck = mysqli_num_rows($result);

//Delete one category 
if (isset($_GET['delete'])) {
    $category_id = $_GET['delete'];
    $sSQL = "UPDATE asset_category SET category_deleted = 'True' WHERE category_id='$category_id'  LIMIT 1";
    RunQuery($sSQL);
    header("Location: AssetCategory.php");
}
?>


<!-- Add button modal -->
<div class="box box-warning clearfix">
    <div class="box-header">
        <h3 class="box-title"><?= gettext('Add New Category') ?></h3>
    </div>

    <div class="container mt-3 mb-3">
        <div class="row">
            <div class="col-md-4">
                <div class="card mx-auto" style="width: 100%; height: 100%;">
                    <div class=" card-body">
                        <a href="#" data-toggle="modal" data-target="#form_categories" class="btn btn-primary"><span
                                class="glyphicon glyphicon-plus pr-2"></span>Add </a>
                    </div>
                </div>
            </div>

        </div>
    </div>

</div>


<!-- Add Asset category modal -->

<div class="modal fade" id="form_categories" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
    aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Add Category</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form method="POST" action="AssetCategory.php" id="Modal_form_category">
                    <!-- <input type="hidden" name="category_id" value="<?= ($category_id) ?>"> -->
                    <div class="form-group">
                        <label>Category Name</label>
                        <input type="text" name="category_name" id="category_name"
                            value="<?= htmlentities(stripslashes($scategory_name), ENT_NOQUOTES, 'UTF-8') ?>"
                            class="form-control" placeholder="Category Name">
                        <small id="cat_error" class="form-text text-muted"></small>
                    </div>

                    <button type="submit" class="btn btn-primary" id="addCategory" value="<?= gettext('Save') ?>"
                        name="AddCategory">Add</button>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<!-- end of add asset category modal -->


<!-- edit Asset category modal -->

<div class="modal fade" id="editmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
    aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Edit Category</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form method="POST" action="AssetCategory.php">
                    <input type="hidden" name="category_id" id="category_id" value="<?= ($category_id) ?>">
                    <div class="form-group">
                        <label>Category Name</label>
                        <input type="text" name="category_name" id="category_name"
                            value="<?= htmlentities(stripslashes($scategory_name), ENT_NOQUOTES, 'UTF-8') ?>"
                            class="form-control" placeholder="Category Name">
                        <small id="cat_error" class="form-text text-muted"></small>
                    </div>

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

<!-- end of edit asset category modal -->

<!-- HTML TABLE -->
<div class="box box-warning">
    <div class="box-body">
        <table id="asset_category" class='table data-table table-striped table-bordered table-responsive'>
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
                    <td><?php echo $row['category_id'] ?></td>
                    <td><?php echo $row['category_name'] ?></td>
                    <td>

                        <a href="AssetCategory.php?edit=<?php echo $row['category_id']; ?>" data-toggle="modal"
                            data-target="#editCategory" class="btn btn-primary" name="edit" id="editbtn"><i
                                class="fa fa-pencil"></i> </a>
                        <a href="AssetCategory.php?delete=<?php echo $row['category_id']; ?>" class="btn btn-danger"
                            name="DeleteCategory" id="delete"
                            onClick="return confirm('Sure you want to delete this category? This cannot be undone later.')">
                            <i class="fa fa-trash"></i> </a>
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

<!-- edit code in jquery -->
<script>
$(document).ready(function() {
    $('#editbtn').on('click', function() {

        $('#editmodal').modal('show');

        $tr = $(this).closest('tr');

        var data = $tr.children('td').map(function() {
            return $(this).text();
        }).get();

        console.log(data);

        $('#category_id').val(data[0]);
        $('#categoty_name').val(data[1]);

    });
});
</script>