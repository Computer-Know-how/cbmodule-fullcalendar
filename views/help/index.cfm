<cfoutput>
#renderView( "viewlets/assets" )#
<!--============================Main Column============================-->
<div class="row-fluid">
	<div class="span9" id="main-content">
		<div class="box">
			<!--- Body Header --->
			<div class="header">
				<i class="fa fa-question fa-lg"></i> Full Calendar Help
			</div>
			<!--- Body --->
			<div class="body" id="mainBody">
				#getPlugin("MessageBox").renderit()#

				<div class="tabbable tabs-left">
					<ul class="nav nav-tabs">
						<li class="active"><a href="##fullCalendarWidget" data-toggle="tab"><i class="fa fa-calendar"></i> Using the Full Calendar widget</a></li>
						<li><a href="##usingGoogleCalendars" data-toggle="tab"><i class="fa fa-google"></i> Using Google calendars</a></li>
						<!--- <li><a href="##usingContentBoxCalendars" data-toggle="tab"><i class="fa fa-magic"></i> Using ContentBox calendars</a></li> --->
					</ul>

					<div class="tab-content">
						<div class="tab-pane active" id="fullCalendarWidget">
							<h4>Tips</h4>
							<ul>
								<li>When adding the Full Calendar widget to a page make sure to set "Cache Page Content: (fast)" and "Cache Page Layout: (faster)" to "No"</li>
								<li>Display calendars on your pages/blog posts by inserting the Full Calendar widget from CKEditor.</li>
								<li>Click the settings button to access global calendar settings. The global settigns will be used unless overridden a specific calendar.</li>
							</ul>
						</div>

						<div class="tab-pane" id="usingGoogleCalendars">
							<h4>Create a Google Calendar API key</h4>
							<ol>
								<li>Go to <a href="https://console.developers.google.com" target="blank">console.developers.google.com</a>.</li>
								<li>On the sidebar on the left click <b>Credentials</b>.</li>
								<li>Click the blue button labeled <b>Create credentials</b>.</li>
								<li>In the menu that drops down select <b>API key</b>.</li>
								<li>Copy the API key from the pop-up box.</li>
								<li>Click the close button on the pop-up box.</li>
							</ol>

							<h4>Get your Google Calendar ID</h4>
							<p><i>Note: This will make your Google Calendar public so anyone can view the events. Only you will be able to edit the events but anyone will be able to view them.</i></p>
							<ol>
								<li>Go to <a href="https://calendar.google.com" target="blank">calendar.google.com</a>.</li>
								<li>Under <b>My calendars</b> in the sidebar, click the arrow to the right of the calendar you would like to use.</li>
								<li>In the menu that drops down select <b>Share this Calendar</b>.</li>
								<li>Check the box labeled <b>Share this calendar with others</b>.</li>
								<li>Check the box labeled <b>Make this calendar public</b>.</li>
								<li>Click on the selection box to the right of where it says <b>Make this calendar public</b>.</li>
								<li>Select the option labeled <b>See all event details</b>.</li>
								<li>Click on the tab labeled <b>Calendar Details</b> near the top of the page.</li>
								<li>In the <b>Calendar Address</b> section, copy the text next to <b>Calendar ID:</b> (without the ending parenthesis).</li>
							</ol>
						</div>

						<!--- <div class="tab-pane" id="usingContentBoxCalendars">
						</div> --->
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