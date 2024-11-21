({
    onInit: function(component, event, helper) {
        console.log('init called');
        var action = component.get("c.getCurrentURL");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log('value--->' + response.getReturnValue());
                component.set("v.currentURL", response.getReturnValue());
            }
            
            else{
                console.log('error');
            }
        });
        $A.enqueueAction(action);
    }
})