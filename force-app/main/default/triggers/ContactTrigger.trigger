trigger ContactTrigger on Contact (before insert , after delete , after undelete ) {
    
    Map<Id,contact> accIds = new Map<Id,Contact>();
    Set<Id> alreadyPrimary = new Set<Id>();
    if(Trigger.isInsert){
        
        for(Contact con : trigger.new){
            if(con.accountid!=null && con.Primary_Contact__c){
                accIds.put(con.accountId , con);
            }
        }
        
        
        if(accIds.size()>0){
            
            List<Account> accounts = [select id, (select id, Primary_Contact__c from contacts where primary_contact__c=true limit 1) from account where Id In: accIds.keySet()];
            
            for(Account ac : accounts){
                Contact con = ac.contacts[0];
                
                if(con!=null){
                   //Trigger.new.adderror('test');
                   accIds.get(ac.id).addError('only one primary');
                }
            }
        }
    }
    /*Map<Id , List<Contact>> accVsConMap = new Map<Id, List<Contact>>();
    list<Account> toUpdate = new List<Account>();
    //Set<I>
    Map<Id , List<Contact>> accVsConMapDelete = new Map<Id, List<Contact>>();
    if(Trigger.isInsert){
        for(COntact con : trigger.new){
            if(con.accountid!=null){
                if(accVsConMap.containsKey(con.accountId)){
                    accVsConMap.get(con.accountId).add(con);
                }
                
                else{
                    accVsConMap.put(con.accountid , new List<COntact>());
                    accVsConMap.get(con.accountId).add(con);
                }
            }
        }
        
        
        if(accVsConMap.keySet()!=null && accVsConMap.keySet().size()>0){
            
            List<Account> acToUpdate = new List<Account>();
            acToUpdate = [select id , number_of_contacts__c from Account where Id In : accVsConMap.keySet()];
            
            for(Account ac : acToUpdate){
                if(ac.number_of_contacts__c == null){
                    ac.number_of_contacts__c = Double.valueOf(accVsConMap.get(ac.id).size());
                }
                else{
                    ac.number_of_contacts__c = ac.number_of_contacts__c + Double.valueOf(accVsConMap.get(ac.id).size());
                }
                
                toUpdate.add(ac);
            }
            
            update toUpdate;
        }
        
        
    }
    
    
    if(trigger.isdelete){
        
        for(Contact con : Trigger.old){
            
            if(con.accountid!=null){
                if(accVsConMapDelete.containsKey(con.accountId)) accVsConMapDelete.get(con.AccountId).add(con);
                else{
                    accVsConMapDelete.put(con.AccountId , new List<contact>());
                    accVsConMapDelete.get(con.AccountId).add(con);
                }
            }
        }
        
          if(accVsConMapDelete.keySet()!=null && accVsConMapDelete.keySet().size()>0){
            
            List<Account> acToUpdate = new List<Account>();
            acToUpdate = [select id , number_of_contacts__c from Account where Id In : accVsConMapDelete.keySet()];
            
            for(Account ac : acToUpdate){
                ac.number_of_contacts__c = ac.number_of_contacts__c - Double.valueOf(accVsConMapDelete.get(ac.id).size());
                toUpdate.add(ac);
            }
            
            update toUpdate;
        }
        
    }*/
    
    
   
    /*List<Account> accToInsert = new List<Account>();
    List<contact> conUpdate = new List<Contact>();
    Map<String,Contact> accnameVsCon = new Map<String, Contact>();
    
    for(Contact con : trigger.new){
        Account acc = new Account();
        
        acc.Name = 'Acc for id' + con.id;
        accnameVsCon.put(acc.Name,con);
         accToInsert.add(acc);
        
    }
    
    if(accToInsert.size()>0){
        insert accToInsert;
    }
    
    
    for(Account accUpdate: accToInsert){
        system.debug('inserted acc ' + accnameVsCon);
        if(accnameVsCon.containsKey(accUpdate.Name)){
            system.debug('it contains');
            accnameVsCon.get(accUpdate.Name).AccountId = accUpdate.id;
            //conUpdate.add(accnameVsCon.get(accUpdate.Name));
        }
    }*/
    
    //update conUpdate;
    /*
     

 system.debug('inside opp trigger');
    Map<Id, List<Opportunity>> totalOp = new map<Id, List<Opportunity>>();
    Set<Id> accToUpdate = new Set<Id>();
    List<Account> accToQuery = new List<Account>();
    List<Account> accTofinalUpdate = new List<Account>();
    for(Opportunity opp : Trigger.new){
        accToUpdate.add(opp.AccountId);
        if(totalOp.containsKey(opp.AccountId)){
            totalOp.get(opp.AccountId).add(opp);
        }
        
        else{
            
            totalOp.put(opp.AccountId , new List<Opportunity>());
            totalOp.get(opp.AccountId).add(opp);
        }
        
    }
    
    accToQuery = [select id,(select id, Amount from opportunities),Total_Opportunities__c from account where Id =: totalOp.keyset()];
    
    for(Account acc : accToQuery){
        
        acc.Total_Opportunities__c = acc.Total_Opportunities__c!= null ? acc.Total_Opportunities__c : 0 + totalOp.get(acc.id).size();
        acc.Total_Opportunities__c = acc.opportunities.size();
        accTofinalUpdate.add(acc);
    }
    
    update accTofinalUpdate;*/
    
}