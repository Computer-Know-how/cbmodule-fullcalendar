/**
********************************************************************************
Copyright 2017 Full Calendar by Mark Skelton and Computer Know How, LLC
www.compknowhow.com
********************************************************************************

Author:  Mark Skelton
Description:  Calendar Service object
*/
component extends="coldbox.system.orm.hibernate.VirtualEntityService" singleton {

	/**
	* Constructor
	*/
	public CalendarService function init(){

		// init super class
		super.init(entityName="CalendarService");

		// Use Query Caching
		setUseQueryCaching( true );
		// Query Cache Region
		setQueryCacheRegion( 'FullCalendar' );
		// EventHandling
		setEventHandling( true );

		return this;
	}

	/**
	* Checks if ORM entities are setup correctly
	* returns {Boolean} whether  or not ORM entities are setup correctly
	*/
	public Boolean function isDataSetup() {
		try {
			var testData = EntityLoad( "Calendar" );
			return true;
		}
		catch( any e ) {
			return false;
		}
	}

}