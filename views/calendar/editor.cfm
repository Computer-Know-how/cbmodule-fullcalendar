<cfoutput>
	#renderView( "viewlets/assets" )#
	<!--============================Main Column============================-->
	<div class="row">
		<div class="col-md-12">
			<h1 class="h1">
				<i class="fa fa-gear"></i> Full Calendar Global Settings
			</h1>
		</div>
	</div>
	<div class="row">
		<div class="col-md-9">
			<div class="panel panel-default">
				<div class="panel-body">
					#getInstance("MessageBox@cbmessagebox").renderit()#

					<div class="tabbable tabs-left">
						<!--- User Navigation Bar --->
						<ul class="nav nav-tabs">
							<li <cfif !prc.calendar.isLoaded() or prc.calendar.getCalendarType() eq "google">class="active"</cfif>><a href="##calendarDetails" data-toggle="tab"><i class="fa fa-calendar"></i> Calendar Details</a></li>

							<cfif prc.calendar.isLoaded()>
								<cfif prc.calendar.getCalendarType() neq "google">
									<li class="active"><a href="##calendarEvents" data-toggle="tab"><i class="fa fa-list-ul"></i> Calendar Events</a></li>
								</cfif>
								<li><a href="##calendarSettings" data-toggle="tab"><i class="fa fa-gear"></i> Calendar Settings</a></li>
							</cfif>
						</ul>

						<div class="tab-content">
							<div class="tab-pane<cfif !prc.calendar.isLoaded() or prc.calendar.getCalendarType() eq "google"> active</cfif>" id="calendarDetails">
								<!--- Calendar Details --->
								#html.startForm(name="calendarDetails",action=prc.xehCalendarSave,novalidate="novalidate")#
									#html.startFieldset(legend="<i class='fa fa-calendar'></i> Calendar Details")#
									#html.hiddenField(name="calendarID",bind=prc.calendar)#

									#html.textField(name="name", label="Name:", title="A friendly name for your calendar.", bind=prc.calendar, class="form-control", size="50", wrapper="div class=controls", labelClass="control-label", groupWrapper="div class=form-group")#

									#html.textField(name="slug", label="Slug:", title="A unique identifier for your calendar.", bind=prc.calendar, class="form-control", size="50", wrapper="div class=controls", labelClass="control-label", groupWrapper="div class=form-group")#

									<div class="form-group">
										<label class="control-label" for="calendarType">Calendar Type:</label>
										<div class="controls">
											<select name="calendarType" class="form-control input-sm" title="The type of calendar to create.">
												<option hidden="hidden">Choose a calendar type</option>
												<option <cfif prc.calendar.getCalendarType() eq "google">selected</cfif> value="google">Google Calendar</option>
												<option <cfif prc.calendar.getCalendarType() eq "contentbox">selected</cfif> value="contentbox">ContentBox Calendar</option>
											</select>
										</div>
									</div>

									#html.endFieldSet()#

									<div class="form-actions">
										<button class="btn" onclick="return to('#event.buildLink(prc.xehCalendars)#')">Cancel</button>
										<input type="submit" value="Save" class="btn btn-danger">
									</div>
								#html.endForm()#
							</div>

							<!--- Calendar Events --->
							<cfif prc.calendar.getCalendarType() neq "google">
								<div class="tab-pane<cfif prc.calendar.isLoaded()> active</cfif>" id="calendarEvents">
									#prc.eventsViewlet#
								</div>
							</cfif>

							<!--- Calendar Settings --->
							<div class="tab-pane" id="calendarSettings">
								#html.startForm(name="calendarSettings",action=prc.xehCalendarSave,novalidate="novalidate")#
									#html.startFieldset(legend="<i class='fa fa-calendar'></i> Calendar View Settings")#
										#html.hiddenField(name="calendarID",bind=prc.calendar)#

										#html.textField(name="eventColor", label="Event Background Color (leave blank for default color)", title="Event Background Color", bind=prc.calendar, class="form-control jscolor {required:false, hash: true}", size="50", wrapper="div class=controls", labelClass="control-label", groupWrapper="div class=form-group")#

										#html.textField(name="eventTextColor", label="Event Text Color (leave blank for default color)", title="Event Text Color", bind=prc.calendar, class="form-control jscolor {required:false, hash: true}", size="50", wrapper="div class=controls", labelClass="control-label", groupWrapper="div class=form-group")#

									#html.endFieldSet()#

									<cfif prc.calendar.getCalendarType() eq "google">
										#html.startFieldset(legend="<i class='fa fa-google'></i> Google Calendar Settings")#

											#html.textField(name="googleCalendarID", label="Google Calendar ID", title="Google Calendar ID", bind=prc.calendar, class="form-control", size="50", wrapper="div class=controls", labelClass="control-label", groupWrapper="div class=form-group")#

											#html.textField(name="googleCalendarApiKey", label="Google Calendar API Key (leave blank to use global API Key)", title="Google Calendar API Key", bind=prc.calendar, class="form-control", size="50", wrapper="div class=controls", labelClass="control-label", groupWrapper="div class=form-group")#
											
										#html.endFieldSet()#
									</cfif>

									<div class="form-actions">
										<button class="btn" onclick="return to('#event.buildLink(prc.xehCalendars)#')">Cancel</button>
										<input type="submit" value="Save" class="btn btn-danger">
									</div>
								#html.endForm()#
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!--============================ Sidebar ============================-->
		<div class="col-md-3">
			<cfinclude template="../sidebar/actions.cfm">
			<cfinclude template="../sidebar/about.cfm">
		</div>
	</div>
</cfoutput>