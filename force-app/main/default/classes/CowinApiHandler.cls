global with sharing class CowinApiHandler {
    
    global static void getOTP(String mobileNumber){

        Http http = new Http();

        HttpRequest hReq = new HttpRequest();

        hReq.setendPoint('https://cdn-api.co-vin.in/api/v2/auth/public/generateOTP');
        hReq.setMethod('POST');
        hReq.setHeader('Content-Type', 'application/json;charset=UTF-8');
        // Set the body as a JSON object
        hReq.setBody('{"mobile":mobileNumber}');

        HttpResponse response = http.send(hReq);

    System.debug('response---->' + response.getBody());

    }

}