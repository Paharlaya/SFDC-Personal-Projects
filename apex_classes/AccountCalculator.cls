public class AccountCalculator {
@future 
    public static void countContacts(List<id> accIds){
        List<Account> accList = [SELECT Id, (SELECT Id FROM Contacts)FROM Account WHERE Id IN : accIds];
        for(Account acc:accList){
            acc.Number_of_Contacts__c = acc.Contacts.size();
        }
        if(!accList.isEmpty()){
        update accList;
        }
    }
}