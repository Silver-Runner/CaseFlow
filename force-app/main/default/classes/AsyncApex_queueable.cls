public class AsyncApex_queueable implements queueable {
	
    Public Void execute(QueueableContext QC){
        List<Account> accList = [Select id,name,description from Account where annualrevenue > 500000];
        for(Account acc : accList){
            acc.description = 'record updated by queueable apex';
        }
        update accList;
    }
    
}