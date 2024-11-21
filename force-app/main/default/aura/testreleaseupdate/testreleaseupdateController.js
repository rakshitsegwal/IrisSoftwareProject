({
    doInit : function(component, event, helper) {
        var action = component.get("c.fetchAccounts");
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state == 'SUCCESS') {
                console.log('records-->' + JSON.stringify(response.getReturnValue()));
            }
        });
        $A.enqueueAction(action);
    }
})