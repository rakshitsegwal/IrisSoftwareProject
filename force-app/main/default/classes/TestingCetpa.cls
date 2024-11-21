public class TestingCetpa {
    
    
    @AuraEnabled
    public static User UserInfo(){
        
        
        return [select id,Name, Title, Email, MobilePhone, CompanyName from user where id='0055g0000095LX2AAM'];
    }
    
}