trigger OppLineItemTrigger on OpportunityLineItem (after insert) {
    
   /*Set<Id> parentOp = new Set<Id>();
    
    for(OpportunityLineItem opl : trigger.new){
        
        if(opl.OpportunityId !=null){
            parentOp.add(opl.OpportunityId);
        }
    }
    
    if(parentOp.size()>0){
        Map<Id,Integer> acVsCountMap = new Map<Id,Integer>();
        List<Opportunity> opList = [select id,AccountId, (select id, ListPrice from OpportunityLineItems where ListPrice > 30000) from opportunity where Id In: parentOp];
        
        for(Opportunity op : opList){
            List<OpportunityLineItem> opline = op.OpportunityLineItems; 
            
            if(opLine.size()>0){
                acVsCountMap.put(op.accountid, opline.size());
            }
        }
        
        if(acVsCountMap!=null){
            
            List<Account> acToUpdate = new List<Account>();            
            List<Account> acList = [select id,Total_Line_items__c from account where Id In: acVsCountMap.keySet()];
            
            for(Account ac : acList){
                ac.Total_Line_items__c = acVsCountMap.get(ac.Id);
                acToUpdate.add(ac);
            }
            update acToUpdate;
        }
        
        
    }*/
    
    //aashna start
    Set<Id> oppSet= new Set<Id>();
    List<Id> accList = new List<Id>();
    List<Account> accountList = new List<Account>();
    
   /*   for(OpportunityLineItem oLine: Trigger.new){
        if(oLine.OpportunityId!=null){
            oppSet.add(oLine.OpportunityId);
        }
    }
    system.debug('oppSet-->' +oppSet);
    if(oppSet!=null){
    for(Opportunity opp: [select Id, AccountId from Opportunity where Id IN: oppSet]){
        accList.add(opp.AccountId);
    }
    }
    
    system.debug('accList-->' +accList);
    if(accList!=null){
    for(Account a: [Select Id, Product_Range__c from Account where Id IN: accList]){
        system.debug('account-->' +a);
        if(a.Product_Range__c == null){
            a.Product_Range__c=1;
        }
        else{
        a.Product_Range__c = a.Product_Range__c +1;
        }
        accountList.add(a);
    }
    }
    update accountList; */
    
    Map<Id, decimal> m = new map<Id, decimal>();
    Map<Id, Id> m1 = new map<Id, Id>();
     List<Account> acList = new List<Account>();
    for(OpportunityLineItem oLine: Trigger.new) {
        if(oLine.OpportunityId!=null){
            oppSet.add(oLine.OpportunityId);
        }
    } 
    AggregateResult agr = [select count(id) c, OpportunityId from OpportunityLineItem where OpportunityId in: oppSet group by OpportunityId];
    m.put((Id) agr.get('OpportunityId'), (Decimal) agr.get('c'));
    List<Opportunity> o= [select id, accountId from opportunity where id in: oppSet];
    
    for(opportunity op: o){
        accList.add(op.accountId);
        m1.put(op.Id, op.AccountId);
    }
    for(Id i: m.keySet()){
        if(m1.containsKey(i)){
            account a= new account(id= m1.get(i), Total_Line_items__c = m.get(i));
            acList.add(a);
        }
    }
    update acList;
    //aashna end
}