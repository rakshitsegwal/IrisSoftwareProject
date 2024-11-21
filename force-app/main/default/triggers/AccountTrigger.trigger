trigger AccountTrigger on Account (before insert, after update) {
    /*if (Trigger.isBefore && Trigger.isInsert) {
        for (Account acc : Trigger.new) {
            acc.Name = 'Harry';
            //acc.Company_Date__c = System.today();
        }
    }
    
    if (Trigger.isAfter && Trigger.isUpdate) {
        for (Account acc : Trigger.newMap.values()) {
            if (!String.isEmpty(acc.Phone)) {
                acc.DunsNumber = 'Call Center';
            }
        }
        
        update Trigger.newMap.values();
    }*/
}