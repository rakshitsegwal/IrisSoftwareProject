public with sharing class MyAuraController {
    @AuraEnabled
    public static String getCurrentURL() {
        return System.Url.getCurrentRequestUrl().toExternalForm();
    }
}