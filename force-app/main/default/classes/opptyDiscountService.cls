public class opptyDiscountService {
	@InvocableMethod(label='Check Oppty Discount')
    Public Static List<DiscountResponse> checkDiscount(List<discountRequest> request){
        List<DiscountResponse> response = new List<DiscountResponse>();
        string message;
        for(discountRequest req: request){
            opportunity oppty = [SELECT Id,Name, Amount FROM Opportunity WHERE Id =:req.OpportunityId LIMIT 1];
            if(oppty.Amount > 200000){
                message = 'High Value Opportunity';
            }else{
                message = 'Low Value Opportunity';
            }
            discountResponse res = new discountResponse();
            res.result= 'This Opportunity is a'+message;
            response.add(res);
        }
        return response;
    }
    Public Class discountRequest{
        @InvocableVariable(required=true)
        public Id opportunityId;
    }
    Public Class discountResponse{
        @InvocableVariable
        public string result;
    }
    
}