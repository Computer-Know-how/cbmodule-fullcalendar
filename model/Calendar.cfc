/**
********************************************************************************
Copyright 2017 Full Calendar by Mark Skelton and Computer Know How, LLC
www.compknowhow.com
********************************************************************************

Author:  Mark Skelton
Description:  Calendar ORM object
*/
component persistent="true" table="cb_calendar" {

	// Primary Key
	property name="calendarID" fieldtype="id" column="calendarID" generator="identity" setter="false";

	// Properties
	property name="name" notnull="true" length="200" default="" index="idx_name";
	property name="slug" notnull="true" length="200" default="" unique="true" index="idx_slug";
	property name="calendarType" notnull="false" length="200" default="";

	// google calendar
	property name="googleCalendarApiKey" notnull="false" length="500" default="";
	property name="googleCalendarID" notnull="false" length="500" default="";

	// settings
	property name="eventColor" notnull="false" length="50" default="";
	property name="eventTextColor" notnull="false" length="50" default="";

	property name="createdDate" notnull="true" ormtype="timestamp" update="false" index="idx_createdDate";

	// O2M -> events
	property name="events" singularName="events" fieldtype="one-to-many" type="array" lazy="extra" batchsize="25"
		cfc="contentbox.modules_user.fullCalendar.model.Event" fkcolumn="FK_calendarID" inverse="true" cascade="all-delete-orphan";

	// Constructor
	function init(){

		return this;
	}

	/**
	* is loaded?
	*/
	boolean function isLoaded(){
		return len( getCalendarID() );
	}

	/*
	* Validate entry, returns an array of error or no messages
	*/
	array function validate(){
		var errors = [];

		// limits
		name				= left(name,200);
		slug				= left(slug,200);

		// Required
		if( !len(name) ){ arrayAppend(errors, "Name is required"); }
		if( !len(slug) ){ arrayAppend(errors, "Slug is required"); }

		return errors;
	}
}
