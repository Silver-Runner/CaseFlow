public class opportunityRevenue {
	@InvocableMethod(label='Opportunity Total Revenue')
    public Static List<revenueReponse> getTotalRevenue(List<revenueRequest> request){
        List<revenueReponse> response = new List<revenueReponse>();
        for(revenueRequest req : request){
            AggregateResult AR = [SELECT SUM(Amount)OpptySum FROM Opportunity WHERE AccountId=:req.accountId];
            Decimal opptySum = (Decimal)AR.get('OpptySum');
            revenueReponse res = new revenueReponse();
            res.total_oppty_revenue = 'Total Opportunity Revenue For Account '+opptySum;
            response.add(res);
        }
        return response;
    }
    Public Class revenueRequest{
        @InvocableVariable(required=true)
        Public Id accountId;
    }
    Public Class revenueReponse{
        @InvocableVariable
        Public String total_oppty_revenue;
    }
}