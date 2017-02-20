<cfoutput>
#renderView( "viewlets/assets" )#
<!--============================Main Column============================-->
<div class="row-fluid">
	<div class="span9" id="main-content">
		<div class="box">
			<!--- Body Header --->
			<div class="header">
				<i class="fa fa-gear fa-lg"></i> Full Calendar Global Settings
			</div>
			<!--- Body --->
			<div class="body" id="mainBody">
				#getPlugin("MessageBox").renderit()#

				<cfif !prc.settings.hideJqueryAlert>
					<div class="alert alert-warning">
						<i class="fa fa-warning fa-lg"></i>
						<i>Please Note: This module requires JQuery. Please make sure any JQuery includes are placed before this line: <code>##cb.event("cbui_beforeBodyEnd")##</code> in your <code>pages.cfm</code> file. If you do not use JQuery check the box labeled <b>Include JQuery with Full Calendar</b> in the settings below.</i>
					</div>
				</cfif>

				<div class="tabbable tabs-left">
					<ul class="nav nav-tabs">
						<li class="active"><a href="##calendarSettings" data-toggle="tab"><i class="fa fa-calendar"></i> Calendar Settings</a></li>
						<li><a href="##googleCalendarSettings" data-toggle="tab"><i class="fa fa-google"></i> Google Calendar Settings</a></li>
						<li><a href="##styles" data-toggle="tab"><i class="fa fa-magic"></i> Styles</a></li>
					</ul>

					<div class="tab-content">
						<!--- Settings: Calendar Settings --->
						<div class="tab-pane active" id="calendarSettings">
							#html.startForm(action="#cb.buildModuleLink('fullCalendar','settings.saveSettings')#",name="settingsForm")#
								#html.startFieldset(legend="Navigation Settings")#
								<label>
									<input type="checkbox" name="nextPrevButtons" <cfif prc.settings.nextPrevButtons>checked</cfif> class="noMargin">
									&nbsp;&nbsp;Show Next/Prev buttons
								</label>

								<label>
									<input type="checkbox" name="todayButton" <cfif prc.settings.todayButton>checked</cfif> class="noMargin">
									&nbsp;&nbsp;Show Today button
								</label>

								<label>
									<input type="checkbox" name="dateButton" <cfif prc.settings.dateButton>checked</cfif> class="noMargin">
									&nbsp;&nbsp;Show Date
								</label>

								<label>
									<input type="checkbox" name="monthButton" <cfif prc.settings.monthButton>checked</cfif> class="noMargin">
									&nbsp;&nbsp;Show Month button
								</label>

								<label>
									<input type="checkbox" name="weekButton" <cfif prc.settings.weekButton>checked</cfif> class="noMargin">
									&nbsp;&nbsp;Show Week button
								</label>

								<label>
									<input type="checkbox" name="dayButton" <cfif prc.settings.dayButton>checked</cfif> class="noMargin">
									&nbsp;&nbsp;Show Day button
								</label>

								<label>
									<input type="checkbox" name="agendaButton" <cfif prc.settings.agendaButton>checked</cfif> class="noMargin">
									&nbsp;&nbsp;Show Agenda button
								</label>

								<label>
									<input type="checkbox" name="refreshButton" <cfif prc.settings.refreshButton>checked</cfif> class="noMargin">
									&nbsp;&nbsp;Show Refresh button
								</label>

								#html.endFieldSet()#

								#html.startFieldset(legend="Default View")#
									<label>
										<input type="radio" name="defaultView" value="month" <cfif prc.settings.defaultView eq "month">checked</cfif> class="noMargin">
										&nbsp;&nbsp;Month
									</label>
									<label>
										<input type="radio" name="defaultView" value="agendaWeek" <cfif prc.settings.defaultView eq "agendaWeek">checked</cfif> class="noMargin">
										&nbsp;&nbsp;Week
									</label>
									<label>
										<input type="radio" name="defaultView" value="agendaDay" <cfif prc.settings.defaultView eq "agendaDay">checked</cfif> class="noMargin">
										&nbsp;&nbsp;Day
									</label>
									<label>
										<input type="radio" name="defaultView" value="listWeek" <cfif prc.settings.defaultView eq "listWeek">checked</cfif> class="noMargin">
										&nbsp;&nbsp;Agenda
									</label>
								#html.endFieldSet()#

								#html.startFieldset(legend="Other Settings")#

									<label>
										<input type="checkbox" name="showLegend" <cfif prc.settings.showLegend>checked</cfif> class="noMargin">
										&nbsp;&nbsp;Show Legend
									</label>

									<label>
										<input type="checkbox" name="navLinks" <cfif prc.settings.navLinks>checked</cfif> class="noMargin">
										&nbsp;&nbsp;Go to date when clicking on date number
									</label>

									<label>
										<input type="checkbox" name="includeJquery" <cfif prc.settings.includeJquery>checked</cfif> class="noMargin">
										&nbsp;&nbsp;Include Jquery with Full Calendar
									</label>

									<label>
										<input type="checkbox" name="hideJqueryAlert" <cfif prc.settings.hideJqueryAlert>checked</cfif> class="noMargin">
										&nbsp;&nbsp;Hide Jquery alert
									</label>

								#html.endFieldSet()#

								<!--- Button Bar --->
								<div class="form-actions">
									#html.submitButton(value="Save Settings", class="btn btn-danger")#
								</div>

							#html.endForm()#
						</div>

						<div class="tab-pane" id="googleCalendarSettings">
							#html.startForm(action="#cb.buildModuleLink('fullCalendar','settings.saveSettings')#",name="settingsForm")#
								#html.startFieldset(legend="Google Calendar Settings")#
									<label>Google Calendar API Key</label>
									<input type="text" name="googleCalendarApiKey" value="#prc.settings.googleCalendarApiKey#" class="form-control width98">

									<label>
										<input type="checkbox" name="newTab" <cfif prc.settings.newTab>checked</cfif> class="noMargin">
										&nbsp;&nbsp;Open Google calendar events in new tab
									</label>
								#html.endFieldSet()#

								<!--- Button Bar --->
								<div class="form-actions">
									#html.submitButton(value="Save Settings", class="btn btn-danger")#
								</div>

							#html.endForm()#
						</div>
						<div class="tab-pane" id="styles">
							#html.startForm(action="#cb.buildModuleLink('fullCalendar','settings.saveSettings')#",name="settingsForm")#
								#html.startFieldset(legend="Styles")#
									<label>
										<label>Event Background Color (leave blank for default color)</label>
										<input type="text" name="eventColor" value="#prc.settings.eventColor#" class="form-control width98 jscolor {required:false, hash: true}">
									</label>

									<label>
										<label>Event Text Color (leave blank for default text color)</label>
										<input type="text" name="eventTextColor" value="#prc.settings.eventTextColor#" class="form-control width98 jscolor {required:false, hash: true}">
									</label>
								#html.endFieldSet()#
									<!--- Button Bar --->
									<div class="form-actions">
										#html.submitButton(value="Save Settings", class="btn btn-danger")#
									</div>

							#html.endForm()#
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!--============================ Sidebar ============================-->
	<div class="span3" id="main-sidebar">
		<cfinclude template="../sidebar/actions.cfm">
		<cfinclude template="../sidebar/about.cfm">
	</div>
</div>
</cfoutput>