public  class AccountController {
     
    @AuraEnabled
    public static List<user> fetchAccounts(){
        return [SELECT division,email, Name, username FROM User where id='0055g0000095LX2AAM'];
        	
          //  return [SELECT division, Name, username FROM User where username='servicetestuser9989@gmail.com'];
    }
}