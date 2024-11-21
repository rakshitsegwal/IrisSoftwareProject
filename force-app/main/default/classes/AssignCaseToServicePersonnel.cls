public with sharing class AssignCaseToServicePersonnel {

    @AuraEnabled(cacheable=true)
    public static List<User> getAvailablePerson(){
        
        return [select id, name , email  from user where On_Duty__c = false];
    }
    
    @AuraEnabled(cacheable=true)
    public static void assignUserToCase(){
        List<User> availableUserList = getAvailablePerson();
        if(availableUserList.size()> 0){
            availableUserList[0].Current_Assignments__c  = availableUserList[0].Current_Assignments__c + 1;
            
            update availableUserList[0];
			          
        }
        
    }
}