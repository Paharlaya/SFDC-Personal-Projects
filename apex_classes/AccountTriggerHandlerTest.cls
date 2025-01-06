@isTest

public class AccountTriggerHandlerTest {
    //TEST FOR LOGIC 9
    
    @isTest
    public static void preventDeltest(){
        List<Account> accList = new List<Account>();
        for(integer i= 1;i<=5;i++){
            Account acc = new Account();
            acc.Name = 'Test ' +i;
            acc.Active__c = 'Yes';
            accList.add(acc);
               
        }
        
        test.startTest();
        insert accList;
        delete accList;
        test.stopTest();
        
        
        
    }
    
    
    
    
    
    
    
    //TEST FOR LOGIC 8 
    
    @isTest
    public static void updateRelatedOppStageTest(){
       List<Account> accList = new List<Account>();
       List<Opportunity> oppList = new List<Opportunity>();
        
         for(Integer i=1;i<=5;i++){
            Account acc = new Account();
            acc.Name = 'Test ' +1;
            acc.Active__c = 'Yes';
            accList.add(acc);
        }
        test.startTest();
        insert accList;
        
        for(Account acc:accList){
            opportunity opp = new Opportunity();
            opp.Name = 'TestOpp';
            opp.CloseDate = system.today();
            opp.StageName = 'Prospecting';
            opp.AccountId = acc.Id;
 		    oppList.add(opp);
        }
        insert oppList;
        
        for(Account acc : accList){
            acc.Active__c = 'No';
        }
        
        update accList;
        test.stopTest();
        
        List<Opportunity> updatedOppList = [SELECT Id,StageName FROM Opportunity WHERE Id = :oppList[0].id];
        system.assertEquals('Closed Lost', updatedOppList[0].StageName);
        
        
    }
    
    //TEST FOR LOGIC 7
    
    @isTest 
    
    public static void updateContactsMailingAddTest(){
	List<Account> accList = new List<Account>();
    List<Contact> conList = new List<Contact>();
        
        for(Integer i=1;i<=5;i++){
            Account acc = new Account();
            acc.Name = 'Test ' +1;
            acc.BillingCity = 'Kolkata';
            accList.add(acc);
        }
        
        test.startTest();
        insert accList;
        for(Account acc:accList){
            Contact con = new Contact(LastName = acc.Name);
            con.AccountId = acc.Id; //creating related contact
            conList.add(con);
    }
        insert conList;
        
        for(Account acc:accList){
            acc.BillingCity = 'Darjeeling'; //updating the account billing city field
            
        }
        update accList;
        test.stopTest();
            
          List<Contact> updatedContactList = [SELECT Id,MailingCity FROM Contact WHERE Id =:conList[0].Id];
          System.assertEquals('Darjeeling', updatedContactList[0].MailingCity);
        
    }
     
    //TEST FOR LOGIC 6
    @isTest
    	public static void updateRelatedContactTest(){
        List <Account> accList = new List<Account>();
        List<Contact> conList = new List<Contact>();
        for(Integer i = 1;i<=5;i++){
		Account acc = new Account();
            acc.Name = 'Test ' +i;
            accList.add(acc);    
        }
            
            Test.startTest();
            insert accList;
            for(Account acc:accList){
            Contact con = new Contact(LastName = acc.Name); //contact creation
            con.AccountId = acc.Id;
            conList.add(con);
            }
            insert conList;
            
            for(Account acc:accList){
                acc.Phone = '654321';
            }
            update accList;
            Test.stopTest();
            
            List<Contact> updatedConList = [SELECT Id,HomePhone FROM Contact
                                           WHERE Id =:conList[0].id];
            system.assertEquals('654321',updatedConList[0].HomePhone);
        }       
@isTest
    
    //TEST FOR LOGIC 1 part 2
    
    public static void updateRatingUpdateTest(){
        //creating sample data
        List<Account> accList = new List<Account>();
        
        for(Integer i=1;i<=5;i++){
            Account acc = new Account();
            acc.Name = 'Test' + i;
            accList.add(acc);
        }
        //inserting data
        Test.startTest();//use this for refreshing governer limits i.e. separate set of governor limits are there for each DML o/p
        insert accList;
        for(Account acc:accList){
			acc.Industry ='Media';
        }
        update accList;
        Test.stopTest();
        
        //Query the updated information
        List<Account> updatedAccList = [SELECT Id,Rating FROM Account WHERE Id = :accList[0].Id];
        //apply assert condition
       System.assertEquals('Hot', updatedAccList[0].Rating);
       
    }
    
    
   
  @isTest
    public static void updateBillingToShipping(){
        
        List<Account> accList= new List<Account>();
        
        for(Integer i=1;i<=5;i++){
            Account acc = new Account();
            acc.Name = 'Sample ' +i;
            acc.BillingCity = 'TestCity';
            acc.BillingCountry = 'Test Country';
            acc.BillingPostalCode = 'Test postal code';
            acc.BillingState = 'Test state';
            acc.BillingStreet = 'Test Street';
            acc.CopyBillingToShipping__c = true;
            
            accList.add(acc);
        }
        
        //inserting data
        Test.startTest();
        insert accList;
        
        for(Account acc:accList){
            acc.CopyBillingToShipping__c = true;
        }
        
        update acclist;
        Test.stopTest();
        
        List<Account> updatedAccList= [SELECT Id,ShippingCity FROM Account WHERE Id = :accList[0].Id];
        System.assertEquals('TestCity', updatedAccList[0].ShippingCity);
        
    }
    
    
    
    //TEST FOR LOGIC 5
    @isTest
    
    public static void testUpdateAccDescOnPhoneUpdate(){
        List <Account> accList = new List<Account>();
        for(Integer i =1;i<=5;i++){
            Account acc = new Account();
            acc.Name = 'Test ' +i;
            acc.Phone = '123456';
            accList.add(acc);
            
        }
        
        test.startTest();
        insert accList;
   
        //loop for updating phone
        
        for(Account acc:acclist){
            acc.Phone = '303030';
        }
        
        update accList;
        test.stopTest();
        
        List<Account> updatedAccList = [SELECT Id,Phone FROM Account WHERE Id = :accList[0].Id];
        System.assertEquals('303030', updatedAccList[0].phone);
        
    }
    
    
    
    
    
    //TEST FOR LOGIC 4
    @isTest
    public static void createRelatedOpp(){
        List <Account> accList = new List<Account>();
        for(Integer i=1;i<=5;i++){
            Account acc = new Account();
            acc.Name = 'Test' + i;
            accList.add(acc);
        }
        
        Test.startTest();
        insert accList;
        Test.stopTest();
        
        List<Opportunity> oppList = [SELECT Id FROM Opportunity WHERE AccountId =:accList[0].Id];
     	System.assert(oppList!= null, 'Opportunity is not created');//null test
    }
    
     
    //TEST FOR LOGIC 3
    @isTest
    public static void createRelatedContact(){
        List <Account> accList = new List<Account>();
        for(Integer i=1;i<=5;i++){
            Account acc = new Account();
            acc.Name = 'Test' + i;
            accList.add(acc);
        }
        
        Test.startTest();
        insert accList;
        Test.stopTest();
        
        List<Contact> conList = [SELECT Id FROM Contact WHERE AccountId =:accList[0].Id];
     	System.assert(conList!= null, 'Contact is not created');//null test
    }
    
    
    
    
    //TEST FOR LOGIC 2
    @isTest
    public static void copyBillingToShipping(){
        
        List<Account> accList= new List<Account>();
        
        for(Integer i=1;i<=5;i++){
            Account acc = new Account();
            acc.Name = 'Sample ' +i;
            acc.BillingCity = 'TestCity';
            acc.BillingCountry = 'Test Country';
            acc.BillingPostalCode = 'Test postal code';
            acc.BillingState = 'Test state';
            acc.BillingStreet = 'Test Street';
            acc.CopyBillingToShipping__c = true;
            
            accList.add(acc);
        }
        
        //inserting data
        Test.startTest();
        insert accList;
        Test.stopTest();
        
        List<Account> updatedAccList= [SELECT Id,ShippingCity FROM Account WHERE Id = :accList[0].Id];
        System.assertEquals('TestCity', updatedAccList[0].ShippingCity);
        
    }
    
}