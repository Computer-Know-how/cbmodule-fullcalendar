<cfoutput>
<!--- Info Box --->
<div class="small_box">
	<div class="header">
		<i class="icon-cogs"></i> Actions
	</div>
	<div class="body" style="padding: 10px;">
		<!--- Forms --->
		<button class="btn btn-danger" onclick="return to('#event.buildLink(prc.xehCalendars)#')">Calendars</button>
		<button class="btn" onclick="return to('#event.buildLink('cbadmin.module.fullCalendar.settings.index')#')" title="Set global calendar settings">Settings</button>
		<button class="btn" onclick="return to('#event.buildLink('cbadmin.module.fullCalendar.help.index')#')" title="Helpful guides for setting up calendars">Help</button>
	</div>
</div>
</cfoutput>