@isTest
public class UpdatedParentAccountTest {

    @testSetup
    
    static void setup () {
        
        List<Account> accList = new List<Account>();
        
        accList.add(new Account(name = 'parent')); //parent account
        
        for(Integer i=0;i<100;i++){
            accList.add(new Account(name = 'Test Account' +i)); //other accounts
        }
        insert accList;
    }
    
    @isTest
    private static void testQueueable(){
        Id parentId = [SELECT Id FROM Account WHERE Name = 'parent'][0].Id;
        List<Account> accList = [SELECT Id,Name FROM Account WHERE Name Like 'Test Account%'];
        
        UpdatedParentAccount updateJob = new UpdatedParentAccount(accList,parentId);
        
        test.startTest();
        system.enqueueJob(updateJob);
        test.stopTest();
        
        system.assertEquals(100,[SELECT count() FROM Account WHERE parentId = :parentId]);
    }
}