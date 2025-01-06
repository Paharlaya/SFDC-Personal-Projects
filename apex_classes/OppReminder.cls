public class OppReminder implements Schedulable{
    public void execute(schedulableContext ctx){
        List<Opportunity> oppList = [SELECT Id,StageName,CloseDate,OwnerId FROM Opportunity WHERE isClosed = false AND CloseDate < TODAY];
        
        List<Task> taskList = new List<Task>();
        if(!oppList.isEmpty()){
            for(Opportunity opp:oppList){
                Task tsk = new Task();
                tsk.Subject = 'Test Schedule Task';
                tsk.Status = 'Open';
                tsk.Priority = 'Normal';
                tsk.WhatId = opp.Id;
                tsk.OwnerId = opp.OwnerId;
                taskList.add(tsk);
            }
        }
        
        if(!taskList.isEmpty()){
            insert taskList;
        }
        
    }
}