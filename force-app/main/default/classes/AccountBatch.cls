global class AccountBatch implements Database.Batchable<sObject>
{
    global Integer recordsProcessed = 0;
    global List<contact> conToUpdate = new List<contact>();
    global database.QueryLocator start(Database.BatchableContext bc){
String query = 'select id,shippingstreet,shippingcity, shippingstate,shippingpostalcode,shippingcountry from account';

        return database.getQueryLocator(query);
    }
    //not sure why my query is not getting result as time is less but code is completed.
    global void execute (database.BatchableContext bc , List<account> accToUpdate){
        
        /*for(account  acc : accToUpdate){
            
            if(acc.contacts.size() > 0 ){
                
                for(contact con : acc.contacts){
                    
                    con.mailingstreet = acc.shippingstreet;
                    con.mailingcity = acc.shippingcity;
                    con.mailingstate = acc.shippingstate;
                    con.mailingpostalcode = acc.shippingpostalcode;
                    con.mailingcountry = acc.shippingcountry;
                    recordsProcessed = recordsProcessed+1;
                    conToUpdate.add(con);
                }
                
            }
        }
        
        if(contoupdate.size()>0){
            update contoupdate;
        }*/
    }
    
    global void finish(database.BatchableContext bc){
        system.debug('inside finish');
        //checkBatchCall();
        //database.executeBatch(new AccountBatch(), 100);
        AsyncApexJob job = [select id from AsyncApexJob where id =: bc.getJobId()];
    }
    
   
    public static void checkBatchCall(){
        system.debug('future called from batch finish');
    }
    
}