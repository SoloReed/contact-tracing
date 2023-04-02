public with sharing class ContactTriggerHandler {

    public static void afterInsertHandler(List<Contact> newContacts) {
        Set<Id> accountIds = new Set<Id>();
        for(Contact con : newContacts){
            if(String.isNotBlank(con.AccountId) && con.Active__c == true){
                accountIds.add(con.AccountId);
            }
        }

        AccountContactService.updateActiveContacts(accountIds);
    }

    public static void afterUpdateHandler(List<Contact> newContacts, List<Contact> oldContacts) {
        Set<Id> accountIds = new Set<Id>();
        for(Contact con : newContacts){
            if(String.isNotBlank(con.AccountId) && con.Active__c == true){
                accountIds.add(con.AccountId);
            }
        }
        for (Contact con : oldContacts) {
            if (String.isNotBlank(con.AccountId) && con.Active__c == true) {
                accountIds.add(con.AccountId);
            }
        }

        AccountContactService.updateActiveContacts(accountIds);
    }

    public static void afterDeleteHandler(List<Contact> oldContacts) {
        Set<Id> accountIds = new Set<Id>();
        for(Contact con : oldContacts){
            if(String.isNotBlank(con.AccountId) && con.Active__c == true){
                accountIds.add(con.AccountId);
            }
        }

        AccountContactService.updateActiveContacts(accountIds);
    }

    public static void afterUndeleteHandler(List<Contact> newContacts) {
        Set<Id> accountIds = new Set<Id>();
        for(Contact con : newContacts){
            if(String.isNotBlank(con.AccountId) && con.Active__c == true){
                accountIds.add(con.AccountId);
            }
        }

        AccountContactService.updateActiveContacts(accountIds);
    }
}