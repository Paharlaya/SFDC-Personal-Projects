@isTest

public class OpportunityTriggerHandlerTest {
		//logic 1 test
    @isTest 
		public static void updateDecsTest(){
        //Create data
        List<Opportunity> oppList = new List<Opportunity>();
        for(Integer i=1;i<=5;i++){
            Opportunity opp = new Opportunity();
            opp.Name = 'Test OPP' +i;
            opp.StageName = 'Prospecting';
            opp.CloseDate = System.today();
            opp.Amount = 200000;
            oppList.add(opp);
        }
        
        Test.startTest();
        insert oppList;
        Test.stopTest();
        
        
        List<Opportunity> updatedOppList = [SELECT Id,Description FROM Opportunity WHERE Id =:oppList[0].Id];
        
        System.assertEquals('Hot Opportunity', updatedOppList[0].Description);
    }
    
	
    //logic 2 test
     @isTest
    public static void testPopulateLatestOppAmt(){
        List<Account> accList = new List<Account>();
        List<Opportunity> oppList = new List<Opportunity>();
       
        for(Integer i=1;i<=5;i++){
            Account acc = new Account();
            acc.Name = 'Test' +i;
            accList.add(acc);
        }
        insert accList;
        
        for(Account acc:accList){
            Opportunity opp = new Opportunity();
            opp.Name = acc.Name;
            opp.StageName = 'Prospecting';
            opp.CloseDate = System.today();
            opp.Amount = 200000;
            opp.AccountId = acc.id;
            oppList.add(opp);
        }
        Test.startTest();
        insert oppList;
        Test.stopTest();
        
        
        List<Account> updatedAcc = [SELECT Id,Latest_Opp_Amount__c FROM Account WHERE Id = :accList[0].id];
        
        System.assertEquals(200000, updatedAcc[0].Latest_Opp_Amount__c);
        System.assertEquals(oppList[0].Amount, updatedAcc[0].Latest_Opp_Amount__c);
        
        }
    
    //LOGIC 3 TEST : for insert operation
    
    @isTest
    
    public static void updateDescBasedOnStageInsertTest(){
        
        List<Opportunity> oppList = new List<Opportunity>();
        for(Integer i =1;i<=5;i++){
            Opportunity opp = new opportunity();
             opp.Name = 'Test ' +i;
             opp.StageName = 'Prospecting';
             opp.CloseDate = System.today();
             opp.Amount = 99999;
             oppList.add(opp);
        }
        
        Test.startTest();
        insert oppList;
        Test.stopTest();
        
        List<Opportunity> updatedOppList = [SELECT Id,Description FROM Opportunity WHERE Id = :oppList[0].Id];
        System.assertEquals('Opportunity is open', updatedOppList[0].Description);
    }
          //LOGIC 3 TEST : for insert operation
         
          @isTest
    
        
    public static void updateDescBasedOnStageUpdateTest(){
        
        List<Opportunity> oppList = new List<Opportunity>();
        for(Integer i =1;i<=5;i++){
            Opportunity opp = new opportunity();
             opp.Name = 'Test ' +i;
             opp.StageName = 'Prospecting';
             opp.CloseDate = System.today();
             opp.Amount = 99999;
             oppList.add(opp);
        }
        
        Test.startTest();
        insert oppList;
        for(Opportunity opp:oppList){
        opp.StageName = 'Closed Won';
        }
        update oppList;
        Test.stopTest();
        
        List<Opportunity> updatedOppList = [SELECT Id,Description FROM Opportunity WHERE Id = :oppList[0].Id];
        System.assertEquals('Opportunity is closed won', updatedOppList[0].Description);
    }
    
    //test for logic 4
        @isTest
   	    public static void createTaskTest(){
            List <Opportunity> oppList = new List<Opportunity>();
            for(Integer i = 1;i<=5;i++){
                  Opportunity opp = new Opportunity();
                  opp.Name = 'Test ' +i;
            	  opp.StageName = 'Prospecting';
            	  opp.CloseDate = System.today();
           	  	  opp.Amount = 99999;
            	  oppList.add(opp);
            }
            
            test.startTest();
            insert oppList;
            
            for(Opportunity opp : oppList){
                opp.StageName = 'Closed Won';
            }
            
            update oppList;
            test.stopTest();
            
            List<Task> taskList = [SELECT Id FROM Task WHERE WhatId =:oppList[0].Id];
              system.assertEquals(1, taskList.size());
            
        }
    
        
}