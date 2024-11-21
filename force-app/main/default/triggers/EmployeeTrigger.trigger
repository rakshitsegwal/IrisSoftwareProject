trigger EmployeeTrigger on Employee__c (after insert, after update, after delete, after undelete) {
    
   /* AggregateResult result = [SELECT MAX(salary__c) maxSalary, MIN(Salary__c) minSalary FROM Employee__c];
    Map<Id, Decimal> firmVsMax = new Map<Id, Decimal>();
    Map<Id, Decimal> firmVsMin = new Map<Id, Decimal>();
    Decimal maxSalary = (Decimal)result.get('maxSalary');
    Decimal minSalary = (Decimal)result.get('minSalary');
    
    system.debug('max initial' + maxSalary);
    system.debug('min initial' + minSalary);
    List<Tech_firm__c> updateList = new List<Tech_Firm__c>();
    
    if (Trigger.isInsert || Trigger.isUpdate) {
        system.debug('first if');
        for (Employee__c ep : Trigger.new) {
            if (ep.Salary__c != null) {
                system.debug('salarynotnull');
                if (ep.Salary__c > maxSalary) {
                    system.debug('salarygreaterthanmax');
                    maxSalary = ep.Salary__c;
                    firmVsMax.put(ep.Tech_Firm__c , maxSalary);
                }
                
                else if(ep.Salary__c < minSalary){
                    system.debug('salarylessthanmin');
                    minSalary = ep.Salary__c;
                    firmVsMin.put(ep.Tech_Firm__c , minSalary);
                }
            }
        }
    }
    
    if(firmVsMax.keySet().size()>0){
        List<Tech_Firm__c> tt = new List<Tech_Firm__c>();
        tt = [select id, max_salary__c from Tech_Firm__c where Id IN: firmvsMax.keyset()];
        
        for(tech_firm__c tUpdate : tt){
            tUpdate.max_salary__c = firmVsMax.get(tUpdate.id);
            updateList.add(tUpdate);
        }
    }
    
    if(firmVsMin.keySet().size()>0){
        List<Tech_Firm__c> tt = new List<Tech_Firm__c>();
        tt = [select id, min_salary__c from Tech_Firm__c where Id IN: firmvsMin.keyset()];
        
        for(tech_firm__c tUpdate : tt){
            tUpdate.min_salary__c = firmVsmin.get(tUpdate.id);
            updateList.add(tUpdate);
        }
    }
    
    if(updateList!=null &&  updateList.size()>0){
        update updateList;
    }*/
    Map<Id,tech_firm__c> updateMap = new Map<id, tech_firm__c>();
    List<AggregateResult> result = [SELECT tech_firm__c techId , MAX(salary__c) maxSalary, MIN(Salary__c) minSalary FROM Employee__c group by tech_firm__c ];
    
    for(AggregateResult ag : result){
        tech_firm__c tt = new tech_firm__c();
        
        tt.Id = (Id)ag.get('techId');
        tt.max_salary__C = (Decimal)ag.get('maxSalary');
        tt.min_salary__c = (Decimal)ag.get('minSalary');
        updateMap.put(tt.Id , tt);
    }
    
    update updateMap.values();
    // You can use maxSalary and minSalary as needed in your trigger logic
}