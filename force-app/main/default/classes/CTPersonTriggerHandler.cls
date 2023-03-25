public with sharing class CTPersonTriggerHandler {

    public static void beforeInsertHandler(List<Person__c> newRecords) {
        for(Person__c person : newRecords) {
            // Update person status to Green
            person.Health_Status__c = 'Green';
            // Generate unique Token__c
            person.Token__c = CTPersonController.getToken(person.Mobile__c);
        }
    }

    public static void beforeUpdateHandler(List<Person__c> newRecords, Map<Id, Person__c> oldRecordsMap) {
        for(Person__c person : newRecords) {
            // Set Status_Update_Date__c as Current Date if Health_Status__c field's value is updating
            if(person.Health_Status__c != oldRecordsMap.get(person.Id).Health_Status__c) {
                person.Status_Update_Date__c = Date.today();
            }
        }
    }
}