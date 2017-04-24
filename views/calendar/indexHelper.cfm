<script type="text/javascript">
	$(document).ready(function() {
		// quick filter
		$("#calendarFilter").keyup(function(){
			$.uiTableFilter( $("#calendars"), this.value );
		});

		$("#calendars").dataTable({
			"paging": false,
			"info": false,
			"searching": false,
			"columnDefs": [
			{ 
				"orderable": false, 
				"targets": '{sorter:false}' 
			}
			],
			"order": []
		});
	});

	function removeCalendar(calendarID){
		$("#calendarID").val( calendarID );
		$("#calendarForm").submit();
	}
</script>