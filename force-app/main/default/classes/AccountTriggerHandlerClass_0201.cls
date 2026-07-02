public class AccountTriggerHandlerClass_0201 {
    
    Public Static Void beforeAccountInsertion(List<Account> accList){
        for(Account eachAcc : accList){
            if ( eachAcc.AnnualRevenue > 500000 ){
                eachAcc.Rating = 'Hot';
            }else if (eachAcc.AnnualRevenue < 500000 && eachAcc.AnnualRevenue > 200000){
                eachAcc.Rating = 'Warm';
            }else{
                eachAcc.Rating = 'Cold';
            }
            eachAcc.Description = 'Account Updated by Trigger - Before Insert';
            if(eachAcc.AnnualRevenue == null && eachAcc.Active__c == 'Yes'){
                eachAcc.Account_Email__c.addError('The Account Must Be Active For The Accounts With Annual Revenue');
                eachAcc.AnnualRevenue.addError('The Account Must Be Active For The Accounts With Annual Revenue');
            }
            if(eachAcc.Same_As_Billing_Address__c == True){
                eachAcc.ShippingCity = eachAcc.BillingCity;
                eachAcc.ShippingCountry = eachAcc.BillingCountry;
                eachAcc.ShippingCountryCode = eachAcc.BillingCountryCode;
                eachAcc.ShippingGeocodeAccuracy = eachAcc.BillingGeocodeAccuracy;
                eachAcc.ShippingLatitude = eachAcc.BillingLatitude;
                eachAcc.ShippingLongitude = eachAcc.BillingLongitude;
                eachAcc.ShippingPostalCode = eachAcc.BillingPostalCode;
                eachAcc.ShippingState = eachAcc.BillingState;
                eachAcc.ShippingStateCode = eachAcc.BillingStateCode;
                
            }
        }
    }
    
    Public Static Void beforeAccountUpdation(List<Account> accList, Map<Id, Account>accMap){
        for(Account eachAcc : accList){
            Account oldAcc = accMap.get(eachAcc.id);
            if((eachAcc.Active__c == 'No') && (oldAcc.Active__c == null)){
                eachAcc.addError('Sorry The Account Can Not Be Deactivated If It Was Not Activated');
            }
            if(eachAcc.Active__c != 'Yes'){
                eachAcc.Description = 'The Record Got Updated By The Before Update Trigger';
            }
            if(eachAcc.Same_As_Billing_Address__c == True){
                eachAcc.ShippingCity = eachAcc.BillingCity;
                eachAcc.ShippingCountry = eachAcc.BillingCountry;
                eachAcc.ShippingLatitude = eachAcc.BillingLatitude;
                eachAcc.ShippingLongitude = eachAcc.BillingLongitude;
                eachAcc.ShippingPostalCode = eachAcc.BillingPostalCode;
                eachAcc.ShippingState = eachAcc.BillingState;
                eachAcc.ShippingStreet = eachAcc.BillingStreet;
                eachAcc.ShippingStateCode = eachAcc.BillingStateCode;
            }else{
                eachAcc.ShippingCity = null;
                eachAcc.ShippingCountry = null;
                eachAcc.ShippingLatitude = null;
                eachAcc.ShippingLongitude = null;
                eachAcc.ShippingPostalCode =  null;
                eachAcc.ShippingState = null;
                eachAcc.ShippingStreet = null;
                eachAcc.ShippingStateCode = null;
            }
        }
        Set<Id> accIds = new Set<Id>();
        for(Account eachAcc: accList){
            accIds.add(eachAcc.Id);
        }
        List<AggregateResult> opptyCountWithAccId = [SELECT count(Id)OpptyCount, AccountId FROM Opportunity WHERE AccountId IN :accIds AND stagename NOT IN ('Closed Won', 'Closed Lost') GROUP BY AccountId];
        Map<Id, Integer> accWithOpenOppty = new Map<Id, Integer>();
        for(AggregateResult AR: opptyCountWithAccId){
            Id AccId = (Id)AR.get('ACCOUNTID');
            Integer opptyCount = (Integer)AR.get('OpptyCount');
            accWithOpenOppty.Put(AccId,OpptyCount);
        }
        for(Account eachAcc: accList){
            if(accWithOpenOppty.containskey(eachAcc.Id) && eachAcc.Active__c =='No'){
                eachAcc.addError('Sorry The Account With Open Opportunity Cannot Be Deactivated');
            }
        }
        Map<Id,String> OpptySumMap = new Map<Id, String>();
        List<AggregateResult> ARs = [SELECT SUM(Amount)TotalAmount, AccountId from Opportunity WHERE AccountId IN :accIds GROUP BY AccountId];
        for(AggregateResult AR : ARs){
            Id accId = (Id)AR.get('AccountId');
            Double opptySum = (Double)AR.get('TotalAmount');
            OpptySumMap.Put(accID, String.valueOf(opptySum));
        }
        for(Account eachAccount : accList){
            if(OpptySumMap.ContainsKey(eachAccount.Id)){
                eachAccount.TotalAmount_For_Active_Opportunity__c = OpptySumMap.Get(eachAccount.Id);
            }
        }
    }
    
    Public Static Void afterAccountInsertion(List<Account> accList){
        List<Task> taskToCreate = new List<Task>();
        for(Account eachAcc : accList){
            Task T1 = new Task(Subject='Get the agreement signed by contact', ActivityDate = system.today() + 3 , Status = 'New', Priority = 'High', OwnerId = eachAcc.ownerId
                               ,whatid = eachAcc.Id);
            taskToCreate.add(T1);
        }
        insert taskToCreate;
    }
    
    Public Static Void afterAccountUpdation(List<Account> accList){
        Set<Id>AccIds = new Set<Id>();
        List<Contact> ContactsToBeDeactivated = new List<Contact>();
        
        //Build a set of ids by iterating over each acc which is begin deactivated
        for(Account eachUpdatedAcc : accList){
            if(eachUpdatedAcc.Active__c != 'Yes'){
                AccIds.add(eachUpdatedAcc.Id);
            }
        }
        system.debug('The Account Ids of the acc got deactivated'+AccIds);
        List<Contact>ConToBeDeactivated = [SELECT id, is_Active__c FROM Contact WHERE AccountId in :AccIds];
        for(Contact con : ConToBeDeactivated){
            con.is_Active__c = False;
            
        }
        Update ConToBeDeactivated;
    }
    
}