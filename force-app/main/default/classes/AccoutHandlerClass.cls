public class AccoutHandlerClass {
    Public Static Void CheckForActiveContact(List<Account> newAccList){
        set<Id> accIds = new set<Id>();
        for(Account eachAcc: newAccList){
			accIds.add(eachAcc.Id);
        }
        system.debug(accIds);
        List<AggregateResult> ContactCounts = [SELECT Count(Id)ContactCounts, AccountId FROM Contact WHERE Is_Active__c = True AND AccountId In :accIds GROUP BY AccountId];
		Map<Id,Integer> ContactCountMap = new Map<Id,Integer>();
        for(AggregateResult AR : ContactCounts){
            Id accId = (Id)AR.get('AccountId');
            integer ContactCount = (Integer)AR.get('ContactCounts');
            ContactCountMap.put(accId,ContactCount);
        }
        for(Account eachAcc: newAccList){
            if(ContactCountMap.get(eachAcc.Id)>0){
                eachAcc.addError('Account Cannot Be Deactivated As It Has Active Contacts');
            }
        }
    }
}