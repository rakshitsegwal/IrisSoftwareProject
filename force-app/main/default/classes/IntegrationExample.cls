public with sharing class IntegrationExample {
    public IntegrationExample() {
            //my api key-> AIzaSyAiqCFqiMV7pQQ9SrVcd4rSPiL1j9o2V_o
    }
    
    @AuraEnabled
    public static String getIntegrationData(){
        
        Http http = new Http();
        
        HttpRequest req =new HttpRequest();
        
        req.setEndPoint('https://gorest.co.in/public/v2/users');
        req.setMethod('GET');
        
        HttpResponse response = new HttpResponse();
        
        response = Http.send(req);
        
        
            return response.getBody();
        
    }
}