/**
********************************************************************************
Copyright 2017 Full Calendar by Mark Skelton and Computer Know How, LLC
www.compknowhow.com
********************************************************************************

Author:  Mark Skelton
Description:  Base handler for the Full Calendar module
*/
component{

	// dependencies
	property name="CalendarService" inject="entityService:Calendar";
	property name="EventService" inject="entityService:Event";
	property name="VirtualCalendarService" inject="id:CalendarService@fullCalendar";
	property name="settingService" inject="id:settingService@cb";

	// pre handler
	function preHandler(event,action,eventArguments){
		var rc 	= event.getCollection();
		var prc = event.getCollection(private=true);

		// get module root
		prc.moduleRoot = getModuleSettings("fullCalendar").mapping;

		// if data isn't setup, redirect user
		if(!VirtualCalendarService.isDataSetup() && event.getCurrentEvent() NEQ "fullCalendar:calendar.noDataSetup") {
			setNextEvent("fullCalendar.calendar.noDataSetup");
		}

		// exit points
		prc.xehCalendars = "fullCalendar.calendar.index";
		prc.xehCalendarEditor = "fullCalendar.calendar.editor";
		prc.xehCalendarSettings = "fullCalendar.settings.index";

		prc.xehEventEditor = "fullCalendar.event.editor";
		prc.xehEvents = "fullCalendar.event.index";

		//check login and redirect is needed.
		if(!prc.oAuthor.isLoaded()){
			getPlugin("MessageBox").setMessage("warning","Please login!");
			setNextEvent(prc.xehLogin);
		}

		// use the CB admin layout
		event.setLayout(name="admin",module="contentbox-admin");

		// tab control
		prc.tabModules = true;
		prc.tabModules_fullCalendar = true;
	}

	private struct function getFullCalendarSettings() {
		return deserializeJSON(settingService.getSetting("fullcalendar"));
	}
}
