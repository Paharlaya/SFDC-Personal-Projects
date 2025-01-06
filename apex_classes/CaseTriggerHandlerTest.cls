@isTest
public class CaseTriggerHandlerTest {
@isTest
    private static void testPopulateLatestCaseNum(){
        List<Account> accList = new List<Account>();
         List<Case> caseList = new List<Case>();
        for(Integer i=1;i<=5;i++){
            Account acc = new Account();
            acc.Name = 'Test' + i;
            accList.add(acc);
        }
        
        insert accList;
        
        for(Account acc: accList){
            Case cs = new Case();
            cs.Status = 'New';
            cs.Origin = 'Phone';
            cs.AccountId = acc.Id;
            caseList.add(cs);
            
        }
        
        test.startTest();
        insert caseList;
        test.stopTest();
        
        
        List<Account> updatedAcc =  [SELECT Id,Latest_Case_Number__c FROM Account WHERE Id =:accList[0].id];
        List<Case> newCaseList = [SELECT Id,CaseNumber FROM Case WHERE Id =:caseList[0].id];
        System.assertEquals(newcaseList[0].CaseNumber, updatedAcc[0].Latest_Case_Number__c);
        
    }
}