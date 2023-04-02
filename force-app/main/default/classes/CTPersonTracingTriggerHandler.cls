public with sharing class CTPersonTracingTriggerHandler {
    
    public static void beforeInsert(List<People_Tracing__c> newRecords){

        List<People_Tracing__c> duplicateRecords = CTPeopleTracingController.checkDuplicates(newRecords);

        if(duplicateRecords != null && duplicateRecords.size() > 0){
            for (People_Tracing__c trace : duplicateRecords) {
                trace.addError('Duplicate People Tracing Record Found. Duplicate Record not allowed.');
            }
        }
    }
}