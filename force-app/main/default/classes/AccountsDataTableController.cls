public with sharing class AccountsDataTableController {
    
    private static final List<FieldsWrapper> FIELDLIST = getfieldsToShow(); //declared final as it will be set only once.
    
    //initial method to fetch latest account records.
    @AuraEnabled
    public static DataTableWrapper getAllAccountData(){
        try{
            if(FIELDLIST.isEmpty()){
                throw new AuraHandledException('Please Specify Columns in the custom metadata to process the table');
            }
            String queryString = 'Select '+FIELDLIST[0].queryString+' FROM Account';
            List<Account> allAccounts = new List<Account>();
            allAccounts = Database.query(queryString);
            if(allAccounts.isEmpty()){
                return null;
            }
            else{
                DataTableWrapper dtW = new DataTableWrapper();
                dtW.accountData = allAccounts;
                dtW.columnInfo = FIELDLIST;
                return dtW;
            }
        }
        catch(Exception e){
            throw new AuraHandledException('Some Internal Error Occured While Fetching the Accounts');
        }
    }
    
    //method to update any records that came via inline edit.
    @AuraEnabled
    public static void updateAccountData(List<Account> modifiedRec) {
        try {
            Database.update(modifiedRec, false); //set false in order to do partial updates on the recrods that did not errored out.
        } catch (Exception e) {
            throw new AuraHandledException('Some Internal Error Occured While Fetching the Accounts');
        }
    }
    
    //method to set columns dynamically based on the custom metadata named Accounts_Data_Table_Fields__mdt. Gives Ability to add or remove fields from table.
    public static List<FieldsWrapper> getfieldsToShow(){
        Map<String, Accounts_Data_Table_Fields__mdt> mapEd = Accounts_Data_Table_Fields__mdt.getAll();
        Map<String,Schema.SObjectField> mfields = Schema.Account.SObjectType.getDescribe().fields.getMap();
        List<FieldsWrapper> allFieldsWrap = new List<FieldsWrapper>();
        List<String> fieldsList = new List<String>();
        String returnedFields = '';
        
        for(String nameEmailDomain : mapEd.keySet()){
            returnedFields = mapEd?.get(nameEmailDomain)?.Account_Fields__c;
            fieldsList.addAll(returnedFields?.split(','));
            if(!fieldsList.isEmpty()){
                break;
            }
        }
        
        for(String myField : fieldsList){
            FieldsWrapper fW = new FieldsWrapper();
            fW.queryString = returnedFields;
            fW.columnName = mfields.get(myField).getDescribe().getLabel();
            fW.columnApiName = myField;
            allFieldsWrap.add(fW);
        }
        return allFieldsWrap;
    }
    
    //wrapper to hold the whole table info.
    public class DataTableWrapper{
        @AuraEnabled public List<FieldsWrapper> columnInfo{get;set;}
        @AuraEnabled public List<Account> accountData{get;set;}
    }
    
    //wrapper to hold fields related info.
    public class FieldsWrapper{
        @AuraEnabled public String columnName{get;set;}
        @AuraEnabled public String columnApiName{get;set;}
        @AuraEnabled public String queryString{get;set;}
    }
}