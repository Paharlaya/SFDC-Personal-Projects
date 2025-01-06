@isTest
public class AccountCalculatoreTest {
@isTest
    private static void countContactsTest(){
        List<Account> accList  = new List <Account>();
        
        for(Integer i =0; i<250;i++){
            accList.add(new Account(Name ='Test '+i));
        }
        insert accList;
        List<Contact> conList = new List<Contact>();
        List<Id> accIds = new List<id>();
        for(Account acc : accList){
            conList.add(new Contact (FirstName = 'Test',LastName = acc.Name, AccountId = acc.id));
            accIds.add(acc.Id);
        }
        insert conList;
        
        Test.startTest();
        AccountCalculator.countContacts(accIds);
        Test.stopTest();
        List<Account> accs = [SELECT Id,Number_of_Contacts__c FROM Account];
        System.assertEquals(2, accs[0].Number_of_Contacts__c);  //because 1 contact is associated with 1 account
        
    }
}