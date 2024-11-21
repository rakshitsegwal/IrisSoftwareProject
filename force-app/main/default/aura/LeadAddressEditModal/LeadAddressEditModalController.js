({
    closeModal: function(component, event, helper) {
        component.get("v.onModalClose").fire();
    }
})