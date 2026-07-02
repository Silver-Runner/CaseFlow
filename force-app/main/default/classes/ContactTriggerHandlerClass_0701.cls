public class ContactTriggerHandlerClass_0701 {
    Public Static Void ContactBeforeUpdate(List<Contact> contactList){
        Set<Id> conIds = new Set<Id>();
        for(Contact eachContact : contactList){
            if(eachContact.Delete_Inactive_Policies__c == True){
                conIds.add(eachContact.Id);
            }
        }
        List<Policy__c> policiesToBeDeleted = [SELECT Id, Related_To_Customer__c 
                                               FROM policy__c 
                                               WHERE Related_To_Customer__c IN :conIds 
                                               AND Status__c IN ('Expired','Surrenered', 'Claimed')];
        if(policiesToBeDeleted.size()>0){
            Delete policiesToBeDeleted;
        }
    }
    
    Public Static Void AfterContactDeletion(List<Contact> contactList){
        Set<Id> accIds = new Set<Id>();
        for(Contact eachCon : contactList){
            accIds.add(eachCon.AccountId);
        }
        List<Account> accWithHotRating = [SELECT Id FROM Account where Id IN :accIds AND (Rating = 'Hot' AND Active__c ='Yes')];
        accIds.Clear();
        for(Account eachAcc : accWithHotRating ){
            accIds.add(eachAcc.Id);
        }
        for(Contact eachCon : contactList){
            if(accIds.Contains(eachCon.AccountId)){
                eachCon.AddError('This Contact cannot be deleted as it is associated with a hot rated active account');
            }
        }
    }
    
    Public Static Void AfterContactInsertion(List<Contact> conList){
        Set<Id> accIds = new Set<Id>();
        for(Contact eachCon : conList){
            accIds.Add(eachCon.AccountId);
        }
        List<AggregateResult> CountOfContact = [SELECT Count(Id)ContactCount ,ACCOUNTID FROM contact where AccountId IN :accIds GROUP BY AccountID];
        Map<Id,Integer> ContactCountMap = new Map<Id, Integer>();
        for(AggregateResult AR : CountOfContact){
            Id accId = (Id)AR.get('ACCOUNTID');
            Integer contactCount = (Integer)AR.get('ContactCount');
            ContactCountMap.put(accId,contactCount);
        }
        List<Account> accountToBeUpdated = new List<Account>();
        for(Id accid : accIds){
            if(ContactCountMap.containsKey(accid)){
                accountToBeUpdated.add(new Account(Id = accid, Number_of_related_Contacts__c = ContactCountMap.get(accid) ));
            }
        }
        update accountToBeUpdated;
    }
}