public class FormRegistrationController {
    
    @AuraEnabled
    public static String insertFormInfo(String Name , String Experience , String Phone){
        
        List<Form_Registration__c> alreadyExistinRecord = new List<Form_Registration__c>();
        alreadyExistinRecord =[select id from Form_Registration__c where Phone_Number__c =: Phone];
        
        
        if(String.isNotBlank(Name) && String.isNotBlank(Experience) && String.isNotBlank(Phone) && alreadyExistinRecord.size() == 0){
            
            Form_Registration__c fR = new Form_Registration__c();
            fR.Name_Of_User__c = Name;
            fR.Level_Of_User__c = Experience;
            fR.Phone_Number__c = Phone;
            
            insert fR; 
            return fR.id;    
        }
        
        else
        {
            return 'Duplicate;' + alreadyExistinRecord[0].id;    
        }
            
    }
}