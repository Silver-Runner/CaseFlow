public class opportunitySummaryService {
	@InvocableMethod(label='Opprtunity Summary')
    Public Static List<summaryResponse> getSummary(List<summaryRequest> request){
        List<summaryResponse> response = new List<summaryResponse>();
        for(summaryRequest req: request){
            AggregateResult  AR = [SELECT Count(Id)opptyCount,Sum(Amount)opptySum,
                                   Max(Amount)maxOppty,Avg(Amount)avgAmount,Min(Amount)minOppty 
                                   FROM Opportunity WHERE AccountId=:req.accountId];
            Integer opptyCount = (Integer)AR.get('opptyCount');
            Decimal opptySum = (Decimal)AR.get('opptySum');
            Decimal maxOppty = (Decimal)AR.get('maxOppty');
            Decimal avgOppty = (Decimal)AR.get('avgAmount');
            Decimal minOppty = (Decimal)AR.get('minOppty');
            summaryResponse res = new summaryResponse();
            res.total_Oppty_sum = 'Total Opportunity Sum '+opptySum;
            res.total_Oppty_count = 'Total Opportunity Count '+opptyCount;
            res.avg_oppty_sum = 'Average Opportunity Sum '+avgOppty;
            res.max_oppty = 'Maximum Opportunity '+maxOppty;
            res.min_oppty = 'Minimum Opportunity '+minOppty;
            response.add(res);
        }
        return response;
    }
    
    Public Class summaryRequest{
        @InvocableVariable(required='true')
        Public Id accountId;
    }
    
    Public Class summaryResponse{
        @InvocableVariable
        Public string total_Oppty_sum;
        @InvocableVariable
        Public string total_Oppty_count;
        @InvocableVariable
        Public string avg_oppty_sum;
        @InvocableVariable
        Public string max_oppty;
        @InvocableVariable
        Public string min_oppty;
    }
}