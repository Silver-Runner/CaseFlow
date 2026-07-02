public class AsyncApexDemo_BatchApex implements database.batchable<sObject>{
    Public database.querylocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('SELECT id,name, rating,annualrevenue,active__c from Account where rating = null and annualrevenue = null and active__c = null');
    }
    
    Public void execute(Database.BatchableContext bc, List<Account>scope){
        for(Account eachAcc : scope){
            eachAcc.annualrevenue = 0;
            eachAcc.active__C = 'Yes';
        }
        update scope;
    }
    
    Public void finish(Database.BatchableContext bc){
        system.debug('The Batch job execution is over');
    }
}