public class opportunityProductInsight {
    @InvocableMethod(label='get Opportunity Product details for the AI Summary')
    public static List<Response> getOpportunityProducts(List<Request>requests)
    {
        List<Response>responses = new List<Response>();
        try{
            system.debug('entered into the method - getOpportunityProducts ');
            set<Id>oppIds = new set<Id>();
            for(Request req : requests)
            {
                if(req.opportunity != null && req.opportunity.Id != null)
                {
                    oppIds.add(req.opportunity.Id );
                    system.debug('Opportunity sent is '+ req.opportunity.Id );
                }
            }
            if(oppIds.isEmpty())
            {
                system.debug('No Opty Found');
                return responses;
            }
            //if the opty id set is not empty , we will find out the associated opty line item (opty product)
            //		○ Product Name	○ Quantity	○ Unit Price / Sales Price○ List Price○ Total Price		○ Created Date 	○ Description
            //this map would store all opty product against the opty id
            map<Id, List<OpportunityLineItem>> oppProductMap = new  map<Id, List<OpportunityLineItem>>();
            for(OpportunityLineItem oli : [SELECT Id, OpportunityId, Quantity, UnitPrice, TotalPrice, ListPrice, CreatedDate, Description 
                                           FROM OpportunityLineItem
                                           where OpportunityId In :oppIds order by CreatedDate DESC])
            {
                if(!oppProductMap.containsKey(oli.OpportunityId))
                {
                    oppProductMap.put(oli.OpportunityId,new List<OpportunityLineItem>());
                }
                oppProductMap.get(oli.OpportunityId).add(oli);
                system.debug('fetched products for the oppty id'+oli.OpportunityId + '|| Products associated '+oppProductMap  );
            }
            // build a response for each and every oppty
            // 
            for(Id oppId : oppIds )
            {
                system.debug('Processing opty id '+oppId);
                Map<string,object>oppwrapper = new Map<string,object>();
                oppwrapper.put('Id',oppId);
                List<OpportunityLineItem> oliList = oppProductMap.containskey(oppId) ? oppProductMap.get(oppId) : new List<OpportunityLineItem>() ;
            system.debug('number of opty line items found against the opty '+oppId + 'size -'+ oliList.size());

                // convert the olilist to a JSON format so that data can be sent back to the template
                List<Object>productList =  (List<Object>)JSON.deserializeUntyped(JSON.serialize(oliList));
                for(Object product : productList)
                {
                    map<string,object>prodmap = (map<string,object>) product;
                    prodmap.remove('attributes');
                    prodmap.remove('Id');
                    prodmap.remove('OpportunityId');
                }
                oppwrapper.put('products',productList);
                Response resp = new Response();
                resp.prompt = JSON.serializePretty(oppwrapper);
                responses.add(resp);
                system.debug('Added response for opty id '+ oppId);
             }
            system.debug('opty insight fetched successfully');
        }
        catch(exception e)
        {
            system.debug(e.getMessage());
            system.debug(e.getStackTraceString());
        }
        return responses;
    }
    // create a request wrapper
    public class Request
    {
        @InvocableVariable(label='Opportunity' required=true)
        public Opportunity opportunity;
    }
    // create a Response wrapper
    // 
    public class Response
    {
        @InvocableVariable(label='Prompt')
        public string Prompt;
    }
}