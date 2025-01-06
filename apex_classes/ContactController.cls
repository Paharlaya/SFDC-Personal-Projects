public with sharing class ContactController{

    @AuraEnabled(cacheable = true)
    public static List<Contact> getContacts (String accId){

        try {
            return [
                SELECT AccountId,Id,FirstName,LastName,Phone FROM Contact WHERE AccountId =:accId
                WITH SECURITY_ENFORCED
            ];

            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    //code for lmsRelatedContacts component using LMS//


    @AuraEnabled(cacheable=true)
    public static List<Contact> getRelatedContactsByFilter(Id accountId,String key){
        String query='select Id,Name, Phone, Email from Contact where AccountId=:accountId and Name like \'%'+key+'%\'';
        return Database.query(query);
    }


}