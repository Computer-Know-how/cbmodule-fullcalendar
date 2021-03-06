﻿<cfoutput>
	<div id="calendar"></div>

	<div id="eventModal" class="modal fade" tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">Add/Edit Event</h4>
				</div>
				<div class="modal-body">
					<div class="alert alert-danger" id="alertBox" style="display: none;">
						<button type="button" class="close" data-dismiss="alert">&times;</button>
						<span id="alertBoxText"></span>
					</div>

					<div class="form-group">
						<label class="required">Title:</label>
						<input type="text" id="eventTitle" class="form-control required">
					</div>

					<div class="form-group">
						<label>Description:</label>
						<input type="text" id="eventDescription" class="form-control">
					</div>

					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label><i class="fa fa-calendar"></i> Start Date:</label>
								<input type="text" id="eventStartDate" class="form-control date-picker">
							</div>
						</div>

						<div class="col-md-6">
							<div class="form-group">
								<label><i class="fa fa-calendar"></i> End Date:</label>
								<input type="text" id="eventEndDate" class="form-control date-picker">
							</div>
						</div>
					</div>

					<div class="row-fluid">
						<div class="span12">
							<div class="form-group">
								<label style="margin-top: 5px; margin-bottom: 10px;">
									<input type="checkbox" id="allDay" checked style="margin: 0;">
									&nbsp;All Day
								</label>
							</div>
						</div>
					</div>

					<div class="row" id="timeFields">
						<div class="col-md-6">
							<div class="form-group">
								<label><i class="fa fa-clock-o"></i> Start Time:</label>
								<input type="time" id="eventStartTime" class="form-control">
							</div>
						</div>

						<div class="col-md-6">
							<div class="form-group">
								<label><i class="fa fa-clock-o"></i> End Time:</label>
								<input type="time" id="eventEndTime" class="form-control">
							</div>
						</div>
					</div>
					<div class="center event-spinner">
						<i class="fa fa-spin fa-spinner fa-lg fa-2x"></i>
						<h4 id="spinner-text">Saving Event</h4>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="deleteButton"><i class="fa fa-trash"></i> Delete</button>
					<button type="button" class="btn btn-default" id="closeButton" data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-danger" id="saveButton">Save</button>
					<input type="hidden" id="action">
				</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
</cfoutput>
