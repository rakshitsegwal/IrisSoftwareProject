// ContactController.cls
public with sharing class ContactController {    
    @AuraEnabled(cacheable=true)
    public static List<Account> findContacts(String searchKey) {
        system.debug('input from lwc box-->' + searchKey);
        String key = '%' + searchKey + '%';
        return [
            select name , Rating , website , accountnumber,type,industry,ownership,(select id,name from contacts) from account where Name LIKE :key
            
        ];
    }
}