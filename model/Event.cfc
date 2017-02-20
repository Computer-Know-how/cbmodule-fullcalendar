/**
********************************************************************************
Copyright 2017 Full Calendar by Mark Skelton and Computer Know How, LLC
www.compknowhow.com
********************************************************************************

Author:  Mark Skelton
Description:  Event ORM object
*/
component persistent="true" table="cb_calendarEvent" {

	// Primary Key
	property name="eventID" fieldtype="id" column="eventID" generator="identity" setter="false";

	// Properties
	property name="name" notnull="true" length="200" default="" index="idx_name";
	property name="description" notnull="false" length="500" default="";
	property name="startTime" notnull="false" ormType="timestamp" default="";
	property name="endTime" notnull="false" ormType="timestamp" default="";
	property name="allDay" notnull="false" length="10" default="";

	// M2O -> Calendar
	property name="calendar" notnull="true" cfc="contentbox.modules.fullCalendar.model.Calendar" fieldtype="many-to-one" fkcolumn="FK_calendarID" lazy="true" fetch="join";

	// Constructor
	function init(){

		return this;
	}

	/**
	* is loaded?
	*/
	boolean function isLoaded(){
		return len( getEventID() );
	}

	/*
	* Validate entry, returns an array of error or no messages
	*/
	array function validate(){
		var errors = [];

		// limits
		name				= left(name,200);

		// Required
		if( !len(name) ){ arrayAppend(errors, "Name is required"); }

		return errors;
	}

}
