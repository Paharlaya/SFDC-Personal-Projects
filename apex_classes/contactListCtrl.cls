public with sharing class contactListCtrl {
    @AuraEnabled (cacheable = true)
    
    public static List<Contact> getContactList(){
        List<Contact> conList = [select Id,LastName from contact limit 10];
        return conList;
    } 
  
}