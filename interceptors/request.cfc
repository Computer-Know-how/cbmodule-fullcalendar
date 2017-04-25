/**
********************************************************************************
Copyright 2017 Full Calendar by Mark Skelton and Computer Know How, LLC
www.compknowhow.com
********************************************************************************

Author:  Mark Skelton
Description:  Intercepts events starting with fullCalendar and preprocess with ContentBox admin
*/
component extends="modules.contentbox.modules.contentbox-admin.interceptors.CBRequest" {

	function configure(){}

	function preProcess( event, interceptData ) eventPattern="^fullCalendar" {
		variables.childModulesRegex = "fullCalendar";
		super.preProcess(event,interceptData);
	}
}