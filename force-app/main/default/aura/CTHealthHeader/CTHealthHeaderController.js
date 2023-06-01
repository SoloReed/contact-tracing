({
    createRecord : function(component, event, helper) {
        const createRecordEvent = $A.get("e.force:createRecord");
        const headerTitle = component.get("v.headerTitle");
        createRecordEvent.setParams({
            "entityApiName": headerTitle === "Person View" ? "Person__c" : "Location__c"
        });
        createRecordEvent.fire();
    },

    doInit : function(component, event, helper) {
        helper.fetchStatusCount(component);
    },
});
