<cfoutput>
	<script>
		// global current event used when updating and deleting events
		var currentEvent;
		var calendarID = '#prc.calendar.getCalendarID()#';

		function updateEvent(event, delta, action, revertFunction) {
			// send the ajax call to update database
			$.post('/fullCalendar/calendar/updateEvent', {
				calendarID: calendarID,
				eventID: event.eventID,
				allDay: event.allDay,
				deltaMinutes: delta.asMinutes(),
				action: action
			}, function(resp) {
				if (resp === true || resp === "true") {
					console.info('Event updated!');
				} else {
					revertFunction();
				}
			});
		}

		function saveEventToDB(eventData, action, view) {

			if (action == 'delete') {
				$('##spinner-text').html('Deleting Event.');
				$('.event-spinner').css('display', 'block');
			} else {
				$('##spinner-text').html('Saving Event.');
				$('.event-spinner').css('display', 'block');
			}

			var eventID = currentEvent ? currentEvent.eventID : '';

			// send the ajax call to update database
			$.post('/fullCalendar/calendar/saveEvent', {
				calendarID: calendarID,
				eventID: eventID,
				name: eventData.title,
				description: eventData.description,
				startTime: eventData.start,
				endTime: eventData.end,
				allDay: eventData.allDay,
				action: action
			}, function(resp) {
				if ($.isNumeric(resp) || resp) {
					eventData.start = moment(eventData.start);
					eventData.end = moment(eventData.end);

					if (eventData.allDay && view == 'month') {
						eventData.end = eventData.end.add(1, 'd');
					}

					if (action == 'add') {
						console.info('Event added!');
						eventData.eventID = resp;
						$('##calendar').fullCalendar('renderEvent', eventData, true);
					}
					else if (action == 'edit') {
						console.info('Event updated!');
						eventData.eventID = eventID;

						$('##calendar').fullCalendar('removeEvents', currentEvent._id);
						$('##calendar').fullCalendar('renderEvent', eventData, true);
					}
					else {
						console.info('Event deleted!');
						$('##calendar').fullCalendar('removeEvents', currentEvent._id);
					}

					$('.event-spinner').css('display', 'none');
					// hide the modal
					$('##eventModal').modal('hide');
					clearModal();

				} else {
					console.warn(response);
				}
			});
		}

		function deleteEvent() {
			var eventData = {
				title: currentEvent.title,
				description: currentEvent.description,
				start: currentEvent.start.format('YYYY-MM-DD') + 'T' + currentEvent.start.format('HH:MM:SS'),
				end: currentEvent.start.format('YYYY-MM-DD') + 'T' + currentEvent.start.format('HH:MM:SS'),
				allDay: currentEvent.allDay
			}

			saveEventToDB(eventData, 'delete');
		}

		function saveEvent() {
			var title = $('##eventTitle').val().trim();
			if (title == '') {
				$('##alertBox').css('display', 'block')
				$('##alertBoxText').html('Title is required.');
				$("##alertBox").fadeTo(2000, 500).slideUp(500, function(){
					$("##alertBox").slideUp(500);
				});
				return false;
			}

			var description = $('##eventDescription').val().trim();

			var startDate = $('##eventStartDate').val().trim().split('/');
			var startTime = $('##eventStartTime').val().trim();

			var allDay = $('##allDay')[0].checked;

			var endDate = $('##eventEndDate').val().trim().split('/');
			var endTime = $('##eventEndTime').val().trim();

			var startYear = startDate[2];
			var startMonth = startDate[0].length == 1 ? '0' + startDate[0] : startDate[0];
			var startDay = startDate[1].length == 1 ? '0' + startDate[1] : startDate[1];

			var endYear = endDate[2];
			var endMonth = endDate[0].length == 1 ? '0' + endDate[0] : endDate[0];
			var endDay = endDate[1].length == 1 ? '0' + endDate[1] : endDate[1];

			if (!allDay) {
				var startHour = startTime.split(':')[0];
				var startMinute = startTime.split(':')[1].split(' ')[0];

				if (startTime.split(' ')[0] != '12:00' && startTime.split(' ')[1] == 'PM') {
					startHour = parseInt(startHour) + 12;
				} else if (startTime == '12:00 AM') {
					startHour = '00';
				}

				var endHour = endTime.split(':')[0];
				var endMinute = endTime.split(':')[1].split(' ')[0];

				if (endTime.split(' ')[1] == 'PM' && !endTime.startsWith('12')) {
					endHour = parseInt(endHour) + 12;
				} else if (endTime == '12:00 AM') {
					endHour = '00';
				}

				startHour = startHour.length == 1 ? '0' + startHour : startHour;
				endHour = endHour.length == 1 ? '0' + endHour : endHour;

				var start = startYear + '-' + startMonth + '-' + startDay + 'T' + startHour + ':' + startMinute + ':00';
				var end = endYear + '-' + endMonth + '-' + endDay + 'T' + endHour + ':' + endMinute + ':00';

				if (moment(end).diff(moment(start), 'minutes') <= 0) {
					$('##alertBox').css('display', 'block')
					$('##alertBoxText').html('End date must be after start date.');
					$("##alertBox").fadeTo(2000, 500).slideUp(500, function(){
						$("##alertBox").slideUp(500);
					});
					return false;
				}
			} else {
				var start = startYear + '-' + startMonth + '-' + startDay + 'T00:00:00';
				var end = endYear + '-' + endMonth + '-' + endDay + 'T00:00:00';

				if (moment(end).diff(moment(start), 'days') < 0) {
					$('##alertBox').css('display', 'block')
					$('##alertBoxText').html('End date must be after start date.');
					$("##alertBox").fadeTo(2000, 500).slideUp(500, function(){
						$("##alertBox").slideUp(500);
					});
					return false;
				}
			}

			var eventData = {
				title: title,
				description: description,
				start: start,
				end: end,
				allDay: allDay
			}

			var action = $('##action').val();
			var view = $('##calendar').fullCalendar('getView').type;

			saveEventToDB(eventData, action, view);
		}

		function clearModal() {
			$('.date-picker').datepicker('hide');

			$('##eventTitle').val('');
			$('##eventDescription').val('');

			$('##eventStartDate').val('');
			$('##eventEndDate').val('');

			$('##allDay').attr('checked', 'checked');
			$('##timeFields').css('display', 'none');

			$('##eventStartTime').val('');
			$('##eventEndTime').val('');
		}

		$(document).ready(function() {
			$('input').each(function (index) {
				$(this).keypress(function (e) {
					if (e.keyCode == 13) e.preventDefault();
				});
			});

			$.fn.datepicker.defaults.format = 'm/d/yyyy';
			$('.date-picker, .clockpicker').attr('readonly', true);
			$('.date-picker').datepicker();

			$('.date-picker').on('changeDate', function(){
				$(this).datepicker('hide');
			});

			$('.date-picker').show(function(){
				$('.date-picker').datepicker('hide');
				$(this).datepicker('update', new Date());
			});

			$('.clockpicker').clockpicker({
				autoclose: true,
				twelvehour: true
			}).change(function(){
				var value = $(this).val();
				$(this).val(value.substring(0, value.length - 2) + ' ' + value.slice(-2));
			});

			$('##allDay').on('change', function() {
				if (this.checked) {
					$('##timeFields').css('display', 'none');
				} else {
					$('##timeFields').css('display', 'block');
				}
			});

			$('##saveButton').on('click', function() {
				saveEvent();
			});

			$('##deleteButton').on('click', function() {
				deleteEvent();
			});

			$('##eventModal').on('hidden', function () {
				clearModal();
			})

			$('##calendar').fullCalendar({
				header: {
					left: 'prev,next today',
					center: 'title',
					right: 'month,agendaWeek,agendaDay'
				},
				buttonText: {
					today: 'Today',
					month: 'Month',
					week: 'Week',
					day: 'Day'
				},
				editable: true,
				eventColor: '',
				navLinks: true,
				selectable: true,
				eventClick: function(event, jsEvent, view) {
					$('##eventTitle').val(event.title);
					$('##eventDescription').val(event.description);

					$('##eventStartDate').val(event.start.format('M/D/YYYY'));

					if (!event.end) {
						event.end = moment(event.start).add(2, 'h');
					}

					if (event.allDay) {
						if (event.end.minutes() == 0) {
							event.end.subtract(1, 'd');
						}
						$('##eventEndDate').val(event.end.format('M/D/YYYY'));

						$('##eventStartTime').val('12:00 PM');
						$('##eventEndTime').val('1:00 PM');

						$('##allDay').attr('checked', 'checked');
						$('##timeFields').css('display', 'none');
					} else {
						$('##eventEndDate').val(event.end.format('M/D/YYYY'));

						$('##eventStartTime').val(event.start.format('h:mm A'));
						$('##eventEndTime').val(event.end.format('h:mm A'));

						$('##allDay').removeAttr('checked');
						$('##timeFields').css('display', 'block');
					}

					$('##action').val('edit');
					$('##deleteButton').css('display', '');
					currentEvent = event;

					// update the datepicker to the correct dates
					$('.date-picker').datepicker('update');
					$('##eventModal').modal('show');
				},
				select: function(start, end, jsEvent, view) {
					if (view.name == 'month') {
						end = end.subtract(1, 'd');
					}

					var startDate = start.format('M/D/YYYY');
					var endDate = end.format('M/D/YYYY');

					if (view.name == 'month') {
						var startTime = '12:00 PM';
						var endTime = '1:00 PM';

						$('##allDay').attr('checked', 'checked');
						$('##timeFields').css('display', 'none');
					} else {
						var startTime = start.format('h:mm A');
						var endTime = end.format('h:mm A');

						$('##allDay').removeAttr('checked');
						$('##timeFields').css('display', 'block');
					}

					$('##eventStartDate').val(startDate);
					$('##eventEndDate').val(endDate);

					$('##eventStartTime').val(startTime);
					$('##eventEndTime').val(endTime);

					$('##action').val('add');
					$('##deleteButton').css('display', 'none');

					// update the datepicker to the correct dates
					$('.date-picker').datepicker('update');
					$('##eventModal').modal('show');
				},
				eventDrop: function(event, delta, revertFunction) {
					updateEvent(event, delta, 'move', revertFunction);
				},
				eventResize: function(event, delta, revertFunction) {
					updateEvent(event, delta, 'resize', revertFunction);
				},
				editable: true,
				eventLimit: true,
				events: [
					<cfset calendarEvents = prc.calendar.getEvents()>
					<cfif !isNull(calendarEvents)>
						<cfloop array="#calendarEvents#" index="calendarEvent">
							{
								title : '#reReplace(calendarEvent.getName(), "\'", "\'", "all")#',
								description : '#reReplace(calendarEvent.getDescription(), "\'", "\'", "all")#',
								eventID : '#calendarEvent.getEventID()#',
								start : '#dateFormat(calendarEvent.getStartTime(), "yyyy-mm-dd")#T#timeFormat(calendarEvent.getStartTime(), "HH:mm:ss")#',
								<cfif calendarEvent.getAllDay() eq 1 and timeFormat(calendarEvent.getEndTime(), "HH") eq "0">
									end : '#dateFormat(dateAdd("d", 1, calendarEvent.getEndTime()), "yyyy-mm-dd")#T#timeFormat(calendarEvent.getEndTime(), "HH:mm:ss")#',
								<cfelse>
									end : '#dateFormat(calendarEvent.getEndTime(), "yyyy-mm-dd")#T#timeFormat(calendarEvent.getEndTime(), "HH:mm:ss")#',
								</cfif>
								allDay : #calendarEvent.getAllDay() eq 1 ? true : false#
							},
						</cfloop>
					</cfif>
				],
				eventColor: '#prc.calendar.getEventColor() neq "" ? prc.calendar.getEventColor() : prc.settings.eventColor#',
				eventTextColor: '#prc.calendar.geteventTextColor() neq "" ? prc.calendar.geteventTextColor() : prc.settings.eventTextColor#'
			});
		});
	</script>
</cfoutput>
