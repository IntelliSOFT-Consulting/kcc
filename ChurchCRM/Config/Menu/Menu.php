<?php

namespace ChurchCRM\Config\Menu;

use ChurchCRM\Config;
use ChurchCRM\dto\SystemConfig;
use ChurchCRM\GroupQuery;
use ChurchCRM\ListOptionQuery;
use ChurchCRM\Authentication\AuthenticationManager;
use ChurchCRM\MenuLinkQuery;

class Menu
{
    /**
     * @var Config[]
     */
    private static $menuItems;

    public static function init()
    {
        self::$menuItems = self::buildMenuItems();
        /*if (!empty($menuItems)) {
            self::scrapeDBMenuItems($menuItems);
        }*/
    }

    public static function getMenu()
    {
        return self::$menuItems;
    }

    private static function buildMenuItems()
    {
        return array(
            "Dashboard" => new MenuItem(gettext("Dashboard"), "Menu.php", true, 'fa-dashboard'),
            "Calendar" => self::getCalendarMenu(),
            "People" => self::getPeopleMenu(),
            // "Groups" => self::getGroupMenu(),
            "SundaySchool" => self::getSundaySchoolMenu(),
            "Email" => new MenuItem(gettext("Email"), "v2/email/dashboard", SystemConfig::getBooleanValue("bEnabledEmail"), 'fa-envelope'),
            "Events" => self::getEventsMenu(),
            "Deposits" => self::getDepositsMenu(),
            "Fundraiser" => self::getFundraisersMenu(),
            "AssetsManagement" => self::getAssetsManagamentMenu(),
            // "Reports" => self::getReportsMenu(),
            "Admin" => self::getAdminMenu(),
            "Custom" => self::getCustomMenu(),
        );
    }

    private static function getAssetsManagamentMenu(){

        $assetsManagementMenu = new MenuItem(gettext("Assets Management"), "", true, "fa-bank");
        $assetsManagementMenu->addSubMenu(new MenuItem(gettext("Asset Category"), "asset_category.php", AuthenticationManager::GetCurrentUser()->isAddRecordsEnabled()));
        $assetsManagementMenu->addSubMenu(new MenuItem(gettext("Asset Location"), "AssetLocation.php", AuthenticationManager::GetCurrentUser()->isAddRecordsEnabled()));
        $assetsManagementMenu->addSubMenu(new MenuItem(gettext("Add new assets"), "AssetsEditor.php", AuthenticationManager::GetCurrentUser()->isAddRecordsEnabled()));
        $assetsManagementMenu->addSubMenu(new MenuItem(gettext("Asset Inventory"), "AssetInventoryEditor.php", AuthenticationManager::GetCurrentUser()->isAddRecordsEnabled()));
        $assetsManagementMenu->addSubMenu(new MenuItem(gettext("Asset List"), "AssetList.php"));
        $assetsManagementMenu->addSubMenu(new MenuItem(gettext("Issuance List"), "AssetsAssignList.php"));


        return $assetsManagementMenu;

    }

    private static function getCalendarMenu()
    {
        $calendarMenu = new MenuItem(gettext("Calendar"), "v2/calendar", SystemConfig::getBooleanValue("bEnabledCalendar"), 'fa-calendar');
        $calendarMenu->addCounter(new MenuCounter("AnniversaryNumber", "bg-blue"));
        $calendarMenu->addCounter(new MenuCounter("BirthdateNumber", "bg-red"));
        $calendarMenu->addCounter(new MenuCounter("EventsNumber", "bg-yellow"));
        return $calendarMenu;
    }

    private static function getPeopleMenu()
    {
        $peopleMenu = new MenuItem(gettext("People"), "", true, 'fa-users');
        $peopleMenu->addSubMenu(new MenuItem(gettext("Dashboard"), "PeopleDashboard.php"));
        $peopleMenu->addSubMenu(new MenuItem(gettext("Add New Person"), "PersonEditor.php", AuthenticationManager::GetCurrentUser()->isAddRecordsEnabled()));
        $peopleMenu->addSubMenu(new MenuItem(gettext("View All Persons"), "v2/people"));
        $peopleMenu->addSubMenu(new MenuItem(gettext("Add New Family"), "FamilyEditor.php", AuthenticationManager::GetCurrentUser()->isAddRecordsEnabled()));
        $peopleMenu->addSubMenu(new MenuItem(gettext("View Active Families"), "v2/family"));
        $peopleMenu->addSubMenu(new MenuItem(gettext("View Inactive Families"), "v2/family?mode=inactive"));
        $adminMenu = new MenuItem(gettext("Admin"), "", AuthenticationManager::GetCurrentUser()->isAdmin());
        $adminMenu->addSubMenu(new MenuItem(gettext("Classifications Manager"), "OptionManager.php?mode=classes", AuthenticationManager::GetCurrentUser()->isAdmin()));
        $adminMenu->addSubMenu(new MenuItem(gettext("Family Roles"), "OptionManager.php?mode=famroles", AuthenticationManager::GetCurrentUser()->isAdmin()));
        $adminMenu->addSubMenu(new MenuItem(gettext("Family Properties"), "PropertyList.php?Type=f", AuthenticationManager::GetCurrentUser()->isAdmin()));
        $adminMenu->addSubMenu(new MenuItem(gettext("Family Custom Fields"), "FamilyCustomFieldsEditor.php", AuthenticationManager::GetCurrentUser()->isAdmin()));
        $adminMenu->addSubMenu(new MenuItem(gettext("People Properties"), "PropertyList.php?Type=p", AuthenticationManager::GetCurrentUser()->isAdmin()));
        $adminMenu->addSubMenu(new MenuItem(gettext("Person Custom Fields"), "PersonCustomFieldsEditor.php", AuthenticationManager::GetCurrentUser()->isAdmin()));
        $adminMenu->addSubMenu(new MenuItem(gettext("Volunteer Opportunities"), "VolunteerOpportunityEditor.php", AuthenticationManager::GetCurrentUser()->isAdmin()));

        $peopleMenu->addSubMenu($adminMenu);

        return $peopleMenu;
    }

    private static function getGroupMenu()
    {
        $groupMenu = new MenuItem(gettext("Groups"), "", true, 'fa-tag');
        $groupMenu->addSubMenu(new MenuItem(gettext("List Groups"), "GroupList.php"));

        $listOptions = ListOptionQuery::Create()->filterById(3)->orderByOptionSequence()->find();

        foreach ($listOptions as $listOption) {
            if ($listOption->getOptionId() != 4) {// we avoid the sundaySchool, it's done under
                $tmpMenu = self::addGroupSubMenus($listOption->getOptionName(), $listOption->getOptionId(), "GroupView.php?GroupID=");
                if (!empty($tmpMenu)) {
                    $groupMenu->addSubMenu($tmpMenu);
                }
            }
        }

        // now we're searching the unclassified groups
        $tmpMenu = self::addGroupSubMenus(gettext("Unassigned"), 0, "GroupView.php?GroupID=");
        if (!empty($tmpMenu)) {
            $groupMenu->addSubMenu($tmpMenu);
        }

        $adminMenu = new MenuItem(gettext("Admin"), "", AuthenticationManager::GetCurrentUser()->isAdmin());
        $adminMenu->addSubMenu(new MenuItem(gettext("Group Properties"), "PropertyList.php?Type=g", AuthenticationManager::GetCurrentUser()->isAdmin()));
        $adminMenu->addSubMenu(new MenuItem(gettext("Group Types"), "OptionManager.php?mode=grptypes", AuthenticationManager::GetCurrentUser()->isAdmin()));

        $groupMenu->addSubMenu($adminMenu);

        return $groupMenu;
    }

    private static function getSundaySchoolMenu()
    {
        $sundaySchoolMenu = new MenuItem(gettext("Sunday School"), "", SystemConfig::getBooleanValue("bEnabledSundaySchool"), 'fa-child');
        $sundaySchoolMenu->addSubMenu(new MenuItem(gettext("Dashboard"), "sundayschool/SundaySchoolDashboard.php"));
        // now we're searching the unclassified groups
        $tmpMenu = self::addGroupSubMenus(gettext("Classes"), 4, "sundayschool/SundaySchoolClassView.php?groupId=");
        if (!empty($tmpMenu)) {
            $sundaySchoolMenu->addSubMenu($tmpMenu);
        }

        return $sundaySchoolMenu;
    }

    private static function getEventsMenu()
    {
        $eventsMenu = new MenuItem(gettext("Events"), "", SystemConfig::getBooleanValue("bEnabledEvents"), 'fa-ticket');
        $eventsMenu->addSubMenu(new MenuItem(gettext("Add Church Event"), "EventEditor.php", AuthenticationManager::GetCurrentUser()->isAddEventEnabled()));
        $eventsMenu->addSubMenu(new MenuItem(gettext("List Church Events"), "ListEvents.php"));
        $eventsMenu->addSubMenu(new MenuItem(gettext("List Event Types"), "EventNames.php"));
        $eventsMenu->addSubMenu(new MenuItem(gettext("Check-in and Check-out"), "Checkin.php"));
        $eventsMenu->addSubMenu(new MenuItem(gettext('Event Attendance Reports'), "EventAttendance.php"));
        return $eventsMenu;
    }

    private static function getDepositsMenu()
    {
        $depositsMenu = new MenuItem(gettext("Deposit"), "", SystemConfig::getBooleanValue("bEnabledFinance") && AuthenticationManager::GetCurrentUser()->isFinanceEnabled(), 'fa-bank');
        $depositsMenu->addSubMenu(new MenuItem(gettext("View All Deposits"), "FindDepositSlip.php", AuthenticationManager::GetCurrentUser()->isFinanceEnabled()));
        $depositsMenu->addSubMenu(new MenuItem(gettext("Deposit Reports"), "FinancialReports.php", AuthenticationManager::GetCurrentUser()->isFinanceEnabled()));
        $depositsMenu->addSubMenu(new MenuItem(gettext("Edit Deposit Slip"), "DepositSlipEditor.php?DepositSlipID=".$_SESSION['iCurrentDeposit'], AuthenticationManager::GetCurrentUser()->isFinanceEnabled()));
        $depositsMenu->addCounter(new MenuCounter("iCurrentDeposit", "bg-green", $_SESSION['iCurrentDeposit']));

        $adminMenu = new MenuItem(gettext("Admin"), "", AuthenticationManager::GetCurrentUser()->isAdmin());
        $adminMenu->addSubMenu(new MenuItem(gettext("Envelope Manager"), "ManageEnvelopes.php", AuthenticationManager::GetCurrentUser()->isAdmin()));
        $adminMenu->addSubMenu(new MenuItem(gettext("Donation Funds"), "DonationFundEditor.php", AuthenticationManager::GetCurrentUser()->isAdmin()));

        $depositsMenu->addSubMenu($adminMenu);
        return $depositsMenu;
    }


    private static function getFundraisersMenu()
    {
        $fundraiserMenu = new MenuItem(gettext("Fundraiser"), "", SystemConfig::getBooleanValue("bEnabledFundraiser"), 'fa-money');
        $fundraiserMenu->addSubMenu(new MenuItem(gettext("Create New Fundraiser"), "FundRaiserEditor.php?FundRaiserID=-1"));
        $fundraiserMenu->addSubMenu(new MenuItem(gettext("View All Fundraisers"), "FindFundRaiser.php"));
        $fundraiserMenu->addSubMenu(new MenuItem(gettext("Edit Fundraiser"), "FundRaiserEditor.php"));
        $fundraiserMenu->addSubMenu(new MenuItem(gettext("Add Donors to Buyer List"), "AddDonors.php"));
        $fundraiserMenu->addSubMenu(new MenuItem(gettext("View Buyers"), "PaddleNumList.php"));
        $iCurrentFundraiser = 0;
        if (array_key_exists('iCurrentFundraiser', $_SESSION))
        {
            $iCurrentFundraiser = $_SESSION['iCurrentFundraiser'];
        }
        $fundraiserMenu->addCounter(new MenuCounter("iCurrentFundraiser", "bg-blue", $iCurrentFundraiser));

        return $fundraiserMenu;
    }

    private static function getReportsMenu()
    {
        $reportsMenu = new MenuItem(gettext("Data/Reports"), "", true, 'fa-file-pdf-o');
        $reportsMenu->addSubMenu(new MenuItem(gettext('Canvass Automation'), "CanvassAutomation.php"));
        $reportsMenu->addSubMenu(new MenuItem(gettext("Query Menu"), "QueryList.php"));
        return $reportsMenu;
    }


    private static function addGroupSubMenus($menuName, $groupId, $viewURl)
    {
        $groups = GroupQuery::Create()->filterByType($groupId)->orderByName()->find();
        if (!$groups->isEmpty()) {
            $unassignedGroups = new MenuItem($menuName, "", true, "fa-tag");
            foreach ($groups as $group) {
                $unassignedGroups->addSubMenu(new MenuItem($group->getName(), $viewURl . $group->getID(), true, "fa-user-o"));
            }
            return $unassignedGroups;
        }
        return null;
    }

    private static function getAdminMenu()
    {
        $menu = new MenuItem(gettext("Admin"), "", true, 'fa-gears');
        $menu->addSubMenu(new MenuItem(gettext("Edit General Settings"), "SystemSettings.php",AuthenticationManager::GetCurrentUser()->isAdmin()));
        $menu->addSubMenu(new MenuItem(gettext("System Users"), "UserList.php",AuthenticationManager::GetCurrentUser()->isAdmin()));
        $menu->addSubMenu(new MenuItem(gettext("Property Types"), "PropertyTypeList.php",AuthenticationManager::GetCurrentUser()->isAdmin()));
        $menu->addSubMenu(new MenuItem(gettext("Restore Database"), "RestoreDatabase.php",AuthenticationManager::GetCurrentUser()->isAdmin()));
        $menu->addSubMenu(new MenuItem(gettext("Backup Database"), "BackupDatabase.php",AuthenticationManager::GetCurrentUser()->isAdmin()));
        $menu->addSubMenu(new MenuItem(gettext("CSV Import"), "CSVImport.php",AuthenticationManager::GetCurrentUser()->isAdmin()));
        $menu->addSubMenu(new MenuItem(gettext("CSV Export Records"), "CSVExport.php",AuthenticationManager::GetCurrentUser()->isCSVExport()));
        $menu->addSubMenu(new MenuItem(gettext("Kiosk Manager"), "KioskManager.php",AuthenticationManager::GetCurrentUser()->isAdmin()));
        $menu->addSubMenu(new MenuItem(gettext("Debug"), "v2/admin/debug",AuthenticationManager::GetCurrentUser()->isAdmin()));
        $menu->addSubMenu(new MenuItem(gettext("Custom Menus"), "v2/admin/menus",AuthenticationManager::GetCurrentUser()->isAdmin()));
        $menu->addSubMenu(new MenuItem(gettext("Reset System"), "v2/admin/database/reset",AuthenticationManager::GetCurrentUser()->isAdmin()));
        return $menu;
    }


    private static function getCustomMenu() {
        $menu = new MenuItem(gettext("Links"), "", SystemConfig::getBooleanValue("bEnabledMenuLinks"), 'fa-link');
        $menuLinks = MenuLinkQuery::create()->orderByOrder()->find();
        foreach ($menuLinks as $link) {
            $menu->addSubMenu(new MenuItem($link->getName(), $link->getUri()));
        }
        return $menu;
    }

}