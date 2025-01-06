public class AccountHandler {

    public static Account insertNewAccount(String Accname){
        try{
        Account accnew = new Account(Name = Accname);
        insert accnew;
        return accnew;
        }
        catch(DMLException e){
            system.debug('DML Exception' + e.getMessage());
            return null;
        }
    }
}