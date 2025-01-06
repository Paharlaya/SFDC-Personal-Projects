public class AccountTriggerHandler {
   
	//Logic 1:If industry is media or energy then Rating  = Hot    
  public static void updateRating(List<Account> accList, Map<Id,Account> oldMap){

        for(Account acc : accList){
            if((oldMap == null && acc.Industry != null && acc.Industry == 'Media') || 
               (oldMap != null && acc.Industry == 'Media' && oldMap.get(acc.id).Industry != acc.Industry)) {
                acc.Rating = 'Hot';
            }
        }
}
    //Logic 2: Copy Billing address to Shipping address if Checkbox is checked && LOGIC  6 (UPDATE)
    public static void copyBillingToShipping(List<Account> accList, Map<Id,Account> oldMap){
        for(Account acc:accList) {
            if((acc.CopyBillingToShipping__c == true && oldMap == null) ||
               (acc.CopyBillingToShipping__c == true && acc.CopyBillingToShipping__c != oldMap.get(acc.Id).CopyBillingToShipping__c)){
                acc.ShippingCity = acc.BillingCity;
                acc.ShippingCountry = acc.BillingCountry;
                acc.ShippingPostalCode = acc.BillingPostalCode;
                acc.ShippingState = acc.BillingState;
                acc.ShippingStreet = acc.BillingStreet;
            }
        }
    }
    //Logic 3: Create a contact of the account eveytime an account is created
    public static void createRelatedContact(List<Account> accList){
        List<Contact> conList = new List<Contact>();
                  
        for(Account acc:accList){
 			Contact con = new Contact();
            con.FirstName = 'Test FirstName';
            con.LastName = 'Test LastName ' + acc.Name;
            con.AccountId = acc.Id;
            conList.add(con);
        }
        
        //Null Check 
        if(!conList.isEmpty()){
            insert conList;
        }        
      }
    
     //Logic 4: Create a opportunity of the account eveytime an account is created
    
    public static void createRelatedOpp(List<Account> accList){
        
        List<Opportunity> oppList = new List<Opportunity>();
        for(Account acc: accList){
          Opportunity opp = new Opportunity();
          opp.Name = ''+acc.Name+' Opportunity';
          opp.StageName = 'Prospecting';
          opp.CloseDate = System.today();
          opp.AccountId = acc.Id;
            
          oppList.add(opp);
        }
        if(!oppList.isEmpty()){
            insert oppList;
        }
    }
    
    //LOGIC 5: UPDATE ACC DESC ON PHONE NUMBER UPDATE
    
    public static void updateAccDescOnPhoneUpdate(List<Account> accList, Map<Id,Account> oldAccMap){
        for(Account acc:accList){
            if(acc.Phone != oldAccMap.get(acc.Id).Phone){
                acc.Description = 'Phone is Updated! Old value:' +oldAccMap.get(acc.Id).Phone + ' & New Value is :'+ acc.Phone;
            }
        }
    }
    
 
     //LOGIC 6: UPDATE RELATED CONTACT HOME PHONE FIELD
     
    public static void updateRelatedContacts (List<Account> accList, Map<Id,Account> oldAccMap){
        List<Contact> conList = new List<contact>();
        Map<Id,Account> accToAccountMap = new Map<Id,Account>();
        
        for(Account acc:accList){ //iterate through new acccounts 
            if(acc.Phone != null && acc.Phone != oldAccMap.get(acc.Id).Phone && oldAccMap != null) //logic
            {
                accTOAccountMap.put(acc.id,acc); //put the accounts that pass the condition to accToAccount Map mapList
            }
        }
        
        if(accToAccountMap.size() > 0){ //if the mapList is not empty 
            for(Contact con: [SELECT Id,HomePhone,AccountId FROM Contact //querying all contacts who are related to the accounts present in accToAccount MapList
                              WHERE AccountId IN : accToAccountMap.keySet()]){ //where account id of cantact matches the accounts that passed the above logic
                                  if(accToAccountMap.containsKey(con.AccountId)){ //if the account records(logic passed) contains the related contact
                                      con.HomePhone = accToAccountMap.get(con.AccountId).Phone;//then make contact homephone field populated
                                     
                                  } conList.add(con);
            }
        }
        
        if(conList.size()>0){   //null check
            update conList;
        }
    }
    
    //LOGIC 7 : UPDATE CONTACT MAILING ADDRESS
    
    public static void updateContactsMailingAdd(List<Account> accList, Map<Id,Account> oldAccMap){
         List<Contact> conList = new List<contact>();
         Map<Id,Account> accToAccountMap = new Map<Id,Account>();
        for(Account acc:accList){
            if((acc.BillingCity != oldAccMap.get(acc.id).BillingCity
               || acc.BillingCountry != oldAccMap.get(acc.Id).BillingCountry
               || acc.BillingPostalCode != oldAccMap.get(acc.Id).BillingPostalCode
               || acc.BillingState != oldAccMap.get(acc.id).BillingState
               || acc.BillingStreet != oldAccMap.get(acc.id).BillingStreet)
               && oldAccMap != null){
                  accToAccountMap.put(acc.id, acc);
            }
        } 
        
        for(Contact con: [SELECT Id,AccountId FROM Contact WHERE AccountId IN : accToAccountMap.keySet()]){
            if(accToAccountMap.containskey(con.AccountId)){
                con.MailingCity = accToAccountMap.get(con.Accountid).BillingCity;
                con.MailingCountry = accToAccountMap.get(con.Accountid).BillingCountry;
                con.MailingPostalCode = accToAccountMap.get(con.Accountid).BillingPostalCode;
                con.MailingState = accToAccountMap.get(con.Accountid).BillingState;
                con.MailingStreet = accToAccountMap.get(con.Accountid).BillingStreet;
				
            }
            conList.add(con);
        }
        if(!conList.isEmpty()){    //null check
            update conList;
        }
    }
    
    //LOGIC 8:update opportunity stage to closed lost on account field active being no
    //MAKING USE OF SOQL PARENT CHILD RELATIONsSHIP
    
    public static void updateRelatedOppStage(List<Account> accList, Map<Id,Account> oldMap){
        List<Opportunity> oppList = new List<Opportunity>();
        Set<Id> accIds = new Set<Id>();
        for(Account acc:accList){
            if(acc.Active__c == 'No' && oldMap.get(acc.id).Active__c == 'Yes'){
                accIds.add(acc.Id);
            }
        }
        if(!accIds.isEmpty()){
            for(Account acc: [SELECT Id,Active__c,(SELECT Id,StageName FROM Opportunities) FROM Account WHERE Id IN :accIds]){
                if(acc.Opportunities != null){
                    for(Opportunity opp : acc.Opportunities){
                        if(opp.StageName != 'Closed Won' && opp.StageName != 'Closed Lost'){
                            opp.StageName = 'Closed Lost';
                            oppList.add(opp);
                        }
                    }                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
                }
            }
        }
        
        if(!oppList.isEmpty()){
            update oppList;
        }
    }
    
    //LOGIC  9 : PREVENT DELETION OF ACCOUNT
   
    public static void preventDel(List<Account> accList){
        for(Account acc:accList){
            if(acc.Active__c == 'Yes'){
                acc.addError('Active account cannot be deleted');
            }
        }
    }
    
}