/**
********************************************************************************
Copyright 2017 Full Calendar by Mark Skelton and Computer Know How, LLC
www.compknowhow.com
********************************************************************************

Author:  Mark Skelton
Description:  I handle the calendar events
*/
component extends="base" {

	function index(event,rc,prc){
		//exit points
		prc.xehCalendarRemove = "fullCalendar.calendar.remove";

		//current calendars
		prc.calendars = calendarService.list(sortOrder="createdDate DESC",asQuery=false);

		event.setView(view="calendar/index",module="cbmodule-fullcalendar");
	}

	// calendar editor
	function editor(event,rc,prc){
		// exit handlers
		prc.xehCalendarSave = "fullCalendar.calendar.save";
		prc.xehEventsEditor = "fullCalendar.calendar.editor";
		prc.xehEventsSave = "fullCalendar.calendar.saveEvent";

		// get new or persisted calendar
		prc.calendar  = calendarService.get(event.getValue("calendarID",0));
		prc.settings  = getFullCalendarSettings();

		//repopulate calendar
		calendarService.populate(prc.calendar,rc);

		// viewlets
		prc.eventsViewlet = "";
		if( prc.calendar.isLoaded() ){
			var args = {calendarID=rc.calendarID};
			prc.eventsViewlet = runEvent(event="cbmodule-fullcalendar:calendar.events",eventArguments=args);
		}

		// Editor
		prc.tabForms_editor = true;

		// view
		event.setView("calendar/editor");
	}


	// save calendar
	function save(event,rc,prc){

		// get it and populate it
		var oCalendar = populateModel( calendarService.get(id=rc.calendarID) );

		if (!len(oCalendar.getCreatedDate())) {
			oCalendar.setCreatedDate(now());
		}

		// validate it
		var errors = oCalendar.validate();
		if( !arrayLen(errors) ){
			// save content
			calendarService.save( oCalendar );
			// Message
			getInstance("MessageBox@cbmessagebox").info("Calendar saved!");
			setNextEvent(event=prc.xehCalendarEditor,queryString="calendarID=#oCalendar.getCalendarID()#");
		}
		else{
			flash.persistRC(exclude="event");
			getInstance("MessageBox@cbmessagebox").warn(messageArray=errors);
			setNextEvent(event=prc.xehCalendarEditor,queryString="calendarID=#oCalendar.getCalendarID()#");
		}

	}

	function remove(event,rc,prc){
		var oCalendar	= calendarService.get( rc.calendarID );

		if( isNull(oCalendar) ){
			getInstance("MessageBox@cbmessagebox").setMessage("warning","Invalid Calendar detected!");
			setNextEvent( prc.xehCalendars );
		}
		// remove
		calendarService.delete( oCalendar );
		// message
		getInstance("MessageBox@cbmessagebox").setMessage("info","Calendar Removed!");
		// redirect
		setNextEvent(prc.xehCalendars);
	}


	function events(event,rc,prc,calendarID){
		//exit points
		prc.xehEventsRemove = "fullCalendar.event.remove";
		prc.xehEventsOrder = "fullCalendar.event.changeOrder";

		//current event
		var oCalendar = calendarService.get(arguments.calendarID);
		prc.events = oCalendar.getEvents();

		if (isNull(prc.events)) {
			prc.events = [];
		}

		return renderview(view="viewlets/events",module="cbmodule-fullcalendar");
	}

	function saveEvent(event,rc,prc){
		param name="rc.calendarID" default="";
		param name="rc.eventID" default="";

		param name="rc.title" default="";
		param name="rc.description" default="";
		param name="rc.startTime" default="";
		param name="rc.endTime" default="";
		param name="rc.allDay" default="false";
		param name="rc.action" default="";

		if (rc.startTime neq "") {
			rc.startTime = parseIsoDateTime(rc.startTime);
			rc.startTime =  createODBCDateTime(rc.startTime);
		}

		if (rc.endTime neq "") {
			rc.endTime = parseIsoDateTime(rc.endTime);
			rc.endTime =  createODBCDateTime(rc.endTime);
		}

		if (rc.allDay) {
			rc.allDay = 1;
		} else {
			rc.allDay = 0;
		}

		var outputData = "true";

		var oCalendar = calendarService.get(event.getValue("calendarID", 0));

		if (!isNull(oCalendar) and !isNull(oCalendar.getCalendarID())) {
			rc.calendar = oCalendar;

			if (rc.action eq "add") {
				oEvent = populateModel(eventService.new());

				var errors = oEvent.validate();

				if (!arrayLen(errors)){
					// save event
					var final = eventService.save(oEvent);
					var events = eventService.getAll();
					outputData = events[arrayLen(events)].getEventID();
				} else {
					outputData = serializeJSON(errors);
				}
			} else if (rc.action eq "edit") {
				var oEvent = eventService.get(event.getValue("eventID", 0));

				if (!isNull(oEvent) and !isNull(oEvent.getEventID())) {
					oEvent = populateModel(oEvent);

					var errors = oEvent.validate();

					if (!arrayLen(errors)){
						// save event
						eventService.save(oEvent);
					} else {
						outputData = serializeJSON(errors);
					}
				} else {
					outputData = serializeJSON(["Event not found!"]);
				}
			} else {
				var oEvent = eventService.get(event.getValue("eventID", 0));

				if (!isNull(oEvent) and !isNull(oEvent.getEventID())) {
					eventService.deleteById(oEvent.getEventID());
				} else {
					outputData = serializeJSON(["Event not found!"]);
				}
			}

		} else {
			outputData = serializeJSON(["Calendar not found!"]);
		}

		event.renderData(type="json",data=outputData);
	}

	function updateEvent(event,rc,prc){
		param name="rc.calendarID" default="";
		param name="rc.eventID" default="";
		param name="rc.allDay" default="false";
		param name="rc.deltaMinutes" default=0;
		param name="rc.action" default="";

		var outputData = "true";
		var oCalendar = calendarService.get(event.getValue("calendarID", 0));

		if (!isNull(oCalendar) and !isNull(oCalendar.getCalendarID())) {
			rc.calendar = populateModel(oCalendar);

			var oEvent = eventService.get(event.getValue("eventID", 0));

			if (!isNull(oEvent) and !isNull(oEvent.getEventID())) {
				// declare local variables
				var startTime = "";
				var endTime = "";

				// if event was all day set the start time to the day it was at with hour, minutes, and seconds at 0
				// then use the delta to calculate the new time
				// end time is always 2 hours later when this occurs
				if (oEvent.getAllDay() and !rc.allDay) {
					startTime = oEvent.getStartTime();

					var year = datePart('yyyy', startTime);
					var month = datePart('m', startTime);
					var day = datePart('d', startTime);

					startTime = createDateTime(year, month, day, 0, 0, 0);
					oEvent.setStartTime(createODBCDateTime(startTime));

					endTime = dateAdd("h", 2, startTime);
				} else {
					// get the current end time of the event
					endTime = oEvent.getEndTime();
					// add the number of minutes provided
					endTime = dateAdd("n", rc.deltaMinutes, endTime);
				}

				if (action == 'move') {
					// get the current start time of the event
					startTime = oEvent.getStartTime();
					// add the number of minutes provided
					startTime = dateAdd("n", rc.deltaMinutes, startTime);
					// set the start time and save the event
					oEvent.setStartTime(createODBCDateTime(startTime));
					if (oEvent.getAllDay() and !rc.allDay) {
						endTime = dateAdd("n", 120, startTime);
					}
				}

				if (rc.allDay) {
					oEvent.setAllDay(1);
				} else {
					oEvent.setAllDay(0);
				}

				// convert the time to a ODBC date time 
				endTime = createODBCDateTime(endTime);
				// set the end time and save the event
				oEvent.setEndTime(endTime);

				// save the event
				eventService.save(oEvent);
			} else {
				outputData = serializeJSON(["Event not found!"]);
			}
		} else {
			outputData = serializeJSON(["Calendar not found!"]);
		}

		event.renderData(type="json",data=outputData);
	}

	/**
	* noDataSetup
	*/
	any function noDataSetup(event,rc,prc){
		event.setView("calendar/noDataSetup");
	}

	private function parseIsoDateTime(string dateTime) {
		var date = dateTime.split("T")[1];
		var time = dateTime.split("T")[2];

		var year = date.split("-")[1];
		var month = date.split("-")[2];
		var day = date.split("-")[3];

		var hour = time.split(":")[1];
		var minute = time.split(":")[2];
		var second = time.split(":")[3];

		return createDateTime(year, month, day, hour, minute, second);
	}
}