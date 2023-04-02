public with sharing class AccountContactService {

    public static void updateActiveContacts(Set<Id> accountIds) {
                
        if(accountIds != null && accountIds.size() > 0){
            /**
             * Trying alterate ways to do the same thing as this way fails in bulk testing
             * 
            ContactTriggerHandlerTest.afterInsertHandlerTestBulk  Fail     

            System.DmlException: Insert failed. First exception on row 0; first error: CANNOT_INSERT_UPDATE_ACTIVATE_ENTITY, 
            ContactTrigger: execution of AfterInsert
            caused by: System.QueryException: Aggregate query has too many rows for direct assignment, use FOR loop
            External entry point
            *
            *
            AS we were trying to insert 1000 contacts to a single Account in bulk testing and the subquery was failing due to that
            * 
             * */
            /*
            List<Account> accountsToUpdate = new List<Account>();

            for(Account acc : [SELECT Id, Name, Active_Contacts__c, 
                                            (SELECT Id FROM Contacts WHERE Active__c = true) 
                                            FROM Account 
                                            WHERE Id IN:accountIds]){
                
                // add account records with updated value to accounts to Update
                accountsToUpdate.add(new Account(Id = acc.Id, Active_Contacts__c = acc.Contacts.size()));
            }

            update accountsToUpdate;*/

            // alternate option without using subquery
            Map<Id, Account> accountsMap = new Map<Id, Account>();
            for(AggregateResult ar : [SELECT AccountId, Count(Id) totalActiveContacts
                                        FROM Contact 
                                        WHERE Active__c = true 
                                        AND AccountId IN :accountIds
                                        GROUP BY AccountId]){

                // Now let's process
                Id accId = String.valueOf(ar.get('AccountId'));
                Integer totalActiveContacts = Integer.valueOf(ar.get('totalActiveContacts'));
                accountsMap.put(accId, new Account(Id = accId, Active_Contacts__c = totalActiveContacts));
            }
            
            // iterate over the set of Ids
            // to look for AccountIds that were not assigned any value
            for (Id accId : accountIds) {
                if(!accountsMap.containsKey(accId)){
                    accountsMap.put(accId, new Account(Id = accId, Active_Contacts__c = 0));
                }
            }
            update accountsMap.values();
        }
    }
}
