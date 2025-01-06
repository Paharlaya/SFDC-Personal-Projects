public class OpportunityTriggerHandler {
    
    //LOGIC :1
    public static void updateDescription(List<Opportunity> oppList){
        for(Opportunity opp : oppList) {
            if(opp.Amount !=null && opp.Amount >= 100000 && opp.Amount<= 500000){
                opp.Description = 'Hot Opportunity';
            }
        }
    }
    
    
    //LOGIC 2
    public static void populateLatestOppAmt(List<Opportunity> oppList){
        List<Account> accList = new List<Account>();
        for(Opportunity opp:oppList){
            if(opp.Amount != null && opp.AccountId!= null){
                Account acc = new Account();
                acc.id = opp.AccountId;
                acc.Latest_Opp_Amount__c = opp.Amount;
                accList.add(acc);
            }
        }
        if(!accList.isEmpty()){
            update accList;
        }
    }
    
    //LOGIC 3
   
    public static void updateDescBasedOnStage(List<Opportunity> oppList,Map <Id,Opportunity> oldMap){
        for(Opportunity opp:oppList){
           if(oldMap == null || opp.StageName != oldMap.get(opp.Id).StageName){
               if(opp.StageName == 'Closed Won'){
                   opp.Description = 'Opportunity is closed won';
               }else if(opp.StageName == 'Closed Lost'){
                   opp.Description = 'Opportunity is Closed Lost';
               }else{
                   opp.Description = 'Opportunity is open';
               }
            }
        }
    }
    
    //LOGIC 4:create task
    
    public static void createTask (List<Opportunity> oppList , Map <Id,Opportunity> oldMap){
        List<Task> taskList = new List<Task>();
        for(Opportunity opp: oppList){
            if(opp.StageName != oldMap.get(opp.id).StageName){
                Task tsk = new Task();
                tsk.WhatId = opp.id;  //related to
            	tsk.Subject = 'Trigger after update';
                tsk.Priority = 'Normal';
                tsk.Status = 'Not Started';
                tsk.OwnerId = opp.OwnerId;
                taskList.add(tsk);
            }
            
        }
        
        if(!taskList.isEmpty()){
            insert taskList;
        }
    }
    
    
    
    
    
}