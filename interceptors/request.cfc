/**
********************************************************************************
Copyright 2017 Full Calendar by Mark Skelton and Computer Know How, LLC
www.compknowhow.com
********************************************************************************

Author:  Mark Skelton
Description:  Intercepts events starting with fullCalendar and preprocess with ContentBox admin
*/
component extends="contentbox-admin.interceptors.CBRequest" {

	void function configure(){}

	void function preProcess(event,struct interceptData) eventPattern="^fullCalendar"{
		super.preProcess(event,interceptData);
	}

}