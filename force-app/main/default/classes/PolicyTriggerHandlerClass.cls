public class PolicyTriggerHandlerClass {
    
    //For After Insert Opreation
    Public Static Void PolicyAfterInsert(List<Policy__c> policyList){
        Set<Id> conIds = new Set<Id>();
        for(policy__c eachPolicy: policyList){
            conIds.add(eachPolicy.Related_To_Customer__c);
        }
        List<AggregateResult> contactsWithExpOrClaimedOppties = [SELECT Count(Id)OpptyCount, Related_To_Customer__c 
                                                                 FROM policy__c 
                                                                 WHERE Related_To_Customer__c IN :conIds 
                                                                 AND Status__c IN ('Expired','Surrenered', 'Claimed')
                                                                 GROUP BY Related_To_Customer__c];
        Map<Id, Integer> conHavingExpOrClaimedOppties = new Map<Id, Integer>();
        for(AggregateResult AR : contactsWithExpOrClaimedOppties){
            Id conId = (Id)AR.get('Related_To_Customer__c');
            Integer policyCount = (Integer)AR.get('OpptyCount');
            conHavingExpOrClaimedOppties.Put(conId,policyCount);
        }
        List<Contact> contactList = new List<Contact>();
        for(Id conId: conHavingExpOrClaimedOppties.keyset()){
            contactList.add(new Contact(Id = conId, Related_Deactivated_Policies__c = conHavingExpOrClaimedOppties.get(conId)));
        }
        update contactList;
    }
    
    //For After Update Opreation
    Public Static Void PolicyAfterUpdate(List<Policy__c> policyList, Map<Id, Policy__c> oldPolicyMap){
        Set<Id> conIds = new Set<Id>();
         for(Policy__c eachPolicy : policyList){
            Policy__c oldPolicy = oldPolicyMap.get(eachPolicy.Id);
            if(eachPolicy.Related_To_Customer__c != oldPolicy.Related_To_Customer__c){
                conIds.add(oldPolicy.Related_To_Customer__c);
            }
            conIds.add(eachPolicy.Related_To_Customer__c);
        }
        List<AggregateResult> contactsWithExpOrClaimedOppties = [SELECT Count(Id)OpptyCount, Related_To_Customer__c 
                                                                 FROM policy__c 
                                                                 WHERE Related_To_Customer__c IN :conIds 
                                                                 AND Status__c IN ('Expired','Surrenered', 'Claimed')
                                                                 GROUP BY Related_To_Customer__c];
        Map<Id, Integer> conHavingExpOrClaimedOppties = new Map<Id, Integer>();
        for(AggregateResult AR : contactsWithExpOrClaimedOppties){
            Id conId = (Id)AR.get('Related_To_Customer__c');
            Integer policyCount = (Integer)AR.get('OpptyCount');
            conHavingExpOrClaimedOppties.Put(conId,policyCount);
        }
        List<Contact> contactList = new List<Contact>();
        for(Id conId: conHavingExpOrClaimedOppties.keyset()){
            contactList.add(new Contact(Id = conId, Related_Deactivated_Policies__c = conHavingExpOrClaimedOppties.get(conId)));
        }
        update contactList;
        
    }
    
    //For After Delete Opreation
    Public Static Void PolicyAfterDelete(List<Policy__c> policyList){
        Set<Id> conIds = new Set<Id>();
        for(Policy__c eachPolicy : policyList){
            if(eachPolicy.status__c == 'Expired' || eachPolicy.status__c == 'Claimed' || eachPolicy.Status__c == 'Surrenered'){
                conIds.add(eachPolicy.Related_To_Customer__c);
            }
        }
        List<AggregateResult> contactsWithExpOrClaimedOppties = [SELECT Count(Id)OpptyCount, Related_To_Customer__c 
                                                                 FROM policy__c
                                                                 WHERE Related_To_Customer__c IN :conIds 
                                                                 AND Status__c IN ('Expired','Surrenered', 'Claimed') AND IsDeleted = True
                                                                 GROUP BY Related_To_Customer__c All Rows];
        Map<Id, Integer> conHavingExpOrClaimedOppties = new Map<Id, Integer>();
        for(AggregateResult AR : contactsWithExpOrClaimedOppties){
            Id conId = (Id)AR.get('Related_To_Customer__c');
            Integer policyCount = (Integer)AR.get('OpptyCount');
            conHavingExpOrClaimedOppties.Put(conId,policyCount);
        }
        List<Contact> contactList = [SELECT Id, Related_Deactivated_Policies__c FROM Contact WHERE Id IN :conHavingExpOrClaimedOppties.keyset()];
        for(Contact eachContact: contactList){
            eachContact.Related_Deactivated_Policies__c = eachContact.Related_Deactivated_Policies__c - conHavingExpOrClaimedOppties.Get(eachContact.Id); 
        }
        update contactList;
    }
    
    //For After UnDelete Opreation
    Public Static Void PolicyAfterUnDelete(List<Policy__c> policyList){
        Set<Id> conIds = new Set<Id>();
        for(Policy__c eachPolicy : policyList){
            if(eachPolicy.status__c == 'Expired' || eachPolicy.status__c == 'Claimed' || eachPolicy.Status__c == 'Surrenered'){
                conIds.add(eachPolicy.Related_To_Customer__c);
            }
        }
        List<AggregateResult> contactsWithExpOrClaimedOppties = [SELECT Count(Id)OpptyCount, Related_To_Customer__c 
                                                                 FROM policy__c 
                                                                 WHERE Related_To_Customer__c IN :conIds 
                                                                 AND Status__c IN ('Expired','Surrenered', 'Claimed') AND IsDeleted = False
                                                                 GROUP BY Related_To_Customer__c ALL ROWS];
        Map<Id, Integer> conHavingExpOrClaimedOppties = new Map<Id, Integer>();
        for(AggregateResult AR : contactsWithExpOrClaimedOppties){
            Id conId = (Id)AR.get('Related_To_Customer__c');
            Integer policyCount = (Integer)AR.get('OpptyCount');
            conHavingExpOrClaimedOppties.Put(conId,policyCount);
        }
        List<Contact> contactList = [SELECT Id, Related_Deactivated_Policies__c FROM Contact WHERE Id IN :conHavingExpOrClaimedOppties.keySet()];
        for(Contact eachContact : contactList){
            eachContact.Related_Deactivated_Policies__c = conHavingExpOrClaimedOppties.Get(eachContact.Id);
        }
        update contactList;
    }
}