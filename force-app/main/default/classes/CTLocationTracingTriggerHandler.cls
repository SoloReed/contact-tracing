public with sharing class CTLocationTracingTriggerHandler {
    
    public static void beforeInsert(List<Location_Tracing__c> newRecords){
        List<Location_Tracing__c> duplicates = CTLocationTracingController.checkDuplicates(newRecords);

        for (Location_Tracing__c trace : duplicates) {
            trace.addError('Duplicate Record Found. Location: ' + trace.Location__c + ' Person: ' + trace.Person__c);
        }
    }
}