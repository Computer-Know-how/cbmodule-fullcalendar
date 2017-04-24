/**
********************************************************************************
Copyright 2017 Full Calendar by Mark Skelton and Computer Know How, LLC
www.compknowhow.com
********************************************************************************

Author:  Mark Skelton
Description:  I handle the help events
*/
component extends="base" {

	function index(event,rc,prc){
		event.setView(view="help/index",module="cbmodule-fullcalendar");
	}
}
