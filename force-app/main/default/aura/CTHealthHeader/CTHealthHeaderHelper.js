({
    fetchStatusCount : function(component) {
        const headerTitle = component.get("v.headerTitle");
        // create apex method call action
        const action = headerTitle === "Person View" ? component.get("c.getPersonHealthStatusCount") : component.get("c.getLocationHealthStatusCount");
        // set parameters : no parameters needed in this case

        // define a callback
        action.setCallback(this, function(response) {
            const state = response.getState();
            if(state === "SUCCESS"){
                component.set("v.count", response.getReturnValue());
            }
        });
        // call apex method
        $A.enqueueAction(action);
    },
});
