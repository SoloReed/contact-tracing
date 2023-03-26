trigger CTLocationTrigger on Location__c (before insert, after Insert, before update, after update) {

    switch on Trigger.operationType {
        when BEFORE_INSERT {
            CTLocationTriggerHandler.beforeInsert(Trigger.new);
        }
        when BEFORE_UPDATE {
            CTLocationTriggerHandler.beforeUpdate(Trigger.new, Trigger.oldMap);
        }
    }
}