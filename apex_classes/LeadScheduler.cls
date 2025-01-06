public class LeadScheduler implements Schedulable {

    public void execute(SchedulableContext ctx){
        
          List<Lead> leadList = [SELECT Id FROM Lead WHERE Created_Date__c = TODAY];
     	  List<Task> taskList = new List<Task>();
        
        for(Lead ld :leadList){
                Task tsk = new Task();
                tsk.WhoId = ld.id;  //related to
            	tsk.Subject = 'Task for Newly Created Leads';
                tsk.Priority = 'Normal';
                tsk.Status = 'Not Started';
                tsk.OwnerId = ld.OwnerId;
                taskList.add(tsk);  
        }
        if(!taskList.isEmpty()){
            insert taskList;
        }
    }
}