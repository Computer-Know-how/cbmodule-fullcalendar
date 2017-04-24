<cfoutput>
	#renderView( "viewlets/assets" )#
	<!--============================Main Column============================-->
	<div class="row">
		<div class="col-md-12">
			<h1 class="h1">
				<i class="fa fa-gear"></i> Calendars
			</h1>
		</div>
	</div>
	<div class="row">
		<div class="col-md-9">
			<div class="panel panel-default">
				<div class="panel-body">
					#getInstance("MessageBox@cbmessagebox").renderit()#

						<!--- calendar form --->
						#html.startForm(name="calendarForm",action=prc.xehCalendarRemove)#
						#html.hiddenField(name="calendarID",value="")#

						<!--- Filter Bar --->
						<div class="well well-sm">
							<div class="btn-group btn-sm pull-right">
								<button class="btn btn-sm btn-primary" onclick="return to('#event.buildLink(prc.xehCalendarEditor)#')" title="Create new calendar">Create Calendar</button>
							</div>
							
							<div class="form-group form-inline no-margin">
								<input type="text" name="calendarFilter" size="30" class="form-control" placeholder="Quick Filter" id="calendarFilter">
							</div>
						</div>

						<!--- calendars --->
						<table name="calendars" id="calendars" class="tablesorter table table-striped" width="98%">
							<thead>
								<tr>
									<th>Name</th>
									<th>Slug</th>
									<th>Created Date</th>
									<th width="75" class="text-center {sorter:false}">Actions</th>
								</tr>
							</thead>
							<tbody>
								<cfloop array="#prc.calendars#" index="calendar">
								<tr>
									<td><a href="#event.buildLink(prc.xehCalendarEditor)#/calendarID/#calendar.getCalendarID()#"
										   title="Edit #calendar.getName()#">#calendar.getName()#</a></td>
									<td>#calendar.getSlug()#</td>
									<td>#dateFormat(calendar.getCreatedDate(),"short")# #timeFormat(calendar.getCreatedDate(),"short")#</td>
									<td class="text-center">
										<!--- Edit Command --->
										<a class="btn btn-sm btn-primary" href="#event.buildLink(prc.xehCalendarEditor)#/calendarID/#calendar.getCalendarID()#"
										   title="Edit #calendar.getName()#"><i class="fa fa-pencil fa-lg"></i></a>
										<!--- Delete Command --->
										<a class="btn btn-sm btn-danger confirmIt" title="Delete Calendar" href="javascript:removeCalendar('#calendar.getCalendarID()#')" data-title="Delete Calendar?"><i id="delete_#calendar.getCalendarID()#" class="fa fa-trash fa-lg"></i></a>
									</td>
								</tr>
								</cfloop>
							</tbody>
						</table>
						#html.endForm()#

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