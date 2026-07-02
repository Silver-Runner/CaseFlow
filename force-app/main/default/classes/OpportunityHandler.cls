public class OpportunityHandler {
    
    @auraenabled(cacheable=true)
    Public static integer getTotalOptyCount(){
        integer totalCount = [SELECT count() FROM Opportunity];
        return totalCount;
    }
    
    @auraenabled(cacheable=true)
    Public Static List<Opportunity> getPageBasedOpportunity(integer vpageSize, integer vpageNumber){
       integer offsetRecords = vpageSize * (vpageNumber - 1);
        return [SELECT Id,Name,stageName,Amount,ExpectedRevenue FROM Opportunity LIMIT :vpageSize OFFSET :offsetRecords];
    }
    
    @auraenabled(cacheable=true)
    Public Static List<Opportunity> diplayAllHigherOpportunities(String SName){
        List<Opportunity> res = [SELECT Id, Name, stageName, Amount FROM Opportunity WHERE stageName = :SName]; 
        return res;
    }
    
    @auraenabled(cacheable=true)
    Public Static List<Opportunity> diplayAllOpportunities(){
        List<Opportunity> res = [SELECT Id, Name, stageName, Amount FROM Opportunity WHERE stageName NOT IN ('Closed Won','Closed Lost')]; 
        return res;
    }

    Public void printOpptyInfo(set<Id> optyIds){
    	List<opportunity>FetchedOpportunities = [Select Id , Name , stageName, Amount 
                                                 from Opportunity 
                                                 where id = :optyIds and Amount > 500000 and stageName <> 'Closed Won']; 
        for(Opportunity eachOppty : FetchedOpportunities){
            system.debug('The Id of the Oppty: '+eachOppty.Id+' The Name of the Oppty is: '+eachOppty.name+' The stageName of the oppty is: '+eachOppty.stageName+' The Amount of the Oppty is: '+eachOppty.amount);
        }
    }
}