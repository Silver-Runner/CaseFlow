public class SOSL_Handler_14012026 {

	public static List<List<sobject>> fetchDataBasedONString(string queryString) {

        try {

            List<List<sobject>> searchList = [find 'united or edge' returning account(id, name where annualrevenue <> null),

                                             contact (firstname, lastname), opportunity(id,name,stagename)];


            list<Account> accList = (list<Account>)searchList[0];

            list<Contact> conList = (list<Contact>)searchList[1];

            list<Opportunity> optyList = (list<Opportunity>)searchList[2];


            System.debug('Account count matching with the string ' + queryString + ' are ' + accList.size());

            System.debug('Contact count matching with the string ' + queryString + ' are ' + conList.size());

            System.debug('Opportunity count matching with the string ' + queryString + ' are ' + optyList.size());

            for(Account a: accList) {

                System.debug('ar: ' + a.annualRevenue);

            }

            return searchList;

        } 

        catch (Exception e) {

//            system.debug('the exception errorm message is =>'+e.getMessage());

  //          system.debug('the exception errorm message is =>'+e.getLineNumber());

    //        system.debug('the exception errorm message is =>'+e.getStackTraceString());

      //      system.debug('the exception errorm message is =>'+e.getTypeName());

            // system.debug('the exception errorm message is =>'+e.setMessage('dear user add the annualrevenuw in query'));

        //    e.setMessage('dear user add the annualrevenuw in query');

            system.debug('the new exception errorm message is =>'+e.getMessage());

        }

        finally {

            System.debug('Code executed');

        }

        return null;

    }
   	
    Public Static Void PrintingAccountAndLead(String queryString){
        try{
            List<List<sObject>> searchOutput = [FIND :queryString RETURNING Account(Name,Rating,AnnualRevenue where AnnualRevenue > 100000 AND Active__c <> 'False'), Lead(Id,Name,status where status <> 'Closed-Converted')];
            if(searchOutput.Size() > 0){
                List<Account> accList = (List<Account>)searchOutput[0];
                List<Lead> leadList = (List<Lead>)searchOutput[1];
				for(Account eachAcc : accList){
					system.debug('The Account Name '+eachAcc.Name+' The Rating of Account is '+eachAcc.Rating+' The AnnualRevenue Of Account is '+eachAcc.AnnualRevenue);
				}
                                        
				for(Lead eachLead : leadList){
					system.debug('The Lead Id '+eachLead.Id+' The Name of Lead is '+eachLead.Name+' The Status Of Lead is '+eachLead.Status);
				}
            }
        }catch(Exception e){
            system.debug('Error Message'+e.getMessage());
        }
    }

}