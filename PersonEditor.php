<?php
/*******************************************************************************
 *
 *  filename    : PersonEditor.php
 *  website     : http://www.churchcrm.io
 *  copyright   : Copyright 2001, 2002, 2003 Deane Barker, Chris Gebhardt
 *                Copyright 2004-2005 Michael Wilt
 *
 ******************************************************************************/

//Include the function library
require 'Include/Config.php';
require 'Include/Functions.php';

use ChurchCRM\dto\SystemConfig;
use ChurchCRM\Note;
use ChurchCRM\Utils\InputUtils;
use ChurchCRM\Emails\NewPersonOrFamilyEmail;
use ChurchCRM\PersonQuery;
use ChurchCRM\FamilyQuery;
use ChurchCRM\dto\Photo;
use ChurchCRM\dto\SystemURLs;
use ChurchCRM\Utils\RedirectUtils;
use ChurchCRM\Utils\LoggerUtils;
use ChurchCRM\Authentication\AuthenticationManager;

//Set the page title
$sPageTitle = gettext('Person Editor');

//Get the PersonID out of the querystring
if (array_key_exists('PersonID', $_GET)) {
    $iPersonID = InputUtils::LegacyFilterInput($_GET['PersonID'], 'int');
} else {
    $iPersonID = 0;
}

$iFamilyID = -1;

//Get the FamilyID from the querystring
if (array_key_exists('FamilyID', $_GET)) {
    $iFamilyID = InputUtils::LegacyFilterInput($_GET['FamilyID'], 'int');
}

// Security: User must have Add or Edit Records permission to use this form in those manners
// Clean error handling: (such as somebody typing an incorrect URL ?PersonID= manually)
if ($iFamilyID > 0) {
    if (!(AuthenticationManager::GetCurrentUser()->isEditRecordsEnabled() || (AuthenticationManager::GetCurrentUser()->isEditSelfEnabled() && $iFamilyID == AuthenticationManager::GetCurrentUser()->getPerson()->getFamId()))) {
        RedirectUtils::Redirect('Menu.php');
        exit;
    }

    $sSQL = 'SELECT fam_ID FROM family_fam WHERE fam_ID = ' . $iFamilyID;
    if (mysqli_num_rows(RunQuery($sSQL)) == 0) {
        RedirectUtils::Redirect('Menu.php');
        exit;
    }
} elseif (!AuthenticationManager::GetCurrentUser()->isAddRecordsEnabled()) {
    RedirectUtils::Redirect('Menu.php');
    exit;
}

// // Get the list of funds
// $sSQL = "SELECT fun_ID,fun_Name,fun_Description,fun_Active FROM donationfund_fun WHERE fun_Active = 'true'";
// $rsFunds = RunQuery($sSQL);

// // Get the lists of canvassers
// $rsCanvassers = CanvassGetCanvassers(gettext('Canvassers'));
// $rsBraveCanvassers = CanvassGetCanvassers(gettext('BraveCanvassers'));

// // Get the list of custom person fields
// $sSQL = 'SELECT family_custom_master.* FROM family_custom_master ORDER BY fam_custom_Order';
// $rsCustomFields = RunQuery($sSQL);
// $numCustomFields = mysqli_num_rows($rsCustomFields);

// // Get Field Security List Matrix
// $sSQL = 'SELECT * FROM list_lst WHERE lst_ID = 5 ORDER BY lst_OptionSequence';
// $rsSecurityGrp = RunQuery($sSQL);

// while ($aRow = mysqli_fetch_array($rsSecurityGrp)) {
//     extract($aRow);
//     $aSecurityType[$lst_OptionID] = $lst_OptionName;
// }

$bErrorFlag = false;
$sNameError = '';
$sEmailError = '';
$sWeddingDateError = '';

$sName = '';

$UpdateBirthYear = 0;

$aFirstNameError = [];
$aBirthDateError = [];
$aperFlags = [];

//Add family start
//Is this the second pass?
if (isset($_POST['FamilySubmit']) || isset($_POST['FamilySubmitAndAdd'])) {
    //Assign everything locally
    $sName = InputUtils::LegacyFilterInput($_POST['Name']);
    // Strip commas out of address fields because they are problematic when
    // exporting addresses to CSV file
    $sAddress1 = str_replace(',', '', InputUtils::LegacyFilterInput($_POST['Address1']));
    $sAddress2 = str_replace(',', '', InputUtils::LegacyFilterInput($_POST['Address2']));
    $sCity = InputUtils::LegacyFilterInput($_POST['City']);
    $sZip = InputUtils::LegacyFilterInput($_POST['Zip']);

    // bevand10 2012-04-26 Add support for uppercase ZIP - controlled by administrator via cfg param
    if (SystemConfig::getBooleanValue('bForceUppercaseZip')) {
        $sZip = strtoupper($sZip);
    }

    $sCountry = InputUtils::LegacyFilterInput($_POST['Country']);
    $iFamilyMemberRows = InputUtils::LegacyFilterInput($_POST['FamCount']);

    if ($sCountry == 'United States' || $sCountry == 'Canada' || $sCountry == '') {
        $sState = InputUtils::LegacyFilterInput($_POST['State']);
    } else {
        $sState = InputUtils::LegacyFilterInput($_POST['StateTextbox']);
    }

    $sHomePhone = InputUtils::LegacyFilterInput($_POST['HomePhone']);
    $sWorkPhone = InputUtils::LegacyFilterInput($_POST['WorkPhone']);
    $sCellPhone = InputUtils::LegacyFilterInput($_POST['CellPhone']);
    $sEmail = InputUtils::LegacyFilterInput($_POST['Email']);
    $bSendNewsLetter = isset($_POST['SendNewsLetter']);

    $nLatitude = 0.0;
    $nLongitude = 0.0;
    if (array_key_exists('Latitude', $_POST)) {
        $nLatitude = InputUtils::LegacyFilterInput($_POST['Latitude'], 'float');
    }
    if (array_key_exists('Longitude', $_POST)) {
        $nLongitude = InputUtils::LegacyFilterInput($_POST['Longitude'], 'float');
    }


    if (is_numeric($nLatitude)) {
        $nLatitude = "'" . $nLatitude . "'";
    } else {
        $nLatitude = 'NULL';
    }

    if (is_numeric($nLongitude)) {
        $nLongitude = "'" . $nLongitude . "'";
    } else {
        $nLongitude = 'NULL';
    }

    $nEnvelope = 0;
    if (array_key_exists('Envelope', $_POST)) {
        $nEnvelope = InputUtils::LegacyFilterInput($_POST['Envelope'], 'int');
    }

    if (is_numeric($nEnvelope)) { // Only integers are allowed as Envelope Numbers
        if (intval($nEnvelope) == floatval($nEnvelope)) {
            $nEnvelope = "'" . intval($nEnvelope) . "'";
        } else {
            $nEnvelope = "'0'";
        }
    } else {
        $nEnvelope = "'0'";
    }

    $iCanvasser = 0;
    if (AuthenticationManager::GetCurrentUser()->isCanvasserEnabled()) { // Only take modifications to this field if the current user is a canvasser
        $bOkToCanvass = isset($_POST['OkToCanvass']);
        if (array_key_exists('Canvasser', $_POST)) {
            $iCanvasser = InputUtils::LegacyFilterInput($_POST['Canvasser']);
        }
        if ((!$iCanvasser) && array_key_exists('BraveCanvasser', $_POST)) {
            $iCanvasser = InputUtils::LegacyFilterInput($_POST['BraveCanvasser']);
        }
        if (empty($iCanvasser)) {
            $iCanvasser = 0;
        }
    }

    $iPropertyID = 0;
    if (array_key_exists('PropertyID', $_POST)) {
        $iPropertyID = InputUtils::LegacyFilterInput($_POST['PropertyID'], 'int');
    }
    $dWeddingDate = InputUtils::LegacyFilterInput($_POST['WeddingDate']);

    $bNoFormat_HomePhone = isset($_POST['NoFormat_HomePhone']);
    $bNoFormat_WorkPhone = isset($_POST['NoFormat_WorkPhone']);
    $bNoFormat_CellPhone = isset($_POST['NoFormat_CellPhone']);

    //Loop through the Family Member 'quick entry' form fields
    for ($iCount = 1; $iCount <= $iFamilyMemberRows; $iCount++) {
        // Assign everything to arrays
        $aFirstNames[$iCount] = InputUtils::LegacyFilterInput($_POST['FirstName' . $iCount]);
        $aMiddleNames[$iCount] = InputUtils::LegacyFilterInput($_POST['MiddleName' . $iCount]);
        $aLastNames[$iCount] = InputUtils::LegacyFilterInput($_POST['LastName' . $iCount]);
        $aSuffix[$iCount] = InputUtils::LegacyFilterInput($_POST['Suffix' . $iCount]);
        $aRoles[$iCount] = InputUtils::LegacyFilterInput($_POST['Role' . $iCount], 'int');
        $aGenders[$iCount] = InputUtils::LegacyFilterInput($_POST['Gender' . $iCount], 'int');
        $aBirthDays[$iCount] = InputUtils::LegacyFilterInput($_POST['BirthDay' . $iCount], 'int');
        $aBirthMonths[$iCount] = InputUtils::LegacyFilterInput($_POST['BirthMonth' . $iCount], 'int');
        $aBirthYears[$iCount] = InputUtils::LegacyFilterInput($_POST['BirthYear' . $iCount], 'int');
        $aClassification[$iCount] = InputUtils::LegacyFilterInput($_POST['Classification' . $iCount], 'int');
        $aPersonIDs[$iCount] = InputUtils::LegacyFilterInput($_POST['PersonID' . $iCount], 'int');
        $aUpdateBirthYear[$iCount] = InputUtils::LegacyFilterInput($_POST['UpdateBirthYear'], 'int');

        // Make sure first names were entered if editing existing family
        if ($iFamilyID > 0) {
            if (strlen($aFirstNames[$iCount]) == 0) {
                $aFirstNameError[$iCount] = gettext('First name must be entered');
                $bErrorFlag = true;
            }
        }

        // Validate any family member birthdays
        if ((strlen($aFirstNames[$iCount]) > 0) && (strlen($aBirthYears[$iCount]) > 0)) {
            if (($aBirthYears[$iCount] > 2155) || ($aBirthYears[$iCount] < 1901)) {
                $aBirthDateError[$iCount] = gettext('Invalid Year: allowable values are 1901 to 2155');
                $bErrorFlag = true;
            } elseif ($aBirthMonths[$iCount] > 0 && $aBirthDays[$iCount] > 0) {
                if (!checkdate($aBirthMonths[$iCount], $aBirthDays[$iCount], $aBirthYears[$iCount])) {
                    $aBirthDateError[$iCount] = gettext('Invalid Birth Date.');
                    $bErrorFlag = true;
                }
            }
        }
    }

    //Did they enter a name?
    if (strlen($sName) < 1) {
        $sNameError = gettext('You must enter a name');
        $bErrorFlag = true;
    }

    // Validate Wedding Date if one was entered
    if ((strlen($dWeddingDate) > 0) && ($dWeddingDate != '')) {
        $dateString = parseAndValidateDate($dWeddingDate, Bootstrapper::getCurrentLocale()->getCountryCode(), $pasfut = 'past');
        if ($dateString === false) {
            $sWeddingDateError = '<span style="color: red; ">'
                . gettext('Not a valid Wedding Date') . '</span>';
            $bErrorFlag = true;
        } else {
            $dWeddingDate = "'$dateString'";
        }
    } else {
        $dWeddingDate = 'NULL';
    }

    // Validate Email
    if (strlen($sEmail) > 0) {
        if (checkEmail($sEmail) == false) {
            $sEmailError = '<span style="color: red; ">'
                . gettext('Email is Not Valid') . '</span>';
            $bErrorFlag = true;
        } else {
            $sEmail = $sEmail;
        }
    }

    // Validate all the custom fields
    $aCustomData = [];
    while ($rowCustomField = mysqli_fetch_array($rsCustomFields, MYSQLI_BOTH)) {
        extract($rowCustomField);

        $currentFieldData = InputUtils::LegacyFilterInput($_POST[$fam_custom_Field]);

        $bErrorFlag |= !validateCustomField($type_ID, $currentFieldData, $fam_custom_Field, $aCustomErrors);

        // assign processed value locally to $aPersonProps so we can use it to generate the form later
        $aCustomData[$fam_custom_Field] = $currentFieldData;
    }

    //If no errors, then let's update...
    if (!$bErrorFlag) {
        // Format the phone numbers before we store them
        if (!$bNoFormat_HomePhone) {
            $sHomePhone = CollapsePhoneNumber($sHomePhone, $sCountry);
        }
        if (!$bNoFormat_WorkPhone) {
            $sWorkPhone = CollapsePhoneNumber($sWorkPhone, $sCountry);
        }
        if (!$bNoFormat_CellPhone) {
            $sCellPhone = CollapsePhoneNumber($sCellPhone, $sCountry);
        }

        //Write the base SQL depending on the Action
        if ($bSendNewsLetter) {
            $bSendNewsLetterString = "'TRUE'";
        } else {
            $bSendNewsLetterString = "'FALSE'";
        }
        if ($bOkToCanvass) {
            $bOkToCanvassString = "'TRUE'";
        } else {
            $bOkToCanvassString = "'FALSE'";
        }
        if ($iFamilyID < 1) {
            $sSQL = "INSERT INTO family_fam (
						fam_Name,
						fam_Address1,
						fam_Address2,
						fam_City,
						fam_State,
						fam_Zip,
						fam_Country,
						fam_HomePhone,
						fam_WorkPhone,
						fam_CellPhone,
						fam_Email,
						fam_WeddingDate,
						fam_DateEntered,
						fam_EnteredBy,
						fam_SendNewsLetter,
						fam_OkToCanvass,
						fam_Canvasser,
						fam_Latitude,
						fam_Longitude,
						fam_Envelope)
					VALUES ('" .
                $sName . "','" .
                $sAddress1 . "','" .
                $sAddress2 . "','" .
                $sCity . "','" .
                $sState . "','" .
                $sZip . "','" .
                $sCountry . "','" .
                $sHomePhone . "','" .
                $sWorkPhone . "','" .
                $sCellPhone . "','" .
                $sEmail . "'," .
                $dWeddingDate . ",'" .
                date('YmdHis') . "'," .
                AuthenticationManager::GetCurrentUser()->getId() . ',' .
                $bSendNewsLetterString . ',' .
                $bOkToCanvassString . ",'" .
                $iCanvasser . "'," .
                $nLatitude . ',' .
                $nLongitude . ',' .
                $nEnvelope . ')';
            $bGetKeyBack = true;
        } else {
            $sSQL = "UPDATE family_fam SET fam_Name='" . $sName . "'," .
                "fam_Address1='" . $sAddress1 . "'," .
                "fam_Address2='" . $sAddress2 . "'," .
                "fam_City='" . $sCity . "'," .
                "fam_State='" . $sState . "'," .
                "fam_Zip='" . $sZip . "'," .
                'fam_Latitude=' . $nLatitude . ',' .
                'fam_Longitude=' . $nLongitude . ',' .
                "fam_Country='" . $sCountry . "'," .
                "fam_HomePhone='" . $sHomePhone . "'," .
                "fam_WorkPhone='" . $sWorkPhone . "'," .
                "fam_CellPhone='" . $sCellPhone . "'," .
                "fam_Email='" . $sEmail . "'," .
                'fam_WeddingDate=' . $dWeddingDate . ',' .
                'fam_Envelope=' . $nEnvelope . ',' .
                "fam_DateLastEdited='" . date('YmdHis') . "'," .
                'fam_EditedBy = ' . AuthenticationManager::GetCurrentUser()->getId() . ',' .
                'fam_SendNewsLetter = ' . $bSendNewsLetterString;
            if (AuthenticationManager::GetCurrentUser()->isCanvasserEnabled()) {
                $sSQL .= ', fam_OkToCanvass = ' . $bOkToCanvassString .
                    ", fam_Canvasser = '" . $iCanvasser . "'";
            }
            $sSQL .= ' WHERE fam_ID = ' . $iFamilyID;
            $bGetKeyBack = false;
        }

        //Execute the SQL
        RunQuery($sSQL);

        //If the user added a new record, we need to key back to the route to the FamilyView page
        if ($bGetKeyBack) {
            //Get the key back
            $sSQL = 'SELECT MAX(fam_ID) AS iFamilyID FROM family_fam';
            $rsLastEntry = RunQuery($sSQL);
            extract(mysqli_fetch_array($rsLastEntry));

            $sSQL = "INSERT INTO `family_custom` (`fam_ID`) VALUES ('" . $iFamilyID . "')";
            RunQuery($sSQL);

            // Add property if assigned
            if ($iPropertyID) {
                $sSQL = "INSERT INTO record2property_r2p (r2p_pro_ID, r2p_record_ID) VALUES ($iPropertyID, $iFamilyID)";
                RunQuery($sSQL);
            }

            //Run through the family member arrays...
            for ($iCount = 1; $iCount <= $iFamilyMemberRows; $iCount++) {
                if (strlen($aFirstNames[$iCount]) > 0) {
                    if (strlen($aBirthYears[$iCount]) < 4) {
                        $aBirthYears[$iCount] = 'NULL';
                    }

                    //If no last name is entered for a member, use the family name.
                    if (strlen($aLastNames[$iCount]) && $aLastNames[$iCount] != $sName) {
                        $sLastNameToEnter = $aLastNames[$iCount];
                    } else {
                        $sLastNameToEnter = $sName;
                    }

                    RunQuery('LOCK TABLES person_per WRITE, person_custom WRITE');
                    $sSQL = "INSERT INTO person_per (
								per_FirstName,
								per_MiddleName,
								per_LastName,
                        per_Suffix,
								per_fam_ID,
								per_fmr_ID,
								per_DateEntered,
								per_EnteredBy,
								per_Gender,
								per_BirthDay,
								per_BirthMonth,
								per_BirthYear,
								per_cls_ID)
							VALUES (
								'$aFirstNames[$iCount]',
								'$aMiddleNames[$iCount]',
								'$sLastNameToEnter',
								'$aSuffix[$iCount]',
								$iFamilyID,
								$aRoles[$iCount],
								'" . date('YmdHis') . "',
								" . AuthenticationManager::GetCurrentUser()->getId() . ",
								$aGenders[$iCount],
								$aBirthDays[$iCount],
								$aBirthMonths[$iCount],
								$aBirthYears[$iCount],
								$aClassification[$iCount])";
                    RunQuery($sSQL);
                    $dbPersonId = mysqli_insert_id($cnInfoCentral);
                    $note = new Note();
                    $note->setPerId($dbPersonId);
                    $note->setText(gettext('Created via Family'));
                    $note->setType('create');
                    $note->setEntered(AuthenticationManager::GetCurrentUser()->getId());
                    $note->save();
                    $sSQL = 'INSERT INTO person_custom (per_ID) VALUES ('
                        . $dbPersonId . ')';
                    RunQuery($sSQL);
                    RunQuery('UNLOCK TABLES');
                }
            }
            $family = FamilyQuery::create()->findPk($iFamilyID);
            $family->createTimeLineNote('create');
            $family->updateLanLng();

            if (!empty(SystemConfig::getValue("sNewPersonNotificationRecipientIDs"))) {
                $NotificationEmail = new NewPersonOrFamilyEmail($family);
                if (!$NotificationEmail->send()) {
                    $logger->warn($NotificationEmail->getError());
                }
            }
        } else {
            for ($iCount = 1; $iCount <= $iFamilyMemberRows; $iCount++) {
                if (strlen($aFirstNames[$iCount]) > 0) {
                    if (strlen($aBirthYears[$iCount]) < 4) {
                        $aBirthYears[$iCount] = 'NULL';
                    }

                    //If no last name is entered for a member, use the family name.
                    if (strlen($aLastNames[$iCount]) && $aLastNames[$iCount] != $sName) {
                        $sLastNameToEnter = $aLastNames[$iCount];
                    } else {
                        $sLastNameToEnter = $sName;
                    }
                    $sBirthYearScript = ($aUpdateBirthYear[$iCount] & 1) ? 'per_BirthYear=' . $aBirthYears[$iCount] . ', ' : '';
                    //RunQuery("LOCK TABLES person_per WRITE, person_custom WRITE");
                    $sSQL = "UPDATE person_per SET per_FirstName='" . $aFirstNames[$iCount] . "', per_MiddleName='" . $aMiddleNames[$iCount] . "',per_LastName='" . $aLastNames[$iCount] . "',per_Suffix='" . $aSuffix[$iCount] . "',per_Gender='" . $aGenders[$iCount] . "',per_fmr_ID='" . $aRoles[$iCount] . "',per_BirthMonth='" . $aBirthMonths[$iCount] . "',per_BirthDay='" . $aBirthDays[$iCount] . "', " . $sBirthYearScript . "per_cls_ID='" . $aClassification[$iCount] . "' WHERE per_ID=" . $aPersonIDs[$iCount];
                    RunQuery($sSQL);
                    //RunQuery("UNLOCK TABLES");

                    $note = new Note();
                    $note->setPerId($aPersonIDs[$iCount]);
                    $note->setText(gettext('Updated via Family'));
                    $note->setType('edit');
                    $note->setEntered(AuthenticationManager::GetCurrentUser()->getId());
                    $note->save();
                }
            }
            $family = FamilyQuery::create()->findPk($iFamilyID);
            $family->updateLanLng();
            $family->createTimeLineNote('edit');
        }

        // Update the custom person fields.
        if ($numCustomFields > 0) {
            $sSQL = 'REPLACE INTO family_custom SET ';
            mysqli_data_seek($rsCustomFields, 0);

            while ($rowCustomField = mysqli_fetch_array($rsCustomFields, MYSQLI_BOTH)) {
                extract($rowCustomField);
                if (AuthenticationManager::GetCurrentUser()->isEnabledSecurity($aSecurityType[$fam_custom_FieldSec])) {
                    $currentFieldData = trim($aCustomData[$fam_custom_Field]);

                    sqlCustomField($sSQL, $type_ID, $currentFieldData, $fam_custom_Field, $sCountry);
                }
            }

            // chop off the last 2 characters (comma and space) added in the last while loop iteration.
            $sSQL = mb_substr($sSQL, 0, -2);

            $sSQL .= ', fam_ID = ' . $iFamilyID;

            //Execute the SQL
            RunQuery($sSQL);
        }

        //Which submit button did they press?
        if (isset($_POST['FamilySubmit'])) {
            //Send to the view of this person
            RedirectUtils::Redirect('v2/family/' . $iFamilyID);
        } else {
            //Reload to editor to add another record
            RedirectUtils::Redirect('FamilyEditor.php');
        }
    }
} else {
    //FirstPass
    //Are we editing or adding?
    if ($iFamilyID > 0) {
        //Editing....
        //Get the information on this family
        $sSQL = 'SELECT * FROM family_fam WHERE fam_ID = ' . $iFamilyID;
        $rsFamily = RunQuery($sSQL);
        extract(mysqli_fetch_array($rsFamily));

        $iFamilyID = $fam_ID;
        $sName = $fam_Name;
        $sAddress1 = $fam_Address1;
        $sAddress2 = $fam_Address2;
        $sCity = $fam_City;
        $sState = $fam_State;
        $sZip = $fam_Zip;
        $sCountry = $fam_Country;
        $sHomePhone = $fam_HomePhone;
        $sWorkPhone = $fam_WorkPhone;
        $sCellPhone = $fam_CellPhone;
        $sEmail = $fam_Email;
        $bSendNewsLetter = ($fam_SendNewsLetter == 'TRUE');
        $bOkToCanvass = ($fam_OkToCanvass == 'TRUE');
        $iCanvasser = $fam_Canvasser;
        $dWeddingDate = $fam_WeddingDate;
        $nLatitude = $fam_Latitude;
        $nLongitude = $fam_Longitude;

        // Expand the phone number
        $sHomePhone = ExpandPhoneNumber($sHomePhone, $sCountry, $bNoFormat_HomePhone);
        $sWorkPhone = ExpandPhoneNumber($sWorkPhone, $sCountry, $bNoFormat_WorkPhone);
        $sCellPhone = ExpandPhoneNumber($sCellPhone, $sCountry, $bNoFormat_CellPhone);

        $sSQL = 'SELECT * FROM family_custom WHERE fam_ID = ' . $iFamilyID;
        $rsCustomData = RunQuery($sSQL);
        $aCustomData = mysqli_fetch_array($rsCustomData, MYSQLI_BOTH);

        $aCustomErrors = [];

        if ($numCustomFields > 0) {
            mysqli_data_seek($rsCustomFields, 0);
            while ($rowCustomField = mysqli_fetch_array($rsCustomFields, MYSQLI_BOTH)) {
                $aCustomErrors[$rowCustomField['fam_custom_Field']] = false;
            }
        }

        $sSQL = 'SELECT * FROM person_per LEFT JOIN family_fam ON per_fam_ID = fam_ID WHERE per_fam_ID =' . $iFamilyID . ' ORDER BY per_fmr_ID';
        $rsMembers = RunQuery($sSQL);
        $iCount = 0;
        $iFamilyMemberRows = 0;
        while ($aRow = mysqli_fetch_array($rsMembers)) {
            extract($aRow);
            $iCount++;
            $iFamilyMemberRows++;
            $aFirstNames[$iCount] = $per_FirstName;
            $aMiddleNames[$iCount] = $per_MiddleName;
            $aLastNames[$iCount] = $per_LastName;
            $aSuffix[$iCount] = $per_Suffix;
            $aGenders[$iCount] = $per_Gender;
            $aRoles[$iCount] = $per_fmr_ID;
            $aBirthMonths[$iCount] = $per_BirthMonth;
            $aBirthDays[$iCount] = $per_BirthDay;
            if ($per_BirthYear > 0) {
                $aBirthYears[$iCount] = $per_BirthYear;
            } else {
                $aBirthYears[$iCount] = '';
            }
            $aClassification[$iCount] = $per_cls_ID;
            $aPersonIDs[$iCount] = $per_ID;
            $aPerFlag[$iCount] = $per_Flags;
        }
    } else {
        //Adding....
        //Set defaults
        $sCity = SystemConfig::getValue('sDefaultCity');
        $sCountry = SystemConfig::getValue('sDefaultCountry');
        $sState = SystemConfig::getValue('sDefaultState');
        $iClassification = '0';
        $iFamilyMemberRows = 6;
        $bOkToCanvass = 1;

        $iFamilyID = -1;
        $sName = '';
        $sAddress1 = '';
        $sAddress2 = '';
        $sZip = '';
        $sHomePhone = '';
        $bNoFormat_HomePhone = isset($_POST['NoFormat_HomePhone']);
        $sWorkPhone = '';
        $bNoFormat_WorkPhone = isset($_POST['NoFormat_WorkPhone']);
        $sCellPhone = '';
        $bNoFormat_CellPhone = isset($_POST['NoFormat_CellPhone']);
        $sEmail = '';
        $bSendNewsLetter = 'TRUE';
        $iCanvasser = -1;
        $dWeddingDate = '';
        $nLatitude = 0.0;
        $nLongitude = 0.0;

        //Loop through the Family Member 'quick entry' form fields
        for ($iCount = 1; $iCount <= $iFamilyMemberRows; $iCount++) {
            // Assign everything to arrays
            $aFirstNames[$iCount] = '';
            $aMiddleNames[$iCount] = '';
            $aLastNames[$iCount] = '';
            $aSuffix[$iCount] = '';
            $aRoles[$iCount] = 0;
            $aGenders[$iCount] = '';
            $aBirthDays[$iCount] = 0;
            $aBirthMonths[$iCount] = 0;
            $aBirthYears[$iCount] = '';
            $aClassification[$iCount] = 0;
            $aPersonIDs[$iCount] = 0;
            $aUpdateBirthYear[$iCount] = 0;
        }

        $aCustomData = [];
        $aCustomErrors = [];
        if ($numCustomFields > 0) {
            mysqli_data_seek($rsCustomFields, 0);
            while ($rowCustomField = mysqli_fetch_array($rsCustomFields, MYSQLI_BOTH)) {
                extract($rowCustomField);
                $aCustomData[$fam_custom_Field] = '';
                $aCustomErrors[$fam_custom_Field] = false;
            }
        }
    }
}
//add family end

$sPreviousPage = '';
if (array_key_exists('previousPage', $_GET)) {
    $sPreviousPage = InputUtils::LegacyFilterInput($_GET['previousPage']);
}

// Security: User must have Add or Edit Records permission to use this form in those manners
// Clean error handling: (such as somebody typing an incorrect URL ?PersonID= manually)
if ($iPersonID > 0) {
    $sSQL = 'SELECT per_fam_ID FROM person_per WHERE per_ID = ' . $iPersonID;
    $rsPerson = RunQuery($sSQL);
    extract(mysqli_fetch_array($rsPerson));

    if (mysqli_num_rows($rsPerson) == 0) {
        RedirectUtils::Redirect('Menu.php');
        exit;
    }

    if (
        !(
            AuthenticationManager::GetCurrentUser()->isEditRecordsEnabled() ||
            (AuthenticationManager::GetCurrentUser()->isEditSelfEnabled() && $iPersonID == AuthenticationManager::GetCurrentUser()->getId()) ||
            (AuthenticationManager::GetCurrentUser()->isEditSelfEnabled() && $per_fam_ID > 0 && $per_fam_ID == AuthenticationManager::GetCurrentUser()->getPerson()->getFamId())
        )
    ) {
        RedirectUtils::Redirect('Menu.php');
        exit;
    }
} elseif (!AuthenticationManager::GetCurrentUser()->isAddRecordsEnabled()) {
    RedirectUtils::Redirect('Menu.php');
    exit;
}
// Get Field Security List Matrix
$sSQL = 'SELECT * FROM list_lst WHERE lst_ID = 5 ORDER BY lst_OptionSequence';
$rsSecurityGrp = RunQuery($sSQL);

while ($aRow = mysqli_fetch_array($rsSecurityGrp)) {
    extract($aRow);
    $aSecurityType[$lst_OptionID] = $lst_OptionName;
}

// Get the list of custom person fields
$sSQL = 'SELECT person_custom_master.* FROM person_custom_master ORDER BY custom_Order';
$rsCustomFields = RunQuery($sSQL);
$numCustomFields = mysqli_num_rows($rsCustomFields);

//Initialize the error flag
$bErrorFlag = false;
$sFirstNameError = '';
$sMiddleNameError = '';
$sLastNameError = '';
$sGenderError = '';
$sEmailError = '';
$sWorkEmailError = '';
$sBirthDateError = '';
$sBirthYearError = '';
$sFriendDateError = '';
$sMembershipDateError = '';
$aCustomErrors = [];

$fam_Country = '';

$bNoFormat_HomePhone = false;
$bNoFormat_WorkPhone = false;
$bNoFormat_CellPhone = false;
$sFacebookError = false;
$sTwitterError = false;
$sLinkedInError = false;

//Is this the second pass?
if (isset($_POST['PersonSubmit']) || isset($_POST['PersonSubmitAndAdd'])) {
    //Get all the variables from the request object and assign them locally
    $sTitle = InputUtils::LegacyFilterInput($_POST['Title']);
    $sFirstName = InputUtils::LegacyFilterInput($_POST['FirstName']);
    $sMiddleName = InputUtils::LegacyFilterInput($_POST['MiddleName']);
    $sLastName = InputUtils::LegacyFilterInput($_POST['LastName']);
    $sSuffix = InputUtils::LegacyFilterInput($_POST['Suffix']);
    $iGender = InputUtils::LegacyFilterInput($_POST['Gender'], 'int');

     // must input gender
     if ($iGender < 1 && !SystemConfig::getValue('bAllowEmptyGender')) {
        if ($iGender < 1) {
            $sGenderError = gettext('You must enter gender');
            $bErrorFlag = true;
        } 
    }

    // Person address stuff is normally surpressed in favor of family address info
    $sAddress1 = '';
    $sAddress2 = '';
    $sCity = '';
    $sZip = '';
    $sCountry = '';
    if (array_key_exists('Address1', $_POST)) {
        $sAddress1 = InputUtils::LegacyFilterInput($_POST['Address1']);
    }
    if (array_key_exists('Address2', $_POST)) {
        $sAddress2 = InputUtils::LegacyFilterInput($_POST['Address2']);
    }
    if (array_key_exists('City', $_POST)) {
        $sCity = InputUtils::LegacyFilterInput($_POST['City']);
    }
    if (array_key_exists('Zip', $_POST)) {
        $sZip = InputUtils::LegacyFilterInput($_POST['Zip']);
    }

    // bevand10 2012-04-26 Add support for uppercase ZIP - controlled by administrator via cfg param
    if (SystemConfig::getBooleanValue('bForceUppercaseZip')) {
        $sZip = strtoupper($sZip);
    }

    if (array_key_exists('Country', $_POST)) {
        $sCountry = InputUtils::LegacyFilterInput($_POST['Country']);
    }

    $iFamily = InputUtils::LegacyFilterInput($_POST['Family'], 'int');
    $iFamilyRole = InputUtils::LegacyFilterInput($_POST['FamilyRole'], 'int');

    // Get their family's country in case person's country was not entered
    if ($iFamily > 0) {
        $sSQL = 'SELECT fam_Country FROM family_fam WHERE fam_ID = ' . $iFamily;
        $rsFamCountry = RunQuery($sSQL);
        extract(mysqli_fetch_array($rsFamCountry));
    }

    $sCountryTest = SelectWhichInfo($sCountry, $fam_Country, false);
    $sState = '';
    if ($sCountryTest == 'United States' || $sCountryTest == 'Canada') {
        if (array_key_exists('State', $_POST)) {
            $sState = InputUtils::LegacyFilterInput($_POST['State']);
        }
    } else {
        if (array_key_exists('StateTextbox', $_POST)) {
            $sState = InputUtils::LegacyFilterInput($_POST['StateTextbox']);
        }
    }

    $sHomePhone = InputUtils::LegacyFilterInput($_POST['HomePhone']);
    $sWorkPhone = InputUtils::LegacyFilterInput($_POST['WorkPhone']);
    $sCellPhone = InputUtils::LegacyFilterInput($_POST['CellPhone']);
    $sEmail = InputUtils::LegacyFilterInput($_POST['Email']);
    $sWorkEmail = InputUtils::LegacyFilterInput($_POST['WorkEmail']);
    $iBirthMonth = InputUtils::LegacyFilterInput($_POST['BirthMonth'], 'int');
    $iBirthDay = InputUtils::LegacyFilterInput($_POST['BirthDay'], 'int');
    $iBirthYear = InputUtils::LegacyFilterInput($_POST['BirthYear'], 'int');
    $bHideAge = isset($_POST['HideAge']);
    // Philippe Logel
    $dFriendDate = InputUtils::FilterDate($_POST['FriendDate']);
    $dMembershipDate = InputUtils::FilterDate($_POST['MembershipDate']);
    $iClassification = InputUtils::LegacyFilterInput($_POST['Classification'], 'int');
    $iEnvelope = 0;
    if (array_key_exists('EnvID', $_POST)) {
        $iEnvelope = InputUtils::LegacyFilterInput($_POST['EnvID'], 'int');
    }
    if (array_key_exists('updateBirthYear', $_POST)) {
        $iupdateBirthYear = InputUtils::LegacyFilterInput($_POST['updateBirthYear'], 'int');
    }

    $iFacebook = InputUtils::FilterInt($_POST['Facebook']);
    $sTwitter = InputUtils::FilterString($_POST['Twitter']);
    $sLinkedIn = InputUtils::FilterString($_POST['LinkedIn']);

    $bNoFormat_HomePhone = isset($_POST['NoFormat_HomePhone']);
    $bNoFormat_WorkPhone = isset($_POST['NoFormat_WorkPhone']);
    $bNoFormat_CellPhone = isset($_POST['NoFormat_CellPhone']);

    //Adjust variables as needed
    if ($iFamily == 0) {
        $iFamilyRole = 0;
    }

    //Validate the Last Name.  If family selected, but no last name, inherit from family.
    if (strlen($sLastName) < 1 && !SystemConfig::getValue('bAllowEmptyLastName')) {
        if ($iFamily < 1) {
            $sLastNameError = gettext('You must enter a Last Name if no Family is selected.');
            $bErrorFlag = true;
        } else {
            $sSQL = 'SELECT fam_Name FROM family_fam WHERE fam_ID = ' . $iFamily;
            $rsFamName = RunQuery($sSQL);
            $aTemp = mysqli_fetch_array($rsFamName);
            $sLastName = $aTemp[0];
        }
    }

    // If they entered a full date, see if it's valid
    if (strlen($iBirthYear) > 0) {
        if ($iBirthYear == 0) { // If zero set to NULL
            $iBirthYear = null;
        } elseif ($iBirthYear > 2155 || $iBirthYear < 1901) {
            $sBirthYearError = gettext('Invalid Year: allowable values are 1901 to 2155');
            $bErrorFlag = true;
        } elseif ($iBirthMonth > 0 && $iBirthDay > 0) {
            if (!checkdate($iBirthMonth, $iBirthDay, $iBirthYear)) {
                $sBirthDateError = gettext('Invalid Birth Date.');
                $bErrorFlag = true;
            }
        }
    }

    // Validate Friend Date if one was entered
    if (strlen($dFriendDate) > 0) {
        $dateString = parseAndValidateDate($dFriendDate, $locale = 'US', $pasfut = 'past');
        if ($dateString === false) {
            $sFriendDateError = '<span style="color: red; ">'
                . gettext('Not a valid Friend Date') . '</span>';
            $bErrorFlag = true;
        } else {
            $dFriendDate = $dateString;
        }
    }

    // Validate Membership Date if one was entered
    if (strlen($dMembershipDate) > 0) {
        $dateString = parseAndValidateDate($dMembershipDate, $locale = 'US', $pasfut = 'past');
        if ($dateString === false) {
            $sMembershipDateError = '<span style="color: red; ">'
                . gettext('Not a valid Membership Date') . '</span>';
            $bErrorFlag = true;
        } else {
            $dMembershipDate = $dateString;
        }
    }

    // Validate Email
    if (strlen($sEmail) > 0) {
        if (checkEmail($sEmail) == false) {
            $sEmailError = '<span style="color: red; ">'
                . gettext('Email is Not Valid') . '</span>';
            $bErrorFlag = true;
        } else {
            $sEmail = $sEmail;
        }
    }

    // Validate Work Email
    if (strlen($sWorkEmail) > 0) {
        if (checkEmail($sWorkEmail) == false) {
            $sWorkEmailError = '<span style="color: red; ">'
                . gettext('Work Email is Not Valid') . '</span>';
            $bErrorFlag = true;
        } else {
            $sWorkEmail = $sWorkEmail;
        }
    }

    // Validate all the custom fields
    $aCustomData = [];
    while ($rowCustomField = mysqli_fetch_array($rsCustomFields, MYSQLI_BOTH)) {
        extract($rowCustomField);

        if (AuthenticationManager::GetCurrentUser()->isEnabledSecurity($aSecurityType[$custom_FieldSec])) {
            $currentFieldData = InputUtils::LegacyFilterInput($_POST[$custom_Field]);

            $bErrorFlag |= !validateCustomField($type_ID, $currentFieldData, $custom_Field, $aCustomErrors);

            // assign processed value locally to $aPersonProps so we can use it to generate the form later
            $aCustomData[$custom_Field] = $currentFieldData;
        }
    }

    //If no errors, then let's update...
    if (!$bErrorFlag) {
        $sPhoneCountry = SelectWhichInfo($sCountry, $fam_Country, false);

        if (!$bNoFormat_HomePhone) {
            $sHomePhone = CollapsePhoneNumber($sHomePhone, $sPhoneCountry);
        }
        if (!$bNoFormat_WorkPhone) {
            $sWorkPhone = CollapsePhoneNumber($sWorkPhone, $sPhoneCountry);
        }
        if (!$bNoFormat_CellPhone) {
            $sCellPhone = CollapsePhoneNumber($sCellPhone, $sPhoneCountry);
        }

        //If no birth year, set to NULL
        if ((strlen($iBirthYear) != 4)) {
            $iBirthYear = 'NULL';
        } else {
            $iBirthYear = "'$iBirthYear'";
        }

        // New Family (add)
        // Family will be named by the Last Name.
        if ($iFamily == -1) {
            $sSQL = "INSERT INTO family_fam (fam_Name, fam_Address1, fam_Address2, fam_City, fam_State, fam_Zip, fam_Country, fam_HomePhone, fam_WorkPhone, fam_CellPhone, fam_Email, fam_DateEntered, fam_EnteredBy)
					VALUES ('" . $sLastName . "','" . $sAddress1 . "','" . $sAddress2 . "','" . $sCity . "','" . $sState . "','" . $sZip . "','" . $sCountry . "','" . $sHomePhone . "','" . $sWorkPhone . "','" . $sCellPhone . "','" . $sEmail . "','" . date('YmdHis') . "'," . AuthenticationManager::GetCurrentUser()->getId() . ')';
            //Execute the SQL
            RunQuery($sSQL);
            //Get the key back
            $sSQL = 'SELECT MAX(fam_ID) AS iFamily FROM family_fam';
            $rsLastEntry = RunQuery($sSQL);
            extract(mysqli_fetch_array($rsLastEntry));
        }

        if ($bHideAge) {
            $per_Flags = 1;
        } else {
            $per_Flags = 0;
        }

        // New Person (add)
        if ($iPersonID < 1) {
            $iEnvelope = 0;

            $sSQL = "INSERT INTO person_per (per_Title, per_FirstName, per_MiddleName, per_LastName, per_Suffix, per_Gender, per_Address1, per_Address2, per_City, per_State, per_Zip, per_Country, per_HomePhone, per_WorkPhone, per_CellPhone, per_Email, per_WorkEmail, per_BirthMonth, per_BirthDay, per_BirthYear, per_Envelope, per_fam_ID, per_fmr_ID, per_MembershipDate, per_cls_ID, per_DateEntered, per_EnteredBy, per_FriendDate, per_Flags, per_FacebookID, per_Twitter, per_LinkedIn)
			         VALUES ('" . $sTitle . "','" . $sFirstName . "','" . $sMiddleName . "','" . $sLastName . "','" . $sSuffix . "'," . $iGender . ",'" . $sAddress1 . "','" . $sAddress2 . "','" . $sCity . "','" . $sState . "','" . $sZip . "','" . $sCountry . "','" . $sHomePhone . "','" . $sWorkPhone . "','" . $sCellPhone . "','" . $sEmail . "','" . $sWorkEmail . "'," . $iBirthMonth . ',' . $iBirthDay . ',' . $iBirthYear . ',' . $iEnvelope . ',' . $iFamily . ',' . $iFamilyRole . ',';
            if (strlen($dMembershipDate) > 0) {
                $sSQL .= '"' . $dMembershipDate . '"';
            } else {
                $sSQL .= 'NULL';
            }
            $sSQL .= ',' . $iClassification . ",'" . date('YmdHis') . "'," . AuthenticationManager::GetCurrentUser()->getId() . ',';

            if (strlen($dFriendDate) > 0) {
                $sSQL .= '"' . $dFriendDate . '"';
            } else {
                $sSQL .= 'NULL';
            }

            $sSQL .= ', ' . $per_Flags;
            $sSQL .= ', ' . $iFacebook;
            $sSQL .= ', "' . $sTwitter . '"';
            $sSQL .= ', "' . $sLinkedIn . '"';
            $sSQL .= ')';

            $bGetKeyBack = true;

            // Existing person (update)
        } else {
            $sSQL = "UPDATE person_per SET per_Title = '" . $sTitle . "',per_FirstName = '" . $sFirstName . "',per_MiddleName = '" . $sMiddleName . "', per_LastName = '" . $sLastName . "', per_Suffix = '" . $sSuffix . "', per_Gender = " . $iGender . ", per_Address1 = '" . $sAddress1 . "', per_Address2 = '" . $sAddress2 . "', per_City = '" . $sCity . "', per_State = '" . $sState . "', per_Zip = '" . $sZip . "', per_Country = '" . $sCountry . "', per_HomePhone = '" . $sHomePhone . "', per_WorkPhone = '" . $sWorkPhone . "', per_CellPhone = '" . $sCellPhone . "', per_Email = '" . $sEmail . "', per_WorkEmail = '" . $sWorkEmail . "', per_BirthMonth = " . $iBirthMonth . ', per_BirthDay = ' . $iBirthDay . ', ' . 'per_BirthYear = ' . $iBirthYear . ', per_fam_ID = ' . $iFamily . ', per_Fmr_ID = ' . $iFamilyRole . ', per_cls_ID = ' . $iClassification . ', per_MembershipDate = ';
            if (strlen($dMembershipDate) > 0) {
                $sSQL .= '"' . $dMembershipDate . '"';
            } else {
                $sSQL .= 'NULL';
            }

            if (AuthenticationManager::GetCurrentUser()->isFinanceEnabled()) {
                $sSQL .= ', per_Envelope = ' . $iEnvelope;
            }

            $sSQL .= ", per_DateLastEdited = '" . date('YmdHis') . "', per_EditedBy = " . AuthenticationManager::GetCurrentUser()->getId() . ', per_FriendDate =';

            if (strlen($dFriendDate) > 0) {
                $sSQL .= '"' . $dFriendDate . '"';
            } else {
                $sSQL .= 'NULL';
            }

            $sSQL .= ', per_Flags=' . $per_Flags;

            $sSQL .= ', per_FacebookID=' . $iFacebook;
            $sSQL .= ', per_Twitter="' . $sTwitter . '"';
            $sSQL .= ', per_LinkedIn="' . $sLinkedIn . '"';

            $sSQL .= ' WHERE per_ID = ' . $iPersonID;

            $bGetKeyBack = false;
        }

        //Execute the SQL
        RunQuery($sSQL);


        $note = new Note();
        $note->setEntered(AuthenticationManager::GetCurrentUser()->getId());
        // If this is a new person, get the key back and insert a blank row into the person_custom table
        if ($bGetKeyBack) {
            $sSQL = 'SELECT MAX(per_ID) AS iPersonID FROM person_per';
            $rsPersonID = RunQuery($sSQL);
            extract(mysqli_fetch_array($rsPersonID));
            $sSQL = "INSERT INTO person_custom (per_ID) VALUES ('" . $iPersonID . "')";
            RunQuery($sSQL);
            $note->setPerId($iPersonID);
            $note->setText(gettext('Created'));
            $note->setType('create');


            if (!empty(SystemConfig::getValue("sNewPersonNotificationRecipientIDs"))) {
                $person = PersonQuery::create()->findOneByID($iPersonID);
                $NotificationEmail = new NewPersonOrFamilyEmail($person);
                if (!$NotificationEmail->send()) {
                    LoggerUtils::getAppLogger()->warn($NotificationEmail->getError());
                }
            }
        } else {
            $note->setPerId($iPersonID);
            $note->setText(gettext('Updated'));
            $note->setType('edit');
        }
        $note->save();

        $photo = new Photo("Person", $iPersonID);
        $photo->refresh();

        // Update the custom person fields.
        if ($numCustomFields > 0) {
            mysqli_data_seek($rsCustomFields, 0);
            $sSQL = '';
            while ($rowCustomField = mysqli_fetch_array($rsCustomFields, MYSQLI_BOTH)) {
                extract($rowCustomField);
                if (AuthenticationManager::GetCurrentUser()->isEnabledSecurity($aSecurityType[$custom_FieldSec])) {
                    $currentFieldData = trim($aCustomData[$custom_Field]);
                    sqlCustomField($sSQL, $type_ID, $currentFieldData, $custom_Field, $sPhoneCountry);
                }
            }

            // chop off the last 2 characters (comma and space) added in the last while loop iteration.
            if ($sSQL > '') {
                $sSQL = 'REPLACE INTO person_custom SET ' . $sSQL . ' per_ID = ' . $iPersonID;
                //Execute the SQL
                RunQuery($sSQL);
            }
        }

        // Check for redirection to another page after saving information: (ie. PersonEditor.php?previousPage=prev.php?a=1;b=2;c=3)
        if ($sPreviousPage != '') {
            $sPreviousPage = str_replace(';', '&', $sPreviousPage);
            RedirectUtils::Redirect($sPreviousPage . $iPersonID);
        } elseif (isset($_POST['PersonSubmit'])) {

            //Send to the view of this person

            sleep(2);
            RedirectUtils::Redirect('PersonView.php?PersonID=' . $iPersonID);
        } else {
            //Reload to editor to add another record
            RedirectUtils::Redirect('PersonEditor.php');
        }
    }

    // Set the envelope in case the form failed.
    $per_Envelope = $iEnvelope;
} else {

    //FirstPass
    //Are we editing or adding?
    if ($iPersonID > 0) {
        //Editing....
        //Get all the data on this record

        $sSQL = 'SELECT * FROM person_per LEFT JOIN family_fam ON per_fam_ID = fam_ID WHERE per_ID = ' . $iPersonID;
        $rsPerson = RunQuery($sSQL);
        extract(mysqli_fetch_array($rsPerson));

        $sTitle = $per_Title;
        $sFirstName = $per_FirstName;
        $sMiddleName = $per_MiddleName;
        $sLastName = $per_LastName;
        $sSuffix = $per_Suffix;
        $iGender = $per_Gender;
        $sAddress1 = $per_Address1;
        $sAddress2 = $per_Address2;
        $sCity = $per_City;
        $sState = $per_State;
        $sZip = $per_Zip;
        $sCountry = $per_Country;
        $sHomePhone = $per_HomePhone;
        $sWorkPhone = $per_WorkPhone;
        $sCellPhone = $per_CellPhone;
        $sEmail = $per_Email;
        $sWorkEmail = $per_WorkEmail;
        $iBirthMonth = $per_BirthMonth;
        $iBirthDay = $per_BirthDay;
        $iBirthYear = $per_BirthYear;
        $bHideAge = ($per_Flags & 1) != 0;
        $iOriginalFamily = $per_fam_ID;
        $iFamily = $per_fam_ID;
        $iFamilyRole = $per_fmr_ID;
        $dMembershipDate = $per_MembershipDate;
        $dFriendDate = $per_FriendDate;
        $iClassification = $per_cls_ID;
        $iViewAgeFlag = $per_Flags;

        $iFacebookID = $per_FacebookID;
        $sTwitter = $per_Twitter;
        $sLinkedIn = $per_LinkedIn;

        $sPhoneCountry = SelectWhichInfo($sCountry, $fam_Country, false);

        $sHomePhone = ExpandPhoneNumber($per_HomePhone, $sPhoneCountry, $bNoFormat_HomePhone);
        $sWorkPhone = ExpandPhoneNumber($per_WorkPhone, $sPhoneCountry, $bNoFormat_WorkPhone);
        $sCellPhone = ExpandPhoneNumber($per_CellPhone, $sPhoneCountry, $bNoFormat_CellPhone);

        //The following values are True booleans if the family record has a value for the
        //indicated field.  These are used to highlight field headers in red.
        $bFamilyAddress1 = strlen($fam_Address1);
        $bFamilyAddress2 = strlen($fam_Address2);
        $bFamilyCity = strlen($fam_City);
        $bFamilyState = strlen($fam_State);
        $bFamilyZip = strlen($fam_Zip);
        $bFamilyCountry = strlen($fam_Country);
        $bFamilyHomePhone = strlen($fam_HomePhone);
        $bFamilyWorkPhone = strlen($fam_WorkPhone);
        $bFamilyCellPhone = strlen($fam_CellPhone);
        $bFamilyEmail = strlen($fam_Email);

        $bFacebookID = $per_FacebookID != 0;
        $bTwitter = strlen($per_Twitter);
        $bLinkedIn = strlen($per_LinkedIn);

        $sSQL = 'SELECT * FROM person_custom WHERE per_ID = ' . $iPersonID;
        $rsCustomData = RunQuery($sSQL);
        $aCustomData = [];
        if (mysqli_num_rows($rsCustomData) >= 1) {
            $aCustomData = mysqli_fetch_array($rsCustomData, MYSQLI_BOTH);
        }
    } else {
        //Adding....
        //Set defaults
        $sTitle = '';
        $sFirstName = '';
        $sMiddleName = '';
        $sLastName = '';
        $sSuffix = '';
        $iGender = '';
        $sAddress1 = '';
        $sAddress2 = '';
        $sCity = SystemConfig::getValue('sDefaultCity');
        $sState = SystemConfig::getValue('sDefaultState');
        $sZip = '';
        $sCountry = SystemConfig::getValue('sDefaultCountry');
        $sHomePhone = '';
        $sWorkPhone = '';
        $sCellPhone = '';
        $sEmail = '';
        $sWorkEmail = '';
        $iBirthMonth = 0;
        $iBirthDay = 0;
        $iBirthYear = 0;
        $bHideAge = 0;
        $iOriginalFamily = 0;
        $iFamily = '0';
        $iFamilyRole = '0';
        $dMembershipDate = '';
        $dFriendDate = date('Y-m-d');
        $iClassification = '0';
        $iViewAgeFlag = 0;
        $sPhoneCountry = '';

        $iFacebookID = 0;
        $sTwitter = '';
        $sLinkedIn = '';


        $sHomePhone = '';
        $sWorkPhone = '';
        $sCellPhone = '';

        //The following values are True booleans if the family record has a value for the
        //indicated field.  These are used to highlight field headers in red.
        $bFamilyAddress1 = 0;
        $bFamilyAddress2 = 0;
        $bFamilyCity = 0;
        $bFamilyState = 0;
        $bFamilyZip = 0;
        $bFamilyCountry = 0;
        $bFamilyHomePhone = 0;
        $bFamilyWorkPhone = 0;
        $bFamilyCellPhone = 0;
        $bFamilyEmail = 0;
        $bHomeBound = false;
        $aCustomData = [];
    }
}

//Get Classifications for the drop-down
$sSQL = 'SELECT * FROM list_lst WHERE lst_ID = 1 ORDER BY lst_OptionSequence';
$rsClassifications = RunQuery($sSQL);

//Get Families for the drop-down
$sSQL = 'SELECT * FROM family_fam ORDER BY fam_Name';
$rsFamilies = RunQuery($sSQL);

//Get Family Roles for the drop-down
$sSQL = 'SELECT * FROM list_lst WHERE lst_ID = 2 ORDER BY lst_OptionSequence';
$rsFamilyRoles = RunQuery($sSQL);

require 'Include/Header.php';

?>

<form method="post" action="PersonEditor.php?PersonID=<?= $iPersonID ?>" name="PersonEditor">
    <div class="alert alert-info alert-dismissable">
        <i class="fa fa-info"></i>
        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
        <strong><span style="color: red;"><?= gettext('Red text') ?></span></strong>
        <?php echo gettext('indicates items inherited from the associated family record.'); ?>
    </div>
    <?php if ($bErrorFlag) {
        ?>
        <div class="alert alert-danger alert-dismissable">
            <i class="fa fa-ban"></i>
            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
            <?= gettext('Invalid fields or selections. Changes not saved! Please correct and try again!') ?>
        </div>
        <?php
    } ?>
    <div class="box box-info clearfix">
        <div class="box-header">
            <h3 class="box-title">
                <?= gettext('Personal Info') ?>
            </h3>
            <div class="pull-right"><br />
                <input type="submit" class="btn btn-primary" value="<?= gettext('Save') ?>" name="PersonSubmit">
            </div>
        </div><!-- /.box-header -->
        <div class="box-body">
            <div class="form-group">
                <div class="row">
                    <div class="col-md-2">
                        <label>
                            <?= gettext('Gender') ?><span style="color: red;">*</span>:
                        </label>
                        <select name="Gender" class="form-control" required>
                            <option value="0">
                                <?= gettext('Select Gender') ?>
                            </option>
                            <option value="0" disabled>-----------------------</option>
                            <option value="1" <?php if ($iGender == 1) {
                                echo 'selected';
                            } ?>><?= gettext('Male') ?>
                            </option>
                            <option value="2" <?php if ($iGender == 2) {
                                echo 'selected';
                            } ?>><?= gettext('Female') ?>
                            </option>
                        </select>
                        <?php if ($sGenderError) {
                            ?><br>
                            <font color="red"><?php echo $sGenderError ?></font>
                            <?php
                        } ?>
                    </div>
                    <div class="col-md-3">
                        <label for="Title">
                            <?= gettext('Title') ?>:
                        </label>
                        <input type="text" name="Title" id="Title"
                            value="<?= htmlentities(stripslashes($sTitle), ENT_NOQUOTES, 'UTF-8') ?>"
                            class="form-control" placeholder="<?= gettext('Mr., Mrs., Dr., Rev.') ?>">
                    </div>
                </div>
                <p />
                <div class="row">
                    <div class="col-md-4">
                        <label for="FirstName">
                            <?= gettext('First Name') ?><span style="color: red;"><?= gettext('*') ?></span>:
                        </label>
                        <input type="text" name="FirstName" id="FirstName"
                            value="<?= htmlentities(stripslashes($sFirstName), ENT_NOQUOTES, 'UTF-8') ?>"
                            class="form-control">
                        <?php if ($sFirstNameError) {
                            ?><br>
                            <font color="red"><?php echo $sFirstNameError ?></font>
                            <?php
                        } ?>
                    </div>

                    <div class="col-md-2">
                        <label for="MiddleName">
                            <?= gettext('Middle Name') ?>:
                        </label>
                        <input type="text" name="MiddleName" id="MiddleName"
                            value="<?= htmlentities(stripslashes($sMiddleName), ENT_NOQUOTES, 'UTF-8') ?>"
                            class="form-control">
                        <?php if ($sMiddleNameError) {
                            ?><br>
                            <font color="red"><?php echo $sMiddleNameError ?></font>
                            <?php
                        } ?>
                    </div>

                    <div class="col-md-4">
                        <label for="LastName">
                            <?= gettext('Last Name') ?><span style="color: red;"><?= gettext('*') ?></span>:
                        </label>
                        <input type="text" name="LastName" id="LastName"
                            value="<?= htmlentities(stripslashes($sLastName), ENT_NOQUOTES, 'UTF-8') ?>"
                            class="form-control">
                        <?php if ($sLastNameError) {
                            ?><br>
                            <font color="red"><?php echo $sLastNameError ?></font>
                            <?php
                        } ?>
                    </div>

                    <div class="col-md-1">
                        <label for="Suffix">
                            <?= gettext('Suffix') ?>:
                        </label>
                        <input type="text" name="Suffix" id="Suffix"
                            value="<?= htmlentities(stripslashes($sSuffix), ENT_NOQUOTES, 'UTF-8') ?>"
                            placeholder="<?= gettext('Jr., Sr., III') ?>" class="form-control">
                    </div>
                </div>
                <p />
                <div class="row">
                    <div class="col-md-2">
                        <label>
                            <?= gettext('Birth Month') ?><span style="color: red;"><?= gettext('*') ?></span>:
                        </label>
                        <select name="BirthMonth" class="form-control">
                            <option value="0" <?php if ($iBirthMonth == 0) {
                                echo 'selected';
                            } ?>><?= gettext('Select Month') ?></option>
                            <option value="01" <?php if ($iBirthMonth == 1) {
                                echo 'selected';
                            } ?>><?= gettext('January') ?></option>
                            <option value="02" <?php if ($iBirthMonth == 2) {
                                echo 'selected';
                            } ?>><?= gettext('February') ?></option>
                            <option value="03" <?php if ($iBirthMonth == 3) {
                                echo 'selected';
                            } ?>><?= gettext('March') ?></option>
                            <option value="04" <?php if ($iBirthMonth == 4) {
                                echo 'selected';
                            } ?>><?= gettext('April') ?></option>
                            <option value="05" <?php if ($iBirthMonth == 5) {
                                echo 'selected';
                            } ?>><?= gettext('May') ?>
                            </option>
                            <option value="06" <?php if ($iBirthMonth == 6) {
                                echo 'selected';
                            } ?>><?= gettext('June') ?>
                            </option>
                            <option value="07" <?php if ($iBirthMonth == 7) {
                                echo 'selected';
                            } ?>><?= gettext('July') ?>
                            </option>
                            <option value="08" <?php if ($iBirthMonth == 8) {
                                echo 'selected';
                            } ?>><?= gettext('August') ?></option>
                            <option value="09" <?php if ($iBirthMonth == 9) {
                                echo 'selected';
                            } ?>><?= gettext('September') ?></option>
                            <option value="10" <?php if ($iBirthMonth == 10) {
                                echo 'selected';
                            } ?>><?= gettext('October') ?></option>
                            <option value="11" <?php if ($iBirthMonth == 11) {
                                echo 'selected';
                            } ?>><?= gettext('November') ?></option>
                            <option value="12" <?php if ($iBirthMonth == 12) {
                                echo 'selected';
                            } ?>><?= gettext('December') ?></option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <label>
                            <?= gettext('Birth Day') ?><span style="color: red;"><?= gettext('*') ?></span>:
                        </label>
                        <select name="BirthDay" class="form-control">
                            <option value="0">
                                <?= gettext('Select Day') ?>
                            </option>
                            <?php for ($x = 1; $x < 32; $x++) {
                                if ($x < 10) {
                                    $sDay = '0' . $x;
                                } else {
                                    $sDay = $x;
                                } ?>
                                <option value="<?= $sDay ?>" <?php if ($iBirthDay == $x) {
                                      echo 'selected';
                                  } ?>><?= $x ?>
                                </option>
                                <?php
                            } ?>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <label>
                            <?= gettext('Birth Year') ?><span style="color: red;"><?= gettext('*') ?></span>:
                        </label>
                        <input type="text" name="BirthYear" value="<?php echo $iBirthYear ?>" maxlength="4" size="5"
                            placeholder="yyyy" class="form-control">
                        <?php if ($sBirthYearError) {
                            ?><font color="red"><br>
                                <?php echo $sBirthYearError ?>
                            </font>
                            <?php
                        } ?>
                        <?php if ($sBirthDateError) {
                            ?>
                            <font color="red"><?php echo $sBirthDateError ?></font>
                            <?php
                        } ?>
                    </div>
                    <div class="col-md-2">
                        <label>
                            <?= gettext('Hide Age') ?>
                        </label><br />
                        <input type="checkbox" name="HideAge" value="1" <?php if ($bHideAge) {
                            echo ' checked';
                        } ?> />
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="box box-info clearfix">
        <div class="box-header">
            <h3 class="box-title">
                <?= gettext('Family Info') ?>
            </h3>
            <div class="pull-right"><br />
                <input type="submit" class="btn btn-primary" value="<?= gettext('Save') ?>" name="PersonSubmit">
            </div>
        </div><!-- /.box-header -->
        <div class="box-body">
            <div class="form-group col-md-3">
                <label>
                    <?= gettext('Do you have a family?') ?>:
                </label>
                <select name="HasFamily" class="form-control">
                    <option value="0">
                        <?= gettext('Select') ?>
                    </option>
                    <option value="0" disabled>-----------------------</option>
                    <option value="1" <?php if ($iHavefamily == 1) {
                                echo 'selected';
                            } ?>><?= gettext('Yes') ?>
                            </option>
                            <option value="2" <?php if ($HaveFamily == 2) {
                                echo 'selected';
                            } ?>><?= gettext('No') ?>
                            </option>
                </select>
            </div>
        </div>
        <div class="box-body">
            <div class="form-group col-md-3">
                <label>
                    <?= gettext('Family Role') ?>:
                </label>
                <select name="FamilyRole" class="form-control">
                    <option value="0">
                        <?= gettext('Unassigned') ?>
                    </option>
                    <option value="0" disabled>-----------------------</option>
                    <?php while ($aRow = mysqli_fetch_array($rsFamilyRoles)) {
                        extract($aRow);
                        echo '<option value="' . $lst_OptionID . '"';
                        if ($iFamilyRole == $lst_OptionID) {
                            echo ' selected';
                        }
                        echo '>' . $lst_OptionName . '&nbsp;';
                    } ?>
                </select>
            </div>

            <div class="form-group col-md-6">
                <label>
                    <?= gettext('Family'); ?>:
                </label>
                <select name="Family" id="famailyId" class="form-control">
                    <option value="0" selected>
                        <?= gettext('Unassigned') ?>
                    </option>
                    <option value="-1">
                        <?= gettext('Create a new family (using last name)') ?>
                    </option>
                    <option value="0" disabled>-----------------------</option>
                    <?php while ($aRow = mysqli_fetch_array($rsFamilies)) {
                        extract($aRow);

                        echo '<option value="' . $fam_ID . '"';
                        if ($iFamily == $fam_ID || $_GET['FamilyID'] == $fam_ID) {
                            echo ' selected';
                        }
                        echo '>' . $fam_Name . '&nbsp;' . FormatAddressLine($fam_Address1, $fam_City, $fam_State);
                    } ?>
                </select>
            </div>
            
        </div>
        <div class="family-members-section" style="display: none;">
            <!-- Family list start -->
            <div class="box-body">
            <div class="box-header">
                <h3 class="box-title"><?= gettext('Family Members') ?></h3>
            </div><!-- /.box-header -->
            <?php if ($iFamilyMemberRows > 0) {
                ?>
                <tr>
                <td colspan="2">
                <div class="MediumText">
                    <center><?= $iFamilyID < 0 ? gettext('You may create family members now or add them later.  All entries will become <i>new</i> person records.') : '' ?></center>
                </div><br><br>
            <div class="table-responsive">
            <table cellpadding="3" cellspacing="0" width="100%">
                <thead>
                    <tr class="TableHeader" align="center">
                        <th><?= gettext('First') ?></th>
                        <th><?= gettext('Middle') ?></th>
                        <th><?= gettext('Last') ?></th>
                        <th><?= gettext('Suffix') ?></th>
                        <th><?= gettext('Gender') ?></th>
                        <th><?= gettext('Role') ?></th>
                        <th><?= gettext('Birth Month') ?></th>
                        <th><?= gettext('Birth Day') ?></th>
                        <th><?= gettext('Birth Year') ?></th>
                        <th><?= gettext('Classification') ?></th>
                    </tr>
                </thead>
                <?php

                //Get family roles
                $sSQL = 'SELECT * FROM list_lst WHERE lst_ID = 2 ORDER BY lst_OptionSequence';
                $rsFamilyRoles = RunQuery($sSQL);
                $numFamilyRoles = mysqli_num_rows($rsFamilyRoles);
                for ($c = 1; $c <= $numFamilyRoles; $c++) {
                    $aRow = mysqli_fetch_array($rsFamilyRoles);
                    extract($aRow);
                    $aFamilyRoleNames[$c] = $lst_OptionName;
                    $aFamilyRoleIDs[$c] = $lst_OptionID;
                }

                for ($iCount = 1; $iCount <= $iFamilyMemberRows; $iCount++) 
                    ?>
            <input type="hidden" name="PersonID<?= $iCount ?>" value="<?= $aPersonIDs[$iCount] ?>">
            <tr>
                <td class="TextColumn">
                    <input name="FirstName<?= $iCount ?>" type="text" value="<?= $aFirstNames[$iCount] ?>" size="10">
                    <div><font color="red"><?php if (array_key_exists($iCount, $aFirstNameError)) {
                        echo $aFirstNameError[$iCount];
                    } ?></font></div>
                </td>
                <td class="TextColumn">
                    <input name="MiddleName<?= $iCount ?>" type="text" value="<?= $aMiddleNames[$iCount] ?>" size="10">
                </td>
                <td class="TextColumn">
                    <input name="LastName<?= $iCount ?>" type="text" value="<?= $aLastNames[$iCount] ?>" size="10">
                </td>
                <td class="TextColumn">
                    <input name="Suffix<?= $iCount ?>" type="text" value="<?= $aSuffix[$iCount] ?>" size="10">
                </td>
                <td class="TextColumn">
                    <select name="Gender<?php echo $iCount ?>">
                        <option value="0" <?php if ($aGenders[$iCount] == 0) {
                            echo 'selected';
                        } ?> ><?= gettext('Select Gender') ?></option>
                        <option value="1" <?php if ($aGenders[$iCount] == 1) {
                            echo 'selected';
                        } ?> ><?= gettext('Male') ?></option>
                        <option value="2" <?php if ($aGenders[$iCount] == 2) {
                            echo 'selected';
                        } ?> ><?= gettext('Female') ?></option>
                    </select>
                </td>
                <td class="TextColumn">
                    <select name="Role<?php echo $iCount ?>">
                        <option value="0" <?php if ($aRoles[$iCount] == 0) {
                            echo 'selected';
                        } ?> ><?= gettext('Select Role') ?></option>
                    <?php
                    //Build the role select box
                    for ($c = 1; $c <= $numFamilyRoles; $c++) {
                        echo '<option value="' . $aFamilyRoleIDs[$c] . '"';
                        if ($aRoles[$iCount] == $aFamilyRoleIDs[$c]) {
                            echo ' selected';
                        }
                        echo '>' . $aFamilyRoleNames[$c] . '</option>';
                    } ?>
                    </select>
                </td>
                <td class="TextColumn">
                    <select name="BirthMonth<?php echo $iCount ?>">
                        <option value="0" <?php if ($aBirthMonths[$iCount] == 0) {
                            echo 'selected';
                        } ?>><?= gettext('Unknown') ?></option>
                        <option value="01" <?php if ($aBirthMonths[$iCount] == 1) {
                            echo 'selected';
                        } ?>><?= gettext('January') ?></option>
                        <option value="02" <?php if ($aBirthMonths[$iCount] == 2) {
                            echo 'selected';
                        } ?>><?= gettext('February') ?></option>
                        <option value="03" <?php if ($aBirthMonths[$iCount] == 3) {
                            echo 'selected';
                        } ?>><?= gettext('March') ?></option>
                        <option value="04" <?php if ($aBirthMonths[$iCount] == 4) {
                            echo 'selected';
                        } ?>><?= gettext('April') ?></option>
                        <option value="05" <?php if ($aBirthMonths[$iCount] == 5) {
                            echo 'selected';
                        } ?>><?= gettext('May') ?></option>
                        <option value="06" <?php if ($aBirthMonths[$iCount] == 6) {
                            echo 'selected';
                        } ?>><?= gettext('June') ?></option>
                        <option value="07" <?php if ($aBirthMonths[$iCount] == 7) {
                            echo 'selected';
                        } ?>><?= gettext('July') ?></option>
                        <option value="08" <?php if ($aBirthMonths[$iCount] == 8) {
                            echo 'selected';
                        } ?>><?= gettext('August') ?></option>
                        <option value="09" <?php if ($aBirthMonths[$iCount] == 9) {
                            echo 'selected';
                        } ?>><?= gettext('September') ?></option>
                        <option value="10" <?php if ($aBirthMonths[$iCount] == 10) {
                            echo 'selected';
                        } ?>><?= gettext('October') ?></option>
                        <option value="11" <?php if ($aBirthMonths[$iCount] == 11) {
                            echo 'selected';
                        } ?>><?= gettext('November') ?></option>
                        <option value="12" <?php if ($aBirthMonths[$iCount] == 12) {
                            echo 'selected';
                        } ?>><?= gettext('December') ?></option>
                    </select>
                </td>
                <td class="TextColumn">
                    <select name="BirthDay<?= $iCount ?>">
                        <option value="0"><?= gettext('Unk') ?></option>
                        <?php for ($x = 1; $x < 32; $x++) {
                            if ($x < 10) {
                                $sDay = '0' . $x;
                            } else {
                                $sDay = $x;
                            } ?>
                            <option value="<?= $sDay ?>" <?php if ($aBirthDays[$iCount] == $x) {
                                    echo 'selected';
                                } ?>><?= $x ?></option>
                        <?php
                        } ?>
                    </select>
                </td>
                <td class="TextColumn">
                    <?php if (!array_key_exists($iCount, $aperFlags) || !$aperFlags[$iCount]) {
                        $UpdateBirthYear = 1; ?>
                            <input name="BirthYear<?= $iCount ?>" type="text" value="<?= $aBirthYears[$iCount] ?>" size="4" maxlength="4">
                            <div><font color="red"><?php if (array_key_exists($iCount, $aBirthDateError)) {
                                echo $aBirthDateError[$iCount];
                            } ?></font></div>
                        <?php
                    } else {
                        $UpdateBirthYear = 0;
                    } ?>
                </td>
                <td>
                    <select name="Classification<?php echo $iCount ?>">
                    <option value="0" <?php if ($aClassification[$iCount] == 0) {
                                    echo 'selected';
                                } ?>><?= gettext('Unassigned') ?></option>
                                <option value="0" disabled>-----------------------</option>
                                <?php
                                //Get Classifications for the drop-down
                                $sSQL = 'SELECT * FROM list_lst WHERE lst_ID = 1 ORDER BY lst_OptionSequence';
                                $rsClassifications = RunQuery($sSQL);

                                //Display Classifications
                                while ($aRow = mysqli_fetch_array($rsClassifications)) {
                                    extract($aRow);
                                    echo '<option value="' . $lst_OptionID . '"';
                                    if ($aClassification[$iCount] == $lst_OptionID) {
                                        echo ' selected';
                                    }
                                    echo '>' . $lst_OptionName . '&nbsp;';
                                }
                                ?>
                    </select>
                </td>
            </tr>
            </input>
            </table>
            </div>
                            </td>
                            </tr>
            <?php } ?>
            </div>
            <?php
                echo '<td colspan="2" align="center">';
                echo '<input type="hidden" Name="UpdateBirthYear" value="' . $UpdateBirthYear . '">';
            ?>
            <!-- Add Row button -->
            <div style="display: flex; justify-content: center; align-items: center; height: 5vh;">
                <button type="button" id="addRowButton">Add Family Member</button>
            </div>
        </div>
        
        <!-- Family list end -->
    </div>
    
    <div class="box box-info clearfix">
        <div class="box-header">
            <h3 class="box-title">
                <?= gettext('Contact Info') ?>
            </h3>
            <div class="pull-right"><br />
                <input type="submit" class="btn btn-primary" value="<?= gettext('Save') ?>" name="PersonSubmit">
            </div>
        </div><!-- /.box-header -->
        <div class="box-body">
            <?php if (!SystemConfig::getValue('bHidePersonAddress')) { /* Person Address can be hidden - General Settings */?>
                <div class="row">
                    <div class="form-group">
                        <div class="col-md-6">
                            <label>
                                <?php if ($bFamilyAddress1) {
                                    echo '<span style="color: red;">';
                                }

                                echo gettext('Address') . ' 1:';

                                if ($bFamilyAddress1) {
                                    echo '</span>';
                                } ?>
                            </label>
                            <input type="text" name="Address1"
                                value="<?= htmlentities(stripslashes($sAddress1), ENT_NOQUOTES, 'UTF-8') ?>" size="30"
                                maxlength="50" class="form-control">
                        </div>
                        <div class="col-md-3">
                            <label>
                                <?php if ($bFamilyAddress2) {
                                    echo '<span style="color: red;">';
                                }

                                echo gettext('Address') . ' 2:';

                                if ($bFamilyAddress2) {
                                    echo '</span>';
                                } ?>
                            </label>
                            <input type="text" name="Address2"
                                value="<?= htmlentities(stripslashes($sAddress2), ENT_NOQUOTES, 'UTF-8') ?>" size="30"
                                maxlength="50" class="form-control">
                        </div>
                        <div class="col-md-3">
                            <label>
                                <?php if ($bFamilyCity) {
                                    echo '<span style="color: red;">';
                                }

                                echo gettext('City') . ':';

                                if ($bFamilyCity) {
                                    echo '</span>';
                                } ?>
                            </label>
                            <input type="text" name="City"
                                value="<?= htmlentities(stripslashes($sCity), ENT_NOQUOTES, 'UTF-8') ?>"
                                class="form-control">
                        </div>
                    </div>
                </div>
                <p />
                <div class="row">
                    <div class="form-group col-md-2">
                        <label for="StatleTextBox">
                            <?php if ($bFamilyState) {
                                echo '<span style="color: red;">';
                            }

                            echo gettext('State') . ':';

                            if ($bFamilyState) {
                                echo '</span>';
                            } ?>
                        </label>
                        <?php require 'Include/StateDropDown.php'; ?>
                    </div>
                    <div class="form-group col-md-2">
                        <label>
                            <?= gettext('None State') ?>:
                        </label>
                        <input type="text" name="StateTextbox" value="<?php if ($sPhoneCountry != 'United States' && $sPhoneCountry != 'Canada') {
                            echo htmlentities(stripslashes($sState), ENT_NOQUOTES, 'UTF-8');
                        } ?>" size="20" maxlength="30" class="form-control">
                    </div>

                    <div class="form-group col-md-1">
                        <label for="Zip">
                            <?php if ($bFamilyZip) {
                                echo '<span style="color: red;">';
                            }

                            echo gettext('Zip') . ':';

                            if ($bFamilyZip) {
                                echo '</span>';
                            } ?>
                        </label>
                        <input type="text" name="Zip" class="form-control" <?php
                        // bevand10 2012-04-26 Add support for uppercase ZIP - controlled by administrator via cfg param
                        if (SystemConfig::getBooleanValue('bForceUppercaseZip')) {
                            echo 'style="text-transform:uppercase" ';
                        }

                        echo 'value="' . htmlentities(stripslashes($sZip), ENT_NOQUOTES, 'UTF-8') . '" '; ?>
                            maxlength="10" size="8">
                    </div>
                    <div class="form-group col-md-2">
                        <label for="Zip">
                            <?php if ($bFamilyCountry) {
                                echo '<span style="color: red;">';
                            }

                            echo gettext('Country') . ':';

                            if ($bFamilyCountry) {
                                echo '</span>';
                            } ?>
                        </label>
                        <?php require 'Include/CountryDropDown.php'; ?>
                    </div>
                </div>
                <p />
                <?php
            } else { // put the current values in hidden controls so they are not lost if hiding the person-specific info?>
                <input type="hidden" name="Address1"
                    value="<?= htmlentities(stripslashes($sAddress1), ENT_NOQUOTES, 'UTF-8') ?>"></input>
                <input type="hidden" name="Address2"
                    value="<?= htmlentities(stripslashes($sAddress2), ENT_NOQUOTES, 'UTF-8') ?>"></input>
                <input type="hidden" name="City"
                    value="<?= htmlentities(stripslashes($sCity), ENT_NOQUOTES, 'UTF-8') ?>"></input>
                <input type="hidden" name="State"
                    value="<?= htmlentities(stripslashes($sState), ENT_NOQUOTES, 'UTF-8') ?>"></input>
                <input type="hidden" name="StateTextbox"
                    value="<?= htmlentities(stripslashes($sState), ENT_NOQUOTES, 'UTF-8') ?>"></input>
                <input type="hidden" name="Zip"
                    value="<?= htmlentities(stripslashes($sZip), ENT_NOQUOTES, 'UTF-8') ?>"></input>
                <input type="hidden" name="Country"
                    value="<?= htmlentities(stripslashes($sCountry), ENT_NOQUOTES, 'UTF-8') ?>"></input>
                <?php
            } ?>
            <div class="row">
                <div class="form-group col-md-3">
                    <label for="HomePhone">
                        <?php
                        if ($bFamilyHomePhone) {
                            echo '<span style="color: red;">' . gettext('Home Phone') . ':</span>';
                        } else {
                            echo gettext('Home Phone') . ':';
                        }
                        ?>
                    </label>
                    <div class="input-group">
                        <div class="input-group-addon">
                            <i class="fa fa-phone"></i>
                        </div>
                        <input type="text" name="HomePhone"
                            value="<?= htmlentities(stripslashes($sHomePhone), ENT_NOQUOTES, 'UTF-8') ?>" size="30"
                            maxlength="30" class="form-control"
                            data-inputmask='"mask": "<?= SystemConfig::getValue('sPhoneFormat') ?>"' data-mask>
                        <br><input type="checkbox" name="NoFormat_HomePhone" value="1" <?php if ($bNoFormat_HomePhone) {
                            echo ' checked';
                        } ?>><?= gettext('Do not auto-format') ?>
                    </div>
                </div>
                <div class="form-group col-md-3">
                    <label for="WorkPhone">
                        <?php
                        if ($bFamilyWorkPhone) {
                            echo '<span style="color: red;">' . gettext('Work Phone') . ':</span>';
                        } else {
                            echo gettext('Work Phone') . ':';
                        }
                        ?>
                    </label>
                    <div class="input-group">
                        <div class="input-group-addon">
                            <i class="fa fa-phone"></i>
                        </div>
                        <input type="text" name="WorkPhone"
                            value="<?= htmlentities(stripslashes($sWorkPhone), ENT_NOQUOTES, 'UTF-8') ?>" size="30"
                            maxlength="30" class="form-control"
                            data-inputmask='"mask": "<?= SystemConfig::getValue('sPhoneFormatWithExt') ?>"' data-mask />
                        <br><input type="checkbox" name="NoFormat_WorkPhone" value="1" <?php if ($bNoFormat_WorkPhone) {
                            echo ' checked';
                        } ?>><?= gettext('Do not auto-format') ?>
                    </div>
                </div>

                <div class="form-group col-md-3">
                    <label for="CellPhone">
                        <?php
                        if ($bFamilyCellPhone) {
                            echo '<span style="color: red;">' . gettext('Mobile Phone') . ':</span>';
                        } else {
                            echo gettext('Mobile Phone') . ':';
                        }
                        ?>
                    </label>
                    <div class="input-group">
                        <div class="input-group-addon">
                            <i class="fa fa-phone"></i>
                        </div>
                        <input type="text" name="CellPhone"
                            value="<?= htmlentities(stripslashes($sCellPhone), ENT_NOQUOTES, 'UTF-8') ?>" size="30"
                            maxlength="30" class="form-control"
                            data-inputmask='"mask": "<?= SystemConfig::getValue('sPhoneFormatCell') ?>"' data-mask>
                        <br><input type="checkbox" name="NoFormat_CellPhone" value="1" <?php if ($bNoFormat_CellPhone) {
                            echo ' checked';
                        } ?>><?= gettext('Do not auto-format') ?>
                    </div>
                </div>
            </div>
            <p />
            <div class="row">
                <div class="form-group col-md-4">
                    <label for="Email">
                        <?php
                        if ($bFamilyEmail) {
                            echo '<span style="color: red;">' . gettext('Email') . ':</span></td>';
                        } else {
                            echo gettext('Email') . ':</td>';
                        }
                        ?>
                    </label>
                    <div class="input-group">
                        <div class="input-group-addon">
                            <i class="fa fa-envelope"></i>
                        </div>
                        <input type="text" name="Email"
                            value="<?= htmlentities(stripslashes($sEmail), ENT_NOQUOTES, 'UTF-8') ?>" size="30"
                            maxlength="100" class="form-control">
                        <?php if ($sEmailError) {
                            ?><font color="red">
                                <?php echo $sEmailError ?>
                            </font>
                            <?php
                        } ?>
                    </div>
                </div>
                <div class="form-group col-md-4">
                    <label for="WorkEmail">
                        <?= gettext('Work / Other Email') ?>:
                    </label>
                    <div class="input-group">
                        <div class="input-group-addon">
                            <i class="fa fa-envelope"></i>
                        </div>
                        <input type="text" name="WorkEmail"
                            value="<?= htmlentities(stripslashes($sWorkEmail), ENT_NOQUOTES, 'UTF-8') ?>" size="30"
                            maxlength="100" class="form-control">
                        <?php if ($sWorkEmailError) {
                            ?><font color="red"><?php echo $sWorkEmailError ?></font>
                            </td>
                            <?php
                        } ?>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="form-group col-md-4">
                    <label for="FacebookID">
                        <?php
                        if ($bFacebookID) {
                            echo '<span style="color: red;">' . gettext('Facebook') . ':</span></td>';
                        } else {
                            echo gettext('Facebook') . ':</td>';
                        }
                        ?>
                    </label>
                    <div class="input-group">
                        <div class="input-group-addon">
                            <i class="fa fa-facebook"></i>
                        </div>
                        <input type="text" name="Facebook"
                            value="<?= htmlentities(stripslashes($iFacebookID), ENT_NOQUOTES, 'UTF-8') ?>" size="30"
                            maxlength="100" class="form-control">
                        <?php if ($sFacebookError) {
                            ?><font color="red">
                                <?php echo $sFacebookError ?>
                            </font>
                            <?php
                        } ?>
                    </div>
                </div>
                <div class="form-group col-md-4">
                    <label for="Twitter">
                        <?= gettext('Twitter') ?>:
                    </label>
                    <div class="input-group">
                        <div class="input-group-addon">
                            <i class="fa fa-twitter"></i>
                        </div>
                        <input type="text" name="Twitter"
                            value="<?= htmlentities(stripslashes($sTwitter), ENT_NOQUOTES, 'UTF-8') ?>" size="30"
                            maxlength="100" class="form-control">
                        <?php if ($sTwitterError) {
                            ?><font color="red"><?php echo $sTwitterError ?></font>
                            </td>
                            <?php
                        } ?>
                    </div>
                </div>
                <div class="form-group col-md-4">
                    <label for="LinkedIn">
                        <?= gettext('LinkedIn') ?>:
                    </label>
                    <div class="input-group">
                        <div class="input-group-addon">
                            <i class="fa fa-linkedin"></i>
                        </div>
                        <input type="text" name="LinkedIn"
                            value="<?= htmlentities(stripslashes($sLinkedIn), ENT_NOQUOTES, 'UTF-8') ?>" size="30"
                            maxlength="100" class="form-control">
                        <?php if ($sLinkedInError) {
                            ?><font color="red"><?php echo $sLinkedInError ?></font>
                            </td>
                            <?php
                        } ?>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="box box-info clearfix">
        <div class="box-header">
            <h3 class="box-title">
                <?= gettext('Membership Info') ?>
            </h3>
            <div class="pull-right"><br />
                <input type="submit" class="btn btn-primary" value="<?= gettext('Save') ?>" name="PersonSubmit">
            </div>
        </div><!-- /.box-header -->
        <div class="box-body">
            <div class="row">
                <div class="form-group col-md-3 col-lg-3">
                    <label>
                        <?= gettext('Classification') ?>:
                    </label>
                    <select name="Classification" class="form-control">
                        <option value="0">
                            <?= gettext('Unassigned') ?>
                        </option>
                        <option value="0" disabled>-----------------------</option>
                        <?php while ($aRow = mysqli_fetch_array($rsClassifications)) {
                            extract($aRow);
                            echo '<option value="' . $lst_OptionID . '"';
                            if ($iClassification == $lst_OptionID) {
                                echo ' selected';
                            }
                            echo '>' . $lst_OptionName . '&nbsp;';
                        } ?>
                    </select>
                </div>
                <div class="form-group col-md-3 col-lg-3">
                    <label>
                        <?= gettext('Membership Date') ?>:
                    </label>
                    <div class="input-group">
                        <div class="input-group-addon">
                            <i class="fa fa-calendar"></i>
                        </div>
                        <!-- Philippe Logel -->
                        <input type="text" name="MembershipDate" class="form-control date-picker"
                            value="<?= change_date_for_place_holder($dMembershipDate) ?>" maxlength="10" id="sel1"
                            size="11" placeholder="<?= SystemConfig::getValue("sDatePickerPlaceHolder") ?>">
                        <?php if ($sMembershipDateError) {
                            ?><font color="red"><?= $sMembershipDateError ?></font>
                            <?php
                        } ?>
                    </div>
                </div>
                <?php if (!SystemConfig::getBooleanValue('bHideFriendDate')) { /* Friend Date can be hidden - General Settings */?>
                    <div class="form-group col-md-3 col-lg-3">
                        <label>
                            <?= gettext('Friend Date') ?>:
                        </label>
                        <div class="input-group">
                            <div class="input-group-addon">
                                <i class="fa fa-calendar"></i>
                            </div>
                            <input type="text" name="FriendDate" class="form-control date-picker"
                                value="<?= change_date_for_place_holder($dFriendDate) ?>" maxlength="10" id="sel2" size="10"
                                placeholder="<?= SystemConfig::getValue("sDatePickerPlaceHolder") ?>">
                            <?php if ($sFriendDateError) {
                                ?><font color="red"><?php echo $sFriendDateError ?></font>
                                <?php
                            } ?>
                        </div>
                    </div>
                    <?php
                } ?>
            </div>
        </div>
    </div>
    <?php if ($numCustomFields > 0) {
        ?>
        <div class="box box-info clearfix">
            <div class="box-header">
                <h3 class="box-title">
                    <?= gettext('Other Info') ?>
                </h3>
                <div class="pull-right"><br />
                    <input type="submit" class="btn btn-primary" value="<?= gettext('Save') ?>" name="PersonSubmit">
                </div>
            </div><!-- /.box-header -->
            <div class="box-body">
                <?php if ($numCustomFields > 0) {
                    mysqli_data_seek($rsCustomFields, 0);

                    while ($rowCustomField = mysqli_fetch_array($rsCustomFields, MYSQLI_BOTH)) {
                        extract($rowCustomField);

                        if (AuthenticationManager::GetCurrentUser()->isEnabledSecurity($aSecurityType[$custom_FieldSec])) {
                            echo "<div class='row'><div class=\"form-group col-md-3\"><label>" . $custom_Name . '</label>';

                            if (array_key_exists($custom_Field, $aCustomData)) {
                                $currentFieldData = trim($aCustomData[$custom_Field]);
                            } else {
                                $currentFieldData = '';
                            }

                            if ($type_ID == 11) {
                                $custom_Special = $sPhoneCountry;
                            }

                            formCustomField($type_ID, $custom_Field, $currentFieldData, $custom_Special, !isset($_POST['PersonSubmit']));
                            if (isset($aCustomErrors[$custom_Field])) {
                                echo '<span style="color: red; ">' . $aCustomErrors[$custom_Field] . '</span>';
                            }
                            echo '</div></div>';
                        }
                    }
                } ?>
            </div>

        </div>

        <?php
    } ?>
    <input type="submit" class="btn btn-primary" id="PersonSaveButton" value="<?= gettext('Save') ?>"
        name="PersonSubmit">
    <?php if (AuthenticationManager::GetCurrentUser()->isAddRecordsEnabled()) {
        echo '<input type="submit" class="btn btn-primary" value="' . gettext('Save and Add') . '" name="PersonSubmitAndAdd">';
    } ?>
    <input type="button" class="btn btn-primary" value="<?= gettext('Cancel') ?>" name="PersonCancel">
</form>

<script nonce="<?= SystemURLs::getCSPNonce() ?>">
    $(function () {
        $("[data-mask]").inputmask();
        $("#famailyId").select2();;
    });

    $(document).ready(function() {
    // Get a reference to the "HasFamily" dropdown
    var hasFamilyDropdown = $('select[name="HasFamily"]');
    
    // Get a reference to the "Family Members" section
    var familyMembersSection = $('.family-members-section');
    
    // Listen for changes in the dropdown selection
    hasFamilyDropdown.on('change', function() {
        // Check if the selected value is "1" (Yes)
        if (hasFamilyDropdown.val() === '1') {
            // Show the "Family Members" section
            familyMembersSection.show();
        } else {
            // Hide the "Family Members" section
            familyMembersSection.hide();
        }
    });
    
    // Trigger the change event to initially set the section's visibility
    hasFamilyDropdown.trigger('change');
    });

    $(document).ready(function() {
        $("#addRowButton").on("click", function() {
            // Clone the last row
            var lastRow = $(".table-responsive table tbody tr:last");
            var newRow = lastRow.clone();
            
            // Clear input values in the cloned row
            newRow.find("input[type=text], select").val("");
            
            // Append the cloned row to the table
            $(".table-responsive table tbody").append(newRow);
        });
    });
</script>

<?php require 'Include/Footer.php' ?>