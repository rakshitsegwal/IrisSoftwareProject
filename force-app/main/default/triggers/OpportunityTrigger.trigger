trigger OpportunityTrigger on Opportunity (after insert ,  after update , after delete , after undelete) {
    /*
   public class NumberFormatter {
    public static String formatNumberWithCommas(String numString) {
        String formattedNumber = '';
        List<String> parts = numString.split('\\.');

        // Format the integer part
        String integerPart = parts[0];
        List<String> integerDigits = integerPart.split('');
        if (integerDigits.size() > 3) {
            Integer commaCounter = 0;
            for (Integer i = integerDigits.size() - 1; i >= 0; i--) {
                if (commaCounter == 3 && i < integerDigits.size() - 1) {
                    formattedNumber = ',' + formattedNumber; // Add a comma
                    commaCounter = 0;
                }
                formattedNumber = integerDigits[i] + formattedNumber;
                commaCounter++;
            }
        } else {
            formattedNumber = integerPart; // No need to format if less than 4 digits
        }

        // Add the decimal part if it exists
        if (parts.size() > 1) {
            formattedNumber += '.' + parts[1];
        }

        return formattedNumber;
    }
}


*/
    
    Map<Id, List<Opportunity>> accVsOpp = new Map<Id, List<Opportunity>>();
    Map<Id, List<Opportunity>> accVsOppUpdateAdd = new Map<Id, List<Opportunity>>();
    Map<Id, List<Opportunity>> accVsOppUpdatesubtract = new Map<Id, List<Opportunity>>();
    Map<Id, List<Opportunity>> accVsOppUpdatedelete = new Map<Id, List<Opportunity>>();
    If(Trigger.isAfter){
        
        
        if(Trigger.isInsert || Trigger.isUndelete){
            
            
            for(Opportunity op : Trigger.new){
                if(op.accountid != null){
                    if(accVsOpp.containsKey(op.AccountId)){
                        accVsOpp.get(op.AccountId).add(op);
                    } 
                    
                    else{
                        accVsOpp.put(op.AccountId , new List<Opportunity>());
                        accVsOpp.get(op.AccountId).add(op);
                    }
                    
                }
            }
        }
        
        if(Trigger.isUpdate){
            
            for(Opportunity op : Trigger.new){
                
                if((Trigger.oldMap.get(op.id).AccountId!= op.AccountId) && op.AccountId!=null){
                    
                    if(accVsOppUpdateAdd.containsKey(op.AccountId)){
                        accVsOppUpdateAdd.get(op.AccountId).add(op);
                        
                    } 
                    
                    else{
                        accVsOppUpdateAdd.put(op.AccountId , new List<Opportunity>());
                        accVsOppUpdateAdd.get(op.AccountId).add(op);
                    }
                    
                    if(accVsOppUpdatesubtract.containsKey(Trigger.oldMap.get(op.id).AccountId)){
                        accVsOppUpdatesubtract.get(Trigger.oldMap.get(op.id).AccountId).add(op);
                        
                    } 
                    
                    else{
                        accVsOppUpdatesubtract.put(Trigger.oldMap.get(op.id).AccountId, new List<Opportunity>());
                        accVsOppUpdatesubtract.get(Trigger.oldMap.get(op.id).AccountId).add(op);
                    }
                    
                }
            }
        }
        
        if(Trigger.isdelete){
            
            for(Opportunity op : Trigger.old){
                if(accVsOppUpdatedelete.containsKey(Trigger.oldMap.get(op.id).AccountId)){
                        accVsOppUpdatedelete.get(Trigger.oldMap.get(op.id).AccountId).add(op);
                        
                    } 
                    
                    else{
                        accVsOppUpdatedelete.put(Trigger.oldMap.get(op.id).AccountId, new List<Opportunity>());
                        accVsOppUpdatedelete.get(Trigger.oldMap.get(op.id).AccountId).add(op);
                    }
            }
        }
        
        if(accVsOppUpdatedelete!=null){
            List<Account> finalAcToUpdate = new List<Account>();
            List<Account> acctoDel = new List<Account>();
            acctoDel = [select id, Total_Opportunities__c  from Account where Id In: accVsOppUpdatedelete.keyset()];
            
            for(Account ac : acctoDel){
                
                if(ac.Total_Opportunities__c!= null){
                    ac.Total_Opportunities__c = ac.Total_Opportunities__c -  accVsOppUpdatedelete.get(ac.id).size();
                }
                /*else{
                  ac.Total_Opportunities__c = accVsOppUpdateAdd.get(ac.id).size();  
                }*/
                
                finalAcToUpdate.add(ac);
            }
            
            if(finalAcToUpdate.size()>0) update finalAcToUpdate;
        }
        if(accVsOppUpdateAdd!=null && accVsOppUpdatesubtract!=null){
            List<Account> finalAcToUpdate = new List<Account>();
            List<Account> acc = new List<Account>();
            List<Account> acctoDel = new List<Account>();
            acc = [select id, Total_Opportunities__c  from Account where Id In: accVsOppUpdateAdd.keyset()];
            acctoDel = [select id, Total_Opportunities__c  from Account where Id In: accVsOppUpdatesubtract.keyset()];
            
            
            for(Account ac : acc){
                
                if(ac.Total_Opportunities__c!= null){
                    ac.Total_Opportunities__c = ac.Total_Opportunities__c +  accVsOppUpdateAdd.get(ac.id).size();
                }
                else{
                  ac.Total_Opportunities__c = accVsOppUpdateAdd.get(ac.id).size();  
                }
                
                finalAcToUpdate.add(ac);
            }
            
            for(Account ac : acctoDel){
                
                if(ac.Total_Opportunities__c!= null){
                    ac.Total_Opportunities__c = ac.Total_Opportunities__c -  accVsOppUpdatesubtract.get(ac.id).size();
                }
                /*else{
                  ac.Total_Opportunities__c = accVsOppUpdateAdd.get(ac.id).size();  
                }*/
                
                finalAcToUpdate.add(ac);
            }
            
            if(finalAcToUpdate.size()>0) update finalAcToUpdate;
        } 
        if(accVsOpp!=null){
            List<Account> finalAcToUpdate = new List<Account>();
            List<Account> acc = new List<Account>();
            acc = [select id, Total_Opportunities__c  from Account where Id In: accVsOpp.keyset()];
            
            
            for(Account ac : acc){
                
                if(ac.Total_Opportunities__c!= null){
                    ac.Total_Opportunities__c = ac.Total_Opportunities__c +  accVsOpp.get(ac.id).size();
                }
                else{
                  ac.Total_Opportunities__c = accVsOpp.get(ac.id).size();  
                }
                
                finalAcToUpdate.add(ac);
            }
            
            if(finalAcToUpdate.size()>0) update finalAcToUpdate;
        } 
    }
    /*map<id,List<opportunity>> accvsopset = new map<id,List<opportunity>>();
List<Account> finalAcUpdate = new List<Account>();
Set<Id> accToUpdate = new Set<Id>();

if(Trigger.isUpdate){

for(Opportunity opp : Trigger.newMap.values()){


if(opp.Amount > trigger.oldmap.get(opp.id).Amount){
accToUpdate.add(opp.AccountId);
}

else if(opp.AccountId != trigger.oldmap.get(opp.id).AccountId){
accToUpdate.add(opp.AccountId);
accToUpdate.add(trigger.oldmap.get(opp.id).AccountId);
}
}

if(accToUpdate.size()>0){
List<Account> acList = new List<Account>();
acList = [select id , (select name, amount from opportunities order by amount desc limit 1) from account where Id In: accToUpdate ];

for(Account ac : acList){


opportunity opp = ac.opportunities[0];
ac.maxOpName__c = opp.Name;
finalAcUpdate.add(ac);
}

update finalAcUpdate;

}
}
if(Trigger.isInsert){
for(Opportunity opp : trigger.new){

if(opp.accountid!=null){
if(accvsopset.containsKey(opp.accountid)) accvsopset.get(opp.accountid).add(opp);

else{
accvsopset.put(opp.accountid , new list<opportunity>());
accvsopset.get(opp.accountid).add(opp);
}
}
}

if(accvsopset.keyset().size()>0){
List<Account> acList = new List<Account>();
acList = [select id , (select name, amount from opportunities order by amount desc limit 1) from account where Id In: accvsopset.keyset() ];

for(Account ac : acList){


opportunity opp = ac.opportunities[0];
ac.maxOpName__c = opp.Name;
finalAcUpdate.add(ac);
}

update finalAcUpdate;
}
}*/
}
/*List<Account> accToQuery = new List<Account>();
List<Account> accTofinalUpdate = new List<Account>();
set<Id> accId = new Set<Id>();
Map<Id, Decimal> accVsTotalAmount = new Map<Id, Decimal>();
boolean isInsert = false;*/
/*
List<contact> contactList = new List<contact> () ;
for (integer i=1;i<=500; i++) {

contactList.add(new Contact(LastName = ' con' +i)) ;

}

//temp
public class userWrap{

String name;
string idtemp;
}
List<userWrap> userWrapList = new List<userWrap>();
// Populate userWrapList with userWrap objects
userWrap uu = new userWrap();
uu.name='rakshit';
uu.idtemp = 'tempId';
userWrapList.add(uu);
List<String> concatenatedStrings = new List<String>();
for (userWrap wrap : userWrapList) {
concatenatedStrings.add(wrap.name + ',' + wrap.idtemp);
}

String abc = String.join(concatenatedStrings, ';'); // Using semicolon as delimiter

system.debug('final-->' + abc);

//tempend
Database.insert(contactList, true); 
List<opportunity> opportunityList = new List<opportunity>() ;
for (integer i=501;i<=50000; i++)
{ opportunityList.add (new Opportunity(name = 'opp'+i)) ; }
insert opportunityList; 
*/
/* if(trigger.isInsert){
isInsert = true;
for(Opportunity opp : trigger.new){

if(opp.AccountId!=null){
accid.add(opp.accountId);
} 

if(accVsTotalAmount.containsKey(opp.AccountId)){
accVsTotalAmount.put(opp.AccountId , opp.Amount + accVsTotalAmount.get(opp.AccountId) );
}

else{
accVsTotalAmount.put(opp.AccountId , opp.Amount);
}

}
}
else{
for(Opportunity opp : trigger.old){

if(opp.AccountId!=null){
accid.add(opp.accountId);
} 

if(accVsTotalAmount.containsKey(opp.AccountId)){
accVsTotalAmount.put(opp.AccountId , opp.Amount + accVsTotalAmount.get(opp.AccountId) );
}

else{
accVsTotalAmount.put(opp.AccountId , opp.Amount);
}

}
}


accToQuery = [select id,TotalOppAmount__c,(select id, Amount from opportunities),Total_Opportunities__c from account where Id =: accid];
system.debug('updatesize-->' + accToQuery.size());
for(Account acc : accToQuery){

// acc.Total_Opportunities__c = acc.Total_Opportunities__c!= null ? acc.Total_Opportunities__c : 0 + totalOp.get(acc.id).size();
if(isInsert){


if(acc.TotalOppAmount__c!=null){
acc.TotalOppAmount__c  = acc.TotalOppAmount__c + accVsTotalAmount.get(acc.id);
}
else{
acc.TotalOppAmount__c  = accVsTotalAmount.get(acc.id);
}

}

else{
acc.TotalOppAmount__c  = acc.TotalOppAmount__c - accVsTotalAmount.get(acc.id);
}

accTofinalUpdate.add(acc);
}

update accTofinalUpdate;
}
*/