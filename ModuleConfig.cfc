/**
********************************************************************************
Copyright 2017 Full Calendar by Mark Skelton and Computer Know How, LLC
www.compknowhow.com
********************************************************************************

Author:  Mark Skelton
Description:  Creates Full Calendar calendars
*/
component {

	// Module Properties
	this.title 				= "Full Calendar";
	this.author 			= "Computer Know How, LLC";
	this.webURL 			= "http://www.compknowhow.com";
	this.description 		= "Creates Full Calendar calendars";
	this.version			= "1.1";
	// If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
	this.viewParentLookup 	= true;
	// If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
	this.layoutParentLookup = true;
	// Module Entry Point
	this.entryPoint			= "fullCalendar";

	function configure(){
		// full calendar global settings
		settings = {
			googleCalendarApiKey = "",
			nextPrevButtons = true,
			todayButton = true,
			dateButton = true,
			monthButton = true,
			weekButton = true,
			dayButton = true,
			agendaButton = true,
			defaultView = "month",
			showLegend = false,

			nowIndicator = false,
			navLinks = false,
			openGCalEvents = false,
			newTab = true,

			includeJquery = false,
			useTooltips = true,
			hideJqueryAlert = false,

			eventColor = "",
			eventTextColor = "",
			refreshButton = false
		};

		// SES Routes
		routes = [
			{pattern="/", handler="form",action="index"},
			// Convention Route
			{pattern="/:handler/:action?"}
		];

		// Interceptors
		interceptors = [
			{ class="#moduleMapping#.interceptors.includes", name="includes@FullCalendar" },
			{ class="#moduleMapping#.interceptors.request", properties={ entryPoint="cbadmin" }, name="request@fullCalendar" }
		];
	}

	/**
	* Fired when the module is registered and activated.
	*/
	function onLoad(){
		var menuService = controller.getWireBox().getInstance("AdminMenuService@cb");
		var settingService = controller.getWireBox().getInstance("SettingService@cb");

		// Add menu contribution
		menuService.addSubMenu(topMenu=menuService.MODULES,
								name="fullCalendar",
								label="Full Calendar",
								href="#menuService.buildModuleLink('fullCalendar','calendar')#");

		// Flush the settings cache so our new settings are reflected
		settingService.flushSettingsCache();
	}

	/**
	* Fired when the module is activated by ContentBox
	*/
	function onActivate(){
		var settingService = controller.getWireBox().getInstance("SettingService@cb");

		// Store default settings
		var findArgs = {name="fullcalendar"};
		var setting = settingService.findWhere(criteria=findArgs);
		if(isNull(setting)){
			var args = {name="fullcalendar", value=serializeJSON(settings)};
			var fullCalendarSettings = settingService.new(properties=args);
			settingService.save(fullCalendarSettings);
		}

		// Flush the settings cache so our new settings are reflected
		settingService.flushSettingsCache();
	}

	/**
	* Fired when the module is unregistered and unloaded
	*/
	function onUnload(){
		var settingService = controller.getWireBox().getInstance("SettingService@cb");
		var menuService = controller.getWireBox().getInstance("AdminMenuService@cb");

		// Remove menu contribution
		menuService.removeSubMenu(topMenu=menuService.MODULES, name="FullCalendar");
	}

	/**
	* Fired when the module is deactivated by ContentBox
	*/
	function onDeactivate(){
		var settingService = controller.getWireBox().getInstance("SettingService@cb");

		var args = {name="fullcalendar"};
		var setting = settingService.findWhere(criteria=args);
		if(!isNull(setting)){
			settingService.delete(setting);
		}

		// Flush the settings cache so our new settings are reflected
		settingService.flushSettingsCache();
	}

}