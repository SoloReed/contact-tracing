public with sharing class CTPersonTriggerHandler {

    public static void beforeInsert(List<Person__c> newRecords) {
        for(Person__c person : newRecords) {
            // Update person status to Green
            person.Health_Status__c = 'Green';
            // Generate unique Token__c
            person.Token__c = CTPersonController.getToken(person.Mobile__c);
        }
    }

    public static void beforeUpdate(List<Person__c> newRecords, Map<Id, Person__c> oldRecordsMap) {
        for(Person__c person : newRecords) {
            // Check if status changed in this transaction
            // Also update Status_Update_Date__c
            if(person.Health_Status__c != oldRecordsMap.get(person.Id).Health_Status__c) {
                person.Status_Update_Date__c = Date.today();
            }
        }
    }

    public static void afterUpdate(List<Person__c> newRecords, Map<Id, Person__c> oldRecordsMap) {
        Set<Id> statusChange = new Set<Id>();
        Set<Id> redStatus = new Set<Id>();
        for(Person__c person : newRecords) {
            // Check if status changed in this transaction
            if(person.Health_Status__c != oldRecordsMap.get(person.Id).Health_Status__c) {
                statusChange.add(person.Id);
            }
            if(person.Health_Status__c == 'Red' && oldRecordsMap.get(person.Id).Health_Status__c != 'Red') {
                redStatus.add(person.Id);
            }
        }

        Set<Id> alreadyProcessed = new Set<Id>();
        alreadyProcessed.addAll(redStatus);

        Set<Id> orangeStatus = new Set<Id>();
        Set<Id> yellowStatus = new Set<Id>();

        List<Person__c> personToUpdate = new List<Person__c>();

        // let's add all cohabitants
        orangeStatus.addAll(CTPersonController.getCohabitants(redStatus, alreadyProcessed));
        // let's add all primaryContacts
        Set<Id> primaryContacts = CTPersonController.getPrimaryContacts(redStatus, alreadyProcessed);
        orangeStatus.addAll(primaryContacts);
        // let's add all neighbours
        yellowStatus.addAll(CTPersonController.getNeighbours(redStatus, alreadyProcessed));
        // let's add all SecondaryContacts
        yellowStatus.addAll(CTPersonController.getSecondaryContacts(primaryContacts, alreadyProcessed));

        for (Id pid : orangeStatus) {
            personToUpdate.add(new Person__c(Id = pid, Health_Status__c = 'Orange'));
        }
        for (Id pid : yellowStatus) {
            personToUpdate.add(new Person__c(Id = pid, Health_Status__c = 'Yellow'));
        }

        if(personToUpdate.size() > 0){
            update personToUpdate;
        }

        List<Location_Tracing__c> locationTraces = CTLocationTracingController.getLocationsByPersonIds(statusChange);
        if(locationTraces != null && locationTraces.size() > 0){
            Set<Id> locationIds = new Set<Id>();
            for (Location_Tracing__c trace : locationTraces) {
                locationIds.add(trace.Location__c);
            }
            CTLocationController.updateRedScore(locationIds);
        }
    }
}