public class AccountController {
    public void ratedAccount(string rating){
        List<Account> accRecords = [select Id,Name,Rating,AnnualRevenue from Account where Rating = : rating];
        for(Account eachAcc: accRecords){
            system.debug('The AccountId is '+eachAcc.ID +' The Account Name Is '+eachAcc.Name+' The Account Revenue is '+eachAcc.AnnualRevenue);
        }
    }
    
    public integer typeAccount(string type){
        List<AggregateResult> accountCount = [Select count(Id)recCount from Account group By Type having Type = :type];
		integer count = (integer)accountCount[0].get('recCount');
        return count;
    }
    public void returnAccountsContacts(string accountName){
        List<Account> accRecord = [Select Id,Name,(Select FirstName,Email,Is_Active__c from Contacts) from Account where Name = :accountName];
        for(Account eachAcc: accRecord){
            if(eachAcc.Contacts.size()>0){
                for(Contact eachContact: eachAcc.Contacts){
                    system.debug('The Contact Name '+eachContact.FirstName+' The Contact Email '+eachContact.Email+' The Conatct is_Active '+eachContact.Is_Active__c);
                }
            }else{
                system.debug('There are no contacts related to the account '+eachAcc.Name);
            }
        }
    }
}