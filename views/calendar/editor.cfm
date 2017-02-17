<cfoutput>
#renderView( "viewlets/assets" )#
<!--============================Main Column============================-->
<div class="row-fluid">
	<div class="span9" id="main-content">
		<div class="box">
			<!--- Body Header --->
			<div class="header">
				<i class="fa fa-pencil fa-lg"></i>
				<cfif prc.calendar.isLoaded()>Editing Calendar "#prc.calendar.getName()#"<cfelse>Create Calendar</cfif>
			</div>
			<!--- Body --->
			<div class="body">
				#getPlugin("MessageBox").renderIt()#

				<div class="tabbable tabs-left">
					<!--- User Navigation Bar --->
					<ul class="nav nav-tabs">
						<li <cfif !prc.calendar.isLoaded() or prc.calendar.getCalendarType() eq "google">class="active"</cfif>><a href="##calendarDetails" data-toggle="tab"><i class="fa fa-calendar"></i> Calendar Details</a></li>

						<cfif prc.calendar.isLoaded()>
							<cfif prc.calendar.getCalendarType() neq "google">
								<li class="active"><a href="##calendarEvents" data-toggle="tab"><i class="icon-list-ul"></i> Calendar Events</a></li>
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

								<label for="name" class="required">Name:</label>
								#html.textField(name="name",bind=prc.calendar,required="required",size="50",class="textfield",title="A friendly name for your calendar.")#

								<label for="slug" class="required">Slug:</label>
								#html.textField(name="slug",bind=prc.calendar,required="required",size="50",class="textfield",title="A unique identifier for your calendar.")#

								<label for="type" class="required">Calendar Type:</label>
								<select name="calendarType" title="The type of calendar to create." required>
									<option hidden>Choose a calendar type</option>
									<option <cfif prc.calendar.getCalendarType() eq "google">selected</cfif> value="google">Google Calendar</option>
									<option <cfif prc.calendar.getCalendarType() eq "contentbox">selected</cfif> value="contentbox">ContentBox Calendar</option>
								</select>

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

									<label>
										<label>Event Background Color (leave blank for default color)</label>
										#html.textField(name="eventColor",bind=prc.calendar,size="50",class="textfield jscolor {required:false, hash: true}",title="Event Background Color")#
									</label>

									<label>
										<label>Event Text Color (leave blank for default color)</label>
										#html.textField(name="eventTextColor",bind=prc.calendar,size="50",class="textfield jscolor {required:false, hash: true}",title="Event Text Color")#
									</label>
								#html.endFieldSet()#

								<cfif prc.calendar.getCalendarType() eq "google">
									#html.startFieldset(legend="<i class='fa fa-google'></i> Google Calendar Settings")#
										<label>Google Calendar ID</label>
										#html.textField(name="googleCalendarID",bind=prc.calendar,size="100",class="textfield",title="Google Calendar ID")#

										<label>Google Calendar API Key (leave blank to use global API Key)</label>
										#html.textField(name="googleCalendarApiKey",bind=prc.calendar,size="100",class="textfield",title="Google Calendar API Key")#
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
	<div class="span3" id="main-sidebar">
		<cfinclude template="../sidebar/actions.cfm">
		<cfinclude template="../sidebar/about.cfm">
	</div>
</div>
</cfoutput>