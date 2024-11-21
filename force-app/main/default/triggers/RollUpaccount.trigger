trigger RollUpaccount on Contact (after insert ) {
	map<id, List<contact>> accVsconMap =  new Map<id, List<contact>>();
    Set<Id> accIdset = new Set<Id>();
    for(contact con : trigger.new){
        
        system.debug('accid---->' + con.AccountId + 'map----->' + accVsconMap.containsKey(con.accountid));
        if(accVsconMap.containsKey(con.AccountId)){
            accVsconMap.get(con.accountid).add(con);
            
            system.debug('inside contains');
        }
        else{
            accVsconMap.put(con.accountid , new List<contact>());
            accVsconMap.get(con.accountid).add(con);
        }
       
            system.debug('inside not contains' + accVsconMap.keySet());
            
     
        accIdset.add(con.accountid);
        
    } 
    
    /* if(trigger.isInsert) {
        for(Contact Con : trigger.New) {
            if(String.isNotBlank(Con.AccountId)) {
                if(!accVsconMap.containsKey(Con.AccountId)) {
                    accVsconMap.put(Con.AccountId, new List<Contact>());
                }
                accVsconMap.get(Con.AccountId).add(Con); 
                accIdset.add(Con.AccountId);
            }   
        }  
    }*/
    if(accIdset.size()>0){
        List<Account> accToUpdate = [select id , Number_of_Contacts__c  from account where id in:accIdset];
        Integer noOfConts = 0;
            
        List<Account> finalUpdateList = new List<Account>();
        for(Account acc : accToUpdate){
            
            if(accVsconMap.containsKey(acc.Id)) {
                noOfConts += accVsconMap.get(acc.Id).size();
            }
            
            acc.Number_of_Contacts__c  = acc.Number_of_Contacts__c == null ? noOfConts :  acc.Number_of_Contacts__c + noOfConts;
            //finalUpdateList.add(acc);
        }
        
        update accToUpdate;
    }
}