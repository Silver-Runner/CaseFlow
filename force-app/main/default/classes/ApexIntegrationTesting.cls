public class ApexIntegrationTesting {
    public static List<RestObjectWrapper> getObjects(){
        HTTP httpReq = new HTTP();
        HTTPRequest req = new HTTPRequest();
        req.setEndpoint('https://api.restful-api.dev/objects');
        req.setHeader('Content-Type','application/json');
        req.setMethod('GET');
        HTTPResponse res = httpReq.send(req);
        if(res.getStatusCode() == 200){
            List<RestObjectWrapper> responseObj = (List<RestObjectWrapper>)JSON.deserialize(res.getBody(), List<RestObjectWrapper>.class);
            return responseObj;
        }else{
            system.debug('Error: '+res.getStatus());
            return new List<RestObjectWrapper>();
        }
    }
    
    public static RestObjectWrapper CreateObject(RestObjectWrapper requestObj){
        HTTP http = new HTTP();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.restful-api.dev/objects');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        String requestBody = JSON.serialize(requestObj);
        req.setBody(requestBody);
        try {
            HttpResponse res = http.send(req);
            if (res.getStatusCode() == 200 || res.getStatusCode() == 201) {
               RestObjectWrapper responseObj = (RestObjectWrapper) JSON.deserialize(res.getBody(),
                        							RestObjectWrapper.class);
                return responseObj;
            } else {
                throw new CalloutException('POST failed. Status: ' + res.getStatusCode());
            }
        } catch (Exception e) {
            throw new CalloutException('Callout exception: ' + e.getMessage());
        }  
    }
    
    public static RestObjectWrapper editObject(String id, RestObjectWrapper requestObj){
        HTTP http = new HTTP();
        HTTPRequest req = new HTTPRequest();
        req.setEndpoint(' https://api.restful-api.dev/objects/'+id);
        req.setHeader('Content-Type','application/json');
        req.setMethod('PUT');
        String reqBody = JSON.serialize(requestObj);
        req.setBody(reqBody);
        try {
            HttpResponse res = http.send(req);
            if (res.getStatusCode() == 200 || res.getStatusCode() == 201) {
               RestObjectWrapper responseObj = (RestObjectWrapper) JSON.deserialize(res.getBody(),
                        							RestObjectWrapper.class);
                return responseObj;
            } else {
                throw new CalloutException('PUT failed. Status: ' + res.getStatusCode());
            }
        } catch (Exception e) {
            throw new CalloutException('Callout exception: ' + e.getMessage());
        } 
    }
    
    public static RestObjectWrapper deleteObject(String Id){
        HTTP http = new HTTP();
        HTTPRequest req = new HTTPRequest();
        req.setEndpoint('https://api.restful-api.dev/objects/'+id);
        req.setMethod('DELETE');
        try{
            HTTPResponse res = http.send(req);
            if (res.getStatusCode() == 200 || res.getStatusCode() == 201) {
               RestObjectWrapper responseObj = (RestObjectWrapper) JSON.deserialize(res.getBody(),
                        							RestObjectWrapper.class);
                return responseObj;
            } else {
                throw new CalloutException('DELETE failed. Status: ' + res.getStatusCode());
            }
        }catch(Exception e){
            throw new CalloutException('Callout exception: '+ e.getMessage());
        }
    }
}