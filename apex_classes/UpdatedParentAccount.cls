public class UpdatedParentAccount implements Queueable{
	
    private List<Account> accList;
    private Id parentAccId;
    
    //constructor
    public UpdatedParentAccount(List<Account> accRecords, Id id){
        this.accList = accRecords;
        this.ParentAccId = id;
    }
    
    public void execute (QueueableContext context) {
        for(Account acc : accList){
            acc.ParentId = parentAccId;
        }
        update accList;
    }
}