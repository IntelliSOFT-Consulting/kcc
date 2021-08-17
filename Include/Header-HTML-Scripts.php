<?php
use ChurchCRM\dto\SystemURLs;

?>
<title>KCC <?= $sPageTitle ?></title>

<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css"
    href="<?= SystemURLs::getRootPath() ?>/skin/external/bootstrap/bootstrap.min.css">

<!-- Custom ChurchCRM styles -->
<link rel="stylesheet" href="<?= SystemURLs::getRootPath() ?>/skin/churchcrm.min.css">
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />

<!-- jQuery 2.1.4 -->
<script src="<?= SystemURLs::getRootPath() ?>/skin/external/jquery/jquery.min.js"></script>
<!-- jQuery UI -->
<script src="<?= SystemURLs::getRootPath() ?>/skin/external/jquery-ui/jquery-ui.min.js"></script>

<script src="<?= SystemURLs::getRootPath() ?>/skin/external/moment/moment-with-locales.min.js"></script>