<cfoutput>
<!--============================Main Column============================-->
<div class="row-fluid">
	<div class="span9" id="main-content">
		<div class="box">
			<!--- Body Header --->
			<div class="header">
				<i class="icon-calendar icon-large"></i>
				Calendars
			</div>
			<!--- Body --->
			<div class="body">

				<!--- MessageBox --->
				#getPlugin("MessageBox").renderit()#

				<!--- calendar form --->
				#html.startForm(name="calendarForm",action=prc.xehCalendarRemove)#
				#html.hiddenField(name="calendarID",value="")#

				<!--- Filter Bar --->
				<div class="well well-small">
					<div class="buttonBar">
						<button class="btn btn-danger" onclick="return to('#event.buildLink(prc.xehCalendarEditor)#')" title="Create new calendar">Create Calendar</button>
					</div>
					<div class="filterBar">
						<div>
							#html.label(field="calendarFilter",content="Quick Filter:",class="inline",style="margin-right: 7px;")#
							#html.textField(id="calendarFilter",size="30",style="margin: 0;")#
						</div>
					</div>
				</div>

				<!--- calendars --->
				<table name="calendars" id="calendars" class="tablesorter table table-striped" width="98%">
					<thead>
						<tr>
							<th>Name</th>
							<th>Slug</th>
							<th>Created Date</th>
							<th width="75" class="center {sorter:false}">Actions</th>
						</tr>
					</thead>
					<tbody>
						<cfloop array="#prc.calendars#" index="calendar">
						<tr>
							<td><a href="#event.buildLink(prc.xehCalendarEditor)#/calendarID/#calendar.getCalendarID()#"
								   title="Edit #calendar.getName()#">#calendar.getName()#</a></td>
							<td>#calendar.getSlug()#</td>
							<td>#dateFormat(calendar.getCreatedDate(),"short")# #timeFormat(calendar.getCreatedDate(),"short")#</td>
							<td class="center">
								<!--- Edit Command --->
								<a href="#event.buildLink(prc.xehCalendarEditor)#/calendarID/#calendar.getCalendarID()#"
								   title="Edit #calendar.getName()#"><i class="icon-edit icon-large"></i></a>
								<!--- Delete Command --->
								<a title="Delete Calendar" href="javascript:removeCalendar('#calendar.getCalendarID()#')" class="confirmIt textRed" data-title="Delete Calendar?"><i id="delete_#calendar.getCalendarID()#" class="icon-trash icon-large"></i></a>
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
	<div class="span3" id="main-sidebar">
		<cfinclude template="../sidebar/actions.cfm">
		<cfinclude template="../sidebar/about.cfm">
	</div>
</div>
</cfoutput>