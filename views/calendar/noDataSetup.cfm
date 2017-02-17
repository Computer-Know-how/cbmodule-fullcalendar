<cfoutput>
	#renderView( "viewlets/assets" )#
	<div class="row-fluid">
		<div class="span9" id="main-content">
			<div class="box">
				<!--- Body --->
				<div class="body">
					<h3>No Full Calendar tables found</h3>
					#getPlugin( "MessageBox" ).renderMessage( "warning", "There are no tables or data setup for Full Calendar, please install them manually or switch your ORM setting to update in your application CFC and reload ORM" )#
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