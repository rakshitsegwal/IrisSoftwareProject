public class SpoonacularApi {
    
    @AuraEnabled
    public static String getRandomRecipe(){
        Map<String, String> stageNameToLabelMap = new Map<String, String>();
        
        // Get the Opportunity object's Describe result
        Schema.DescribeSObjectResult opportunityDescribe = Opportunity.SObjectType.getDescribe();
        
        // Get the field describe for StageName
        Schema.DescribeFieldResult stageNameFieldDescribe = opportunityDescribe.fields.getMap().get('StageName').getDescribe();
        
        // Get the picklist values
        List<Schema.PicklistEntry> picklistValues = stageNameFieldDescribe.getPicklistValues();
        
        // Populate the map with API names and labels
        for (Schema.PicklistEntry picklistEntry : picklistValues) {
            stageNameToLabelMap.put(picklistEntry.getValue(), picklistEntry.getLabel());
        }
        
        /* Http h = new http();

HttpRequest hReq = new HttpRequest();
hReq.setMethod('GET');
hReq.setEndpoint('https://api.spoonacular.com/recipes/random?apiKey=5dc1c9fe94e3440d93b52adce2d7df2b');

HttpResponse hRes = new HttpResponse();

hRes = h.send(hReq);


if(hRes.getStatusCode() == 200){
system.debug('gotresult');

Map<String,Object> resMap = (Map<String, Object>) JSON.deserializeUntyped(hRes.getBody());
List<Object> recipeList = (List<Object>) resMap.get('recipes');
Map<String , Object> recipeMap = (Map<String , Object>) recipeList[0];

String title = (String) recipeMap.get('title');
boolean isVeg = (boolean) recipeMap.get('vegetarian');
system.debug('isVeg->' + isVeg);
system.debug('title->' + title);


}
return hRes.getBody();*/
        
        try{
            Account acc = new Account();
            acc.name='from rakshit';
            insert acc;
            
            return null;
        }
        
        catch(exception ex){
            return ex.getMessage();
        }
        
    }
    
    public static List<User> sortUsersByUsername(List<User> userList) {
        // Create a map to store the usernames as keys and their associated users as values
        Map<String, User> usernameToUserMap = new Map<String, User>();
        
        // Populate the map with usernames as keys
        for (User u : userList) {
            usernameToUserMap.put(u.name, u);
        }
        
        // Sort the list of usernames
        List<String> sortedUsernames = new List<String>(usernameToUserMap.keySet());
        sortedUsernames.sort();
        
        // Create a list to store the sorted User objects
        List<User> sortedUserList = new List<User>();
        
        // Populate the sortedUserList in the order of sorted usernames
        for (String username : sortedUsernames) {
            sortedUserList.add(usernameToUserMap.get(username));
        }
        
        return sortedUserList;
    }
    
    
}