({
    doInit : function(component, event, helper) {

        const headerTitle = component.get("v.headerTitle");

        var actions = [
            { label: 'View', name: 'view' },
            { label: 'Update', name: 'update' }
        ];

        if(headerTitle === "Person View") {
            const columns = [
                {label: 'Name', fieldName: 'Name', type: 'text'},
                {label: 'Phone', fieldName: 'Mobile__c', type: 'text'},
                {label: 'Token', fieldName: 'Token__c', type: 'text'},
                {label: 'Health Status', fieldName: 'Health_Status__c', type: 'text'},
                {label: 'Status Update Date', fieldName: 'Status_Update_Date__c', type: 'date'},
                {label: 'View', type: 'button', initialWidth: 135, typeAttributes: { label: 'View/Update', name: 'view_details', title: 'Click to View Details'}}
            ];
            component.set("v.columns", columns);

        } else {
            const columns = [
                {label: 'Name', fieldName: 'Name', type: 'text'},
                {label: 'Status', fieldName: 'Status__c', type: 'text'},
                {label: 'Pincode', fieldName: 'Pincode__c', type: 'text'},
                {label: 'Address', fieldName: 'Address__c', type: 'text'},
                {label: 'Red Score', fieldName: 'Red_Score__c', type: 'number'},
                {label: 'Status Update Date', fieldName: 'Status_Update_Date__c', type: 'date'},
                {label: 'View', type: 'button', initialWidth: 135, typeAttributes: { label: 'View/Update', name: 'view_details', title: 'Click to View Details'}}
            ];
            component.set("v.columns", columns);

        }
        // get data
        helper.fetchRecentHealthChanges(component);
    },

    handleKeyUp : function(component, event, helper) {
        const isEnterKey = event.keyCode === 13;
        var queryTerm = component.find('enter-search').get('v.value');
        if(!queryTerm) {
            component.set("v.data", component.get("v.initialResponse"));
        }
        if (isEnterKey) {
            component.set("v.issearching", true);

            // get data
            helper.searchRecord(component, queryTerm);
        }
    },

    handleRowAction : function(component, event, helper) {
        const action = event.getParam('action'); // view or update
        const row = event.getParam('row'); // returns the record
        const headerTitle = component.get("v.headerTitle");

        switch (action.name) {
            case 'view_details':
                const appEvent = headerTitle === "Person View" ? $A.get("e.c:CTPersonSelectEvent") : $A.get("e.c:CTLocationSelectEvent");
                appEvent.setParams({
                    recordId : row.Id,
                    status : headerTitle === "Person View" ? row.Health_Status__c : row.Status__c
                });
                appEvent.fire();
                break;
        }
    }
})
