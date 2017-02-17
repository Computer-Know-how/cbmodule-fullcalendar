/*
********************************************************************************
Copyright 2017 Full Calendar by Mark Skelton and Computer Know How, LLC
www.compknowhow.com
********************************************************************************

Author:  Mark Skelton
Description:  Intercepts the cbui_beforeHeadEnd and cbui_beforeBodyEnd ContentBox events to insert the required js and css on a page with the Full Calendar widget
*/
component extends="coldbox.system.Interceptor" {
	property name="settingService" inject="id:settingService@cb";

	// include the necessary css at the head of the page
	void function cbui_beforeHeadEnd(event, struct interceptData) {
		var css = "";
		css &= "<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.1.0/fullcalendar.min.css' />";
		// css &= "<link rel='stylesheet' href='https://cdn.jsdelivr.net/qtip2/3.0.3/jquery.qtip.min.css' />";
		appendToBuffer(css);
	}

	// include the necessary js at the end of the page
	void function cbui_beforeBodyEnd(event, struct interceptData) {
		var js = "";
		if (deserializeJSON(settingService.getSetting("fullcalendar")).includeJquery) {
			js &= "<script src='//ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js'></script>";
		}
		js &= "<script src='//cdnjs.cloudflare.com/ajax/libs/moment.js/2.17.1/moment.min.js'></script>";
		js &= "<script src='//cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.1.0/fullcalendar.min.js'></script>";
		js &= "<script src='//cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.1.0/gcal.min.js'></script>";
		// js &= "<script src='https://cdn.jsdelivr.net/qtip2/3.0.3/jquery.qtip.min.js'></script>";
		appendToBuffer(js);
	}
}