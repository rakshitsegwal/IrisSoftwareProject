/**
 * @description       : This class is used to request response from OPENAI servers based on user input from the LWC component and displays result on screen.
 * @author            : rakshit.segwal.lwc@gmail.com
 * @group             : 
 * @last modified on  : 01-28-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class ChatGptIntegration {
    private static final string KEY = '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';

    @AuraEnabled
    public  static Object searchAI(String question){
        question = 'write an essay to describe india in 2000 words';
        String reqBody = '{"model": "text-davinci-003","prompt":"'
                +question+
                '","max_tokens": 4000,"temperature": 0,'
                +'"stream": false,"top_p": 0.5}';

        Http http = new Http();
        HttpRequest req = new HttpRequest();

        req.setEndpoint('https://api.openai.com/v1/completions');
        req.setHeader('Authorization', 'Bearer '+String.escapeSingleQuotes(KEY).trim());
            
            req.setTimeout(120000);
            req.setHeader('Content-Type', 'application/json;charset=UTF-8');

        req.setMethod('POST');
        req.setBody(reqBody);

        HttpResponse response = http.send(req);
        system.debug('response-->' + response.getBody());
            return response.getBody();
        

       

    }
}