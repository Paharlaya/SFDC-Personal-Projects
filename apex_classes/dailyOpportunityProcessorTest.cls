@isTest
public class dailyOpportunityProcessorTest {
    @isTest
    
    private static void testScheduledApex(){

        List<Opportunity> oppList = new List<Opportunity>();
        String sch = '0 0 0 ? * * *';
        for(Integer i = 1;i<500;i++){
            
            if(i<250){
                oppList.add(new Opportunity(Name = 'Test ' +i, StageName = 'Prospecting', CloseDate = system.today()));
            }else{
                 oppList.add(new Opportunity(Name = 'Test ' +i, StageName = 'Prospecting', CloseDate = system.today(), LeadSource = 'Other'));
            }
        }
        
        insert oppList;
        
        Test.startTest();
        string jobId = System.schedule('Process Opportunities', sch , new DailyOpportunityProcessor());
        Test.stopTest();
        
        List<Opportunity> updatedOppList = [SELECT Id,LeadSource FROM Opportunity WHERE LeadSource = 'Web'];
        system.assertEquals(200, updatedOppList.size());
    }
}