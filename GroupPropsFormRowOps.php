<?php
/*******************************************************************************
 *
 *  filename    : MinistryPropsFormRowOps.php
 *  last change : 2013-02-09
 *  website     : http://www.churchcrm.io
 *  copyright   : Copyright 2003 Chris Gebhardt (http://www.openserve.org)
 *
 *  function    : Row operations for the Ministry-specific properties form
 *******************************************************************************/

require 'Include/Config.php';
require 'Include/Functions.php';

use ChurchCRM\Utils\InputUtils;
use ChurchCRM\Utils\RedirectUtils;
use ChurchCRM\Authentication\AuthenticationManager;

// Security: user must be allowed to edit records to use this page.
if (!AuthenticationManager::GetCurrentUser()->isManageMinistrysEnabled()) {
    RedirectUtils::Redirect('Menu.php');
    exit;
}

// Get the Ministry, Property, and Action from the querystring
$iMinistryID = InputUtils::LegacyFilterInput($_GET['MinistryID'], 'int');
$iPropID = InputUtils::LegacyFilterInput($_GET['PropID'], 'int');
$sField = InputUtils::LegacyFilterInput($_GET['Field']);
$sAction = $_GET['Action'];

// Get the Ministry information
$sSQL = 'SELECT * FROM Ministry_grp WHERE grp_ID = '.$iMinistryID;
$rsMinistryInfo = RunQuery($sSQL);
extract(mysqli_fetch_array($rsMinistryInfo));

// Abort if user tries to load with Ministry having no special properties.
if ($grp_hasSpecialProps == false) {
    RedirectUtils::Redirect('MinistryView.php?MinistryID='.$iMinistryID);
}

switch ($sAction) {
    // Move a field up:  Swap the prop_ID (ordering) of the selected row and the one above it
    case 'up':
        $sSQL = "UPDATE Ministryprop_master SET prop_ID = '".$iPropID."' WHERE grp_ID = '".$iMinistryID."' AND prop_ID = '".($iPropID - 1)."'";
        RunQuery($sSQL);
        $sSQL = "UPDATE Ministryprop_master SET prop_ID = '".($iPropID - 1)."' WHERE grp_ID = '".$iMinistryID."' AND prop_Field = '".$sField."'";
        RunQuery($sSQL);
        break;

    // Move a field down:  Swap the prop_ID (ordering) of the selected row and the one below it
    case 'down':
        $sSQL = "UPDATE Ministryprop_master SET prop_ID = '".$iPropID."' WHERE grp_ID = '".$iMinistryID."' AND prop_ID = '".($iPropID + 1)."'";
        RunQuery($sSQL);
        $sSQL = "UPDATE Ministryprop_master SET prop_ID = '".($iPropID + 1)."' WHERE grp_ID = '".$iMinistryID."' AND prop_Field = '".$sField."'";
        RunQuery($sSQL);
        break;

    // Delete a field from the form
    case 'delete':
        // Check if this field is a custom list type.  If so, the list needs to be deleted from list_lst.
        $sSQL = "SELECT type_ID,prop_Special FROM Ministryprop_master WHERE grp_ID = '".$iMinistryID."' AND prop_Field = '".$sField."'";
        $rsTemp = RunQuery($sSQL);
        $aTemp = mysqli_fetch_array($rsTemp);
        if ($aTemp[0] == 12) {
            $sSQL = "DELETE FROM list_lst WHERE lst_ID = $aTemp[1]";
            RunQuery($sSQL);
        }

        $sSQL = 'ALTER TABLE `Ministryprop_'.$iMinistryID.'` DROP `'.$sField.'` ;';
        RunQuery($sSQL);

        $sSQL = "DELETE FROM Ministryprop_master WHERE grp_ID = '".$iMinistryID."' AND prop_ID = '".$iPropID."'";
        RunQuery($sSQL);

        $sSQL = 'SELECT *	FROM Ministryprop_master WHERE grp_ID = '.$iMinistryID;
        $rsPropList = RunQuery($sSQL);
        $numRows = mysqli_num_rows($rsPropList);

        // Shift the remaining rows up by one, unless we've just deleted the only row
        if ($numRows != 0) {
            for ($reorderRow = $iPropID + 1; $reorderRow <= $numRows + 1; $reorderRow++) {
                $sSQL = "UPDATE Ministryprop_master SET prop_ID = '".($reorderRow - 1)."' WHERE grp_ID = '".$iMinistryID."' AND prop_ID = '".$reorderRow."'";
                RunQuery($sSQL);
            }
        }
        break;

    // If no valid action was specified, abort and return to the MinistryView
    default:
        RedirectUtils::Redirect('MinistryView.php?MinistryID='.$iMinistryID);
        break;
}

// Reload the Form Editor page
RedirectUtils::Redirect('MinistryPropsFormEditor.php?MinistryID='.$iMinistryID);
exit;
