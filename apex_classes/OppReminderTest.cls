@isTest
public class OppReminderTest {
    
    public static String CRON_EXP = '0 0 0 ? * * *';
    
    @isTest
    public static void testScheduledJob(){
        List<Opportunity> oppList = new List<Opportunity>();
        
        for(integer i =1; i<=5;i++){
            Opportunity opp = new Opportunity();
            opp.Name = 'Test '+i;
            opp.StageName = 'Prospecting';
            opp.CloseDate = date.today().addDays(-7);
            oppList.add(opp);
        }
        
        insert oppList;
        Set<Id> oppIds = new Set<Id>();
        for(opportunity opp : oppList){
            oppIds.add(opp.Id);
        }
        
          test.startTest();
            String jobId = system.schedule('Create Task', CRON_EXP, new OppReminder());
          test.stopTest();
        
	
		List<Task> taskList = [SELECT Id FROM Task WHERE WhatId IN: oppIds];   
        system.assertEquals(5,taskList.size());
        
    }
}