public class AsyncApexDemo_ScheduleableApex implements schedulable {
	
    Public Void execute(SchedulableContext sc){
        List<Case> caseList = [SELECT Id FROM case where status = 'Waiting for the Customer'];
        
        for(Case eachCase : caseList){
			eachCase.description = 'The case updated by scheduable apex';
            eachCase.Status = 'Closed';
        }
        Update caseList;
    }
    
}