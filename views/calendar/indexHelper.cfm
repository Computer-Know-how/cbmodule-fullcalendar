<cfoutput>
<script type="text/javascript">
	$(document).ready(function() {
		// quick filter
		$("##calendars").tablesorter();
		$("##calendarFilter").keyup(function(){
			$.uiTableFilter( $("##calendars"), this.value );
		})
	});
	function removeCalendar(calendarID){
		$("##calendarID").val( calendarID );
		$("##calendarForm").submit();
	}
</script>
</cfoutput>