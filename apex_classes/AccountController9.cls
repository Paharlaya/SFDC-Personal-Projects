public class AccountController9 {

    @AuraEnabled
    public static List<Account> displayAccounts() {
        return [SELECT Name FROM Account LIMIT 5];
    }
    
}