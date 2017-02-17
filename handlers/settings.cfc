/**
********************************************************************************
Copyright 2017 Full Calendar by Mark Skelton and Computer Know How, LLC
www.compknowhow.com
********************************************************************************

Author:  Mark Skelton
Description:  I handle the setting events
*/
component extends="base" {

	property name="settingService" 	inject="settingService@cb";
	property name="cb" 				inject="cbHelper@cb";

	function index(event,rc,prc){
		prc.settings = deserializeJSON(settingService.getSetting("fullcalendar"));

		event.setView("settings/index");
	}

	function saveSettings(event,rc,prc){
		var incomingSettings = "";
		var newSettings = {};

		var oSetting = settingService.findWhere({name="fullcalendar"});

		if(structKeyExists(rc,"googleCalendarApiKey")) {
			var incomingSettings = serializeJSON(
				{
					"googleCalendarApiKey" = rc.googleCalendarApiKey,
					"newTab" = structKeyExists(rc, "newTab") ? true : false
				}
			);
		}

		if(structKeyExists(rc,"nextPrevButtons")) {
			var incomingSettings = serializeJSON(
				{
					"nextPrevButtons" = structKeyExists(rc, "nextPrevButtons") ? true : false,
					"todayButton" = structKeyExists(rc, "todayButton") ? true : false,
					"dateButton" = structKeyExists(rc, "dateButton") ? true : false,
					"monthButton" = structKeyExists(rc, "monthButton") ? true : false,
					"weekButton" = structKeyExists(rc, "weekButton") ? true : false,
					"dayButton" = structKeyExists(rc, "dayButton") ? true : false,
					"agendaButton" = structKeyExists(rc, "agendaButton") ? true : false,
					"refreshButton" = structKeyExists(rc, "refreshButton") ? true : false,

					"defaultView" = rc.defaultView,

					"navLinks" = structKeyExists(rc, "navLinks") ? true : false,
					"includeJquery" = structKeyExists(rc, "includeJquery") ? true : false,
					"hideJqueryAlert" = structKeyExists(rc, "hideJqueryAlert") ? true : false
				}
			);
		}

		if(structKeyExists(rc,"eventColor")) {
			var incomingSettings = serializeJSON(
				{
					"eventColor" = rc.eventColor,
					"eventTextColor" = rc.eventTextColor
				}
			);
		}

		var newSettings = deserializeJSON(incomingSettings);

		var existingSettings = deserializeJSON(oSetting.getValue());

		// Append the new settings sent in to the existing settings (overwrite)
		structAppend(existingSettings, newSettings);

		oSetting.setValue(serializeJSON(existingSettings));
		settingService.save(oSetting);

		// Flush the settings cache so our new settings are reflected
		settingService.flushSettingsCache();

		getPlugin("MessageBox").info("Settings Saved & Updated!");
		cb.setNextModuleEvent("fullcalendar","settings");
	}

}