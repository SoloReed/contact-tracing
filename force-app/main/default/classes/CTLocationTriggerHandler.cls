public with sharing class CTLocationTriggerHandler {

    public static void beforeInsert(List<Location__c> newRecords){
        for (Location__c location : newRecords) {
            // Set Status to Green
            location.Status__c = 'Green';
        }
    }

    public static void beforeUpdate(List<Location__c> newRecords, Map<Id, Location__c> oldRecordsMap){
        for (Location__c location : newRecords) {
            // Check is Status has changed in this transaction
            // Update Status_Update_Date__c
            if (location.Status__c != oldRecordsMap.get(location.Id).Status__c) {
                location.Status_Update_Date__c = Date.today();
            }
        }
    }
}