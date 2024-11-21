public without sharing class traininglwc {
    @AuraEnabled
    public static List<contact> getContactList() {
        return [
            SELECT Id, Name
            FROM Contact
            
            WITH SECURITY_ENFORCED
            LIMIT 10
        ];
    }
}