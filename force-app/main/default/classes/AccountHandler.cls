public class AccountHandler {
	@auraenabled(cacheable=true)
    Public Static list<Account> getAllAccount(){
		list<Account> resultData = [SELECT Id, Name, AnnualRevenue,Active__c FROM Account];
        return resultData;
    }
}