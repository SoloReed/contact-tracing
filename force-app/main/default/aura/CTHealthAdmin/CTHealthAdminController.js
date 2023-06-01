({
	tabSelectHandler : function(component, event, helper) {
		const selectedTabId = event.getParam("id");
		if(selectedTabId === "person"){
			component.set("v.headerTitle", "Person View");
		} else {
			component.set("v.headerTitle", "Location View");
		}

		const healthHeaderComp = component.find("health-header");
		healthHeaderComp.fetchCount();
	},
	
});