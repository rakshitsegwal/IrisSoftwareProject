trigger TechFirmHierarchyTrigger on tech_firm__c (before insert, before update) {
    Map<Id, Id> parentMap = new Map<Id, Id>();
    
    // Build a mapping of each tech_firm__c to its immediate parent
    for (tech_firm__c firm : [SELECT Id, Parent_Tech_Firm__c FROM tech_firm__c WHERE Id IN :Trigger.newMap.keySet()]) {
        if (firm.Parent_Tech_Firm__c != null) {
            parentMap.put(firm.Id, firm.Parent_Tech_Firm__c);
        }
    }
    
    // Update the Ultimate_Parent__c field for each tech_firm__c record
    for (tech_firm__c firm : Trigger.new) {
        Set<Id> visited = new Set<Id>();
        Id currentId = firm.Id;
        
        // Perform a recursive lookup to find the ultimate parent
        while (parentMap.containsKey(currentId) && !visited.contains(currentId)) {
            visited.add(currentId);
            currentId = parentMap.get(currentId);
        }
        
        // Update the Ultimate_Parent__c field
        firm.Ultimate_Parent__c = currentId;
    }
}