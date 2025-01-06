public class UpdateContactMailingAddress implements Database.Batchable<sObject>,Database.Stateful{

    
    public Integer recordCount = 0;
    public database.QueryLocator start (database.BatchableContext bc){
        return database.getQueryLocator(
        	'SELECT Id, BillingStreet,BillingCity,Billingstate,BillingPostalCode,' +
            '(SELECT Id,MailingStreet,MailingCity,Mailingstate,MailingPostalCode FROM Contacts)' +
            'FROM Account WHERE billingCountry = \'USA\''    
        );
    }
    
    public void execute(Database.BatchableContext bc, List<Account> accList){
        
        List<Contact> conList = new List<Contact>();
        
        for(Account acc: accList){
            for(Contact con : acc.Contacts){       //Iterating through realted contact(s)
                con.mailingStreet = acc.BillingStreet;
                con.MailingCity = acc.BillingCity;
                con.MailingState = acc.BillingState;
                con.MailingPostalCode = acc.BillingPostalCode;
                
                conList.add(con);
                
                recordCount++;
            }
        }
        
        if(!conList.isEmpty()){
            update conList;
        }
    }
    
    public void finish (Database.BatchableContext bc){
        System.debug('record Count = ' + recordCount);
    }
    
    
    
    
    
    
    
    
    
}