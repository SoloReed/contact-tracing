/**
 * CTLocationTracingController
 * Main controller class for Location_Tracing__c object
 * @author SoloReed
 */
public with sharing class CTLocationTracingController {

    /**
     * Search Location_Tracing__c Records matching locationId parameter value
     * @return List<Location_Tracing__c> records
     */
    public static List<Location_Tracing__c> getVisitors(String locationId){
        return [SELECT Id, Name, Person__c, Location__c, Visit_Date__c 
                    FROM Location_Tracing__c 
                    WHERE Location__c =:locationId
                    ORDER BY Visit_Date__c DESC];
    }

    /**
     * Search Location_Tracing__c records where Person Id matches personIds
     * Visit Date is in last 10 days
     * @return List<Location_Tracing__c> records
     */
    public static List<Location_Tracing__c> getLocationsByPersonIds(Set<Id> personIds){
        return [SELECT Id, Name, Person__c, Location__c, Visit_Date__c 
                    FROM Location_Tracing__c 
                    WHERE Person__c IN :personIds 
                        AND Visit_Date__c = LAST_N_DAYS:10];
    }

    /**
     * Search Location_Tracing__c records where Location Id matches locationIds
     * AND Person health is green
     * Also Visit date is in last 10 days
     * @return List<Location_Tracing__c> records
     */
    public static List<Location_Tracing__c> getLocationsByLocationIds(Set<Id> locationIds){
        return [SELECT Id, Name, Person__c, Location__c, Visit_Date__c 
                    FROM Location_Tracing__c 
                    WHERE Location__c IN :locationIds
                        AND Person__r.Health_Status__c = 'Green'
                        AND Visit_Date__c = LAST_N_DAYS:10];
    }

}