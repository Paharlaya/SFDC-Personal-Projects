public class SalesforceConnect {

    public static void getCasesFromOrgB(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:Playground101/services/apexrest/Cases');
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        system.debug(response.getStatusCode());
        
       if(response.getStatusCode() == 200){
          List<Object> results = (List<Object>) JSON.deserializeUntyped(response.getBody());
          for(Object result:results){
              Map<String, Object> caseProps = (Map<String,Object>) result;
               System.debug('CaseNumber: ' +caseProps.get('CaseNumber') + 'Subject: ' +caseProps.get('Subject'));
           }
           System.debug('response :' +response.getBody());
           System.debug('RESULTSSSS : : : : : : ' +results);
          
    }       
          
        }
    
    public static void createCaseOrgB(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:Playground101/services/apexrest/Cases');
        request.setMethod('POST');
        request.setHeader('Content-Type','application/json;charset=UTF-8');
        request.setBody('{"subject":"Yash bhai Chad","status":"New","origin":"Web","priority":"High"}');
        
        
        HttpResponse response = http.send(request);
        
        system.debug('response code :' +response.getStatusCode());
        
        if(response.getStatusCode() == 200){
            System.debug(response.getBody());
        }
        
        
    }
         
}