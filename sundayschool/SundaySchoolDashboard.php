<?php
require '../Include/Config.php';
require '../Include/Functions.php';

use ChurchCRM\Service\DashboardService;
use ChurchCRM\Service\SundaySchoolService;
use ChurchCRM\dto\SystemURLs;
use ChurchCRM\Utils\MiscUtils;
use ChurchCRM\Utils\InputUtils;
use ChurchCRM\Authentication\AuthenticationManager;

$dashboardService = new DashboardService();
$sundaySchoolService = new SundaySchoolService();

$groupStats = $dashboardService->getGroupStats();

$kidsWithoutClasses = $sundaySchoolService->getKidsWithoutClasses();
$classStats = $sundaySchoolService->getClassStats();
$classes = $groupStats['sundaySchoolClasses'];
$teachers = 0;
$kids = 0;
$families = 0;
$maleKids = 0;
$femaleKids = 0;
$teens = 0;
$youth = 0;
$familyIds = [];
foreach ($classStats as $class) {
  $kids = $kids + $class['kids'];
  $teachers = $teachers + $class['teachers'];
  $classKids = $sundaySchoolService->getKidsFullDetails($class['id']);
  foreach ($classKids as $kid) {
    array_push($familyIds, $kid['fam_id']);
    if ($kid['kidGender'] == '1') {
      $maleKids++;
    } elseif ($kid['kidGender'] == '2') {
      $femaleKids++;
    }

    $age = calculateAge($kid['birthYear'], $kid['birthMonth'], $kid['birthDay']);
    if ($age >= 13 && $age <= 17) {
        $teens++;
    } elseif ($age >= 18 && $age <= 24) {
        $youth++;
    }
  }
}

// Set the page title and include HTML header
$sPageTitle = gettext('Sunday School and Youth Dashboard');
require '../Include/Header.php';

?>
<div class="box">
  <div class="box-header with-border">
    <h3 class="box-title"><?= gettext('Functions') ?></h3>
  </div>
  <div class="box-body">
    <?php if (AuthenticationManager::GetCurrentUser()->isManageGroupsEnabled()) {
    ?>
      <!-- <button class="btn btn-app" data-toggle="modal" data-target="#add-class"><i class="fa fa-plus-square"></i><?= gettext('Add New Class') ?></button> -->
    <?php
    } ?>
    <a href="SundaySchoolReports.php" class="btn btn-app" title="<?= gettext('Generate class lists and attendance sheets'); ?>"><i class="fa fa-file-pdf-o"></i><?= gettext('Reports'); ?></a>
    <a href="SundaySchoolClassListExport.php" class="btn btn-app" title="<?= gettext('Export All Classes, Kids, and Parent to CSV file'); ?>"><i class="fa fa-file-excel-o"></i><?= gettext('Export to CSV') ?></a><br />
  </div>
</div>
<!-- Small boxes (Stat box) -->
<div class="row">
  <div class="col-md-3 col-sm-6 col-xs-12">
    <div class="info-box">
      <span class="info-box-icon bg-aqua"><i class="fa fa-gg"></i></span>

      <div class="info-box-content">
        <span class="info-box-text"><?= gettext(' Sunday School Classes') ?></span>
        <span class="info-box-number"> <?= $classes ?> <br /></span>
      </div>
      <!-- /.info-box-content -->
    </div>
    <!-- /.info-box -->
  </div>
  <div class="col-md-3 col-sm-6 col-xs-12">
    <div class="info-box">
      <span class="info-box-icon bg-olive"><i class="fa fa-group"></i></span>

      <div class="info-box-content">
        <span class="info-box-text"><?= gettext('Teachers') ?></span>
        <span class="info-box-number"> <?= $teachers ?></span>
      </div>
      <!-- /.info-box-content -->
    </div>
    <!-- /.info-box -->
  </div>
  <div class="col-md-3 col-sm-6 col-xs-12">
    <div class="info-box">
      <span class="info-box-icon bg-orange"><i class="fa fa-child"></i></span>
      <div class="info-box-content">
        <span class="info-box-text"><?= gettext('Students') ?></span>
        <span class="info-box-number"> <?= $kids ?></span>
      </div>
      <!-- /.info-box-content -->
    </div>
    <!-- /.info-box -->
  </div>
  <div class="col-md-3 col-sm-6 col-xs-12">
    <div class="info-box">
      <span class="info-box-icon bg-gray"><i class="fa fa-user"></i></span>

      <div class="info-box-content">
        <span class="info-box-text"><?= gettext('Families') ?></span>
        <span class="info-box-number"> <?= count(array_unique($familyIds)) ?></span>
      </div>
      <!-- /.info-box-content -->
    </div>
    <!-- /.info-box -->
  </div>
  <div class="col-md-3 col-sm-6 col-xs-12">
    <div class="info-box">
      <span class="info-box-icon bg-blue"><i class="fa fa-male"></i></span>

      <div class="info-box-content">
        <span class="info-box-text"><?= gettext('Boys') ?></span>
        <span class="info-box-number"> <?= $maleKids ?></span>
      </div>
      <!-- /.info-box-content -->
    </div>
    <!-- /.info-box -->
  </div>
  <div class="col-md-3 col-sm-6 col-xs-12">
    <div class="info-box">
      <span class="info-box-icon bg-fuchsia"><i class="fa fa-female"></i></span>

      <div class="info-box-content">
        <span class="info-box-text"><?= gettext('Girls') ?></span>
        <span class="info-box-number"> <?= $femaleKids ?></span>
      </div>
      <!-- /.info-box-content -->
    </div>
    <!-- /.info-box -->
  </div>
  <div class="col-md-3 col-sm-6 col-xs-12">
    <div class="info-box">
        <span class="info-box-icon bg-Aero"><i class="fa fa-group"></i></span>

        <div class="info-box-content">
            <span class="info-box-text"><?= gettext('Teens (13 - 17)') ?></span>
            <span class="info-box-number"> <?= $teens ?></span>
        </div>
        <!-- /.info-box-content -->
    </div>
    <!-- /.info-box -->
</div>
<div class="col-md-3 col-sm-6 col-xs-12">
    <div class="info-box">
        <span class="info-box-icon bg-purple"><i class="fa fa-group"></i></span>

        <div class="info-box-content">
            <span class="info-box-text"><?= gettext('Youth (18 - 24)') ?></span>
            <span class="info-box-number"> <?= $youth ?></span>
        </div>
        <!-- /.info-box-content -->
    </div>
    <!-- /.info-box -->
</div>
  <!-- // Add this function to calculate ages -->
<?php 
  function calculateAge($birthYear, $birthMonth, $birthDay) {
    $today = new DateTime();
    $birthDate = new DateTime();
    $birthDate->setDate($birthYear, $birthMonth, $birthDay);
    $age = date('Y') - $birthDate->format('Y');   

    if ($birthDate->format('md') > $today->format('md')) {
        $age--;
    }

    return $age;
}
?>
</div><!-- /.row -->
<!-- on continue -->
<div class="box box-info">
  <div class="box-header">
    <h3 class="box-title"><?= gettext('Sunday School Classes') ?></h3>
    <div class="box-tools pull-right">
      <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
      </button>
      <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i>
      </button>
    </div>
  </div>
  <div class="box-body">
    <table id="sundayschoolMissing" class="table table-striped table-bordered data-table" cellspacing="0" width="100%">
      <thead>
        <tr>
          <th></th>
          <th><?= gettext('Class') ?></th>
          <th><?= gettext('Teachers') ?></th>
          <th><?= gettext('Students') ?></th>
        </tr>
      </thead>
      <tbody>
        <?php foreach ($classStats as $class) {
        ?>
          <tr>
            <td style="width:100px">
              <a href='SundaySchoolClassView.php?groupId=<?= $class['id'] ?>'>
                <span class="fa-stack">
                  <i class="fa fa-square fa-stack-2x"></i>
                  <i class="fa fa-search-plus fa-stack-1x fa-inverse"></i>
                </span>
              </a>
              <a href='<?= SystemURLs::getRootPath() ?>/GroupEditor.php?GroupID=<?= $class['id'] ?>'>
                <span class="fa-stack">
                  <i class="fa fa-square fa-stack-2x"></i>
                  <i class="fa fa fa-pencil fa-stack-1x fa-inverse"></i>
                </span>
              </a>
              <a href='<?= SystemURLs::getRootPath() ?>/GroupView.php?GroupID=<?= $class['id'] ?>'>
                <span class="fa-stack">
                  <i class="fa fa-square fa-stack-2x"></i>
                  <i class="fa fa-trash fa-stack-1x fa-inverse"></i>
                </span>
              </a>
            </td>
            <td><?= $class['name'] ?></td>
            <td><?= $class['teachers'] ?></td>
            <td><?= $class['kids'] ?></td>
          </tr>
        <?php
        } ?>
      </tbody>
    </table>
  </div>
</div>


<div class="box box-danger">
  <div class="box-header">
    <h3 class="box-title"><?= gettext('Students not in a Sunday School Class') ?></h3>
    <div class="box-tools pull-right">
      <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
      </button>
      <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i>
      </button>
    </div>
  </div>
  <!-- /.box-header -->
  <div class="box-body table-responsive">
    <table id="sundayschoolMissing" class="table table-striped table-bordered data-table" cellspacing="0" width="100%">
      <thead>
        <tr>
          <th><?= gettext('First Name') ?></th>
          <th><?= gettext('Last Name') ?></th>
          <th><?= gettext('Birth Date') ?></th>
          <th><?= gettext('Age') ?></th>
        </tr>
      </thead>
      <tbody>
        <?php foreach ($kidsWithoutClasses as $child) {  ?>
          <tr>
            <td><?= $child['per_FirstName'] ?></td>
            <td><?= $child['per_LastName'] ?></td>
            <td><?= $child['per_BirthYear'] ?></td>
            <td><?= $child['age'] ?></td>
          </tr>
        <?php }

        ?>
      </tbody>

    </table>
  </div>
</div>
<?php

if (isset($_POST['saveClass'])) {
  $groupName = InputUtils::LegacyFilterInput($_POST['grp_Name']);
  $groupAgeLimitStart = InputUtils::LegacyFilterInput($_POST['grp_AgeLimitStart']);
  $groupAgeLimitEnd  = InputUtils::LegacyFilterInput($_POST['grp_AgeLimitEnd']);

  //New asset add
  if ($grp_ID == 0) {
      $sSQL = "INSERT INTO group_grp(grp_Name, grp_AgeLimitStart, grp_AgeLimitEnd)
          VALUES('" . $groupName . "', '" . $groupAgeLimitStart . "', " . $groupAgeLimitEnd  . "')";
  }

  //Execute the SQL
  RunQuery($sSQL);
  header("Location: /sundayschool/SundaySchoolClassView.php?groupId=" . $newGroupId);
}
?>
<?php if (AuthenticationManager::GetCurrentUser()->isManageGroupsEnabled()) {
?>
  <div class="modal fade" id="add-class" tabindex="-1" role="dialog" aria-labelledby="add-class-label" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h4 class="modal-title" id="delete-Image-label"><?= gettext('Add') ?> <?= gettext('Sunday School') ?> <?= gettext('Class') ?> </h4>
          <p class="modal-title" id="delete-Image-label" style="color: #737373;"> <?= gettext('all fields marked with') ?><span style="color: red">*</span> <?= gettext('are required') ?></p>
        </div>
        <form method="post" action="SundaySchoolDashboard.php" name="AssetEditor">
          <div class="modal-body">
            <div class="form-group">
              <h5 class="modal-title" id="delete-Image-label"><?= gettext('Class name') ?><span style="color: red">*</span></h5>
              <input type="text" id="new-class-name" name="grp_Name" class="form-control"  placeholder="<?= gettext('Enter Name') ?>" maxlength="20" required>
            </div>
          </div>
        
          <div class="modal-body">
              <div class="form-group row">
                  <div class="col-md-6">
                      <h5 class="modal-title" id="delete-Image-label"><?= gettext('Age start') ?><span style="color: red">*</span></h5>
                      <input type="text" id="new-class-age-limit-start" name="grp_AgeLimitStart" class="form-control" placeholder="<?= gettext('Age limit') ?>" maxlength="5" required>
                  </div>
                  <div class="col-md-6">
                      <h5 class="modal-title" id="delete-Image-label"><?= gettext('Age End') ?><span style="color: red">*</span></h5>
                      <input type="text" id="new-class-age-limit-end" name="grp_AgeLimitEnd" class="form-control" placeholder="<?= gettext('Age limit') ?>" maxlength="5" required>
                  </div>
              </div>
          </div>
 
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal"><?= gettext('Cancel') ?></button>
            <button type="button" id="addNewClassBtn" class="btn btn-primary" data-dismiss="modal" name="saveClass"><?= gettext('Add') ?></button>
          </div>
        </form>
      </div>
    </div>
  </div>
  <!-- <script nonce="<?= SystemURLs::getCSPNonce() ?>">
    $("#addNewClassBtn").click(function(e) {
    var groupName = $("#new-class-name").val();
    var groupAgeStart = $("#new-class-age-limit-start").val();
    var groupAgeEnd = $("#new-class-age-limit-end").val();
    
    if (groupName && groupAgeStart && groupAgeEnd) {
      var formData = {
        groupName: groupName,
        isSundaySchool: true
      };

      $.ajax({
        method: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        url: window.CRM.root + "/api/groups/",
        data: JSON.stringify(formData),
        success: function(data) {
          window.location.href = window.CRM.root + "/sundayschool/SundaySchoolClassView.php?groupId=" + data.grp_ID;
        },
        error: function() {
          alert("An error occurred while processing your request.");
        }
      });
    } else {
      alert("Please fill in all required fields.");
    }
  });
  </script> -->

<?php
}
require '../Include/Footer.php' ?>