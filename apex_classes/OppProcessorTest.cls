@isTest
public class OppProcessorTest {
@isTest
    private static void testBatchClass(){
        List<Opportunity> oppList = new List <Opportunity>();
        for(integer i = 0; i<200 ; i++){
            oppList.add(new Opportunity(Name = 'Test ' + i, StageName = 'Prospecting', CloseDate = system.today()));
        }
       
        insert oppList;
        test.startTest();
        OppProcessor opp = new OppProcessor();
        Id batchId = Database.executeBatch(opp);
        test.stopTest();
        
        List<Opportunity> updatedOpps = [SELECT Id FROM Opportunity WHERE LeadSource = 'Phone Inquiry'];
        system.assertEquals(200, updatedOpps.size());
    }
}