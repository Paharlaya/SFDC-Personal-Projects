public class OppProcessor implements Database.Batchable<sObject>, Database.stateful{
    
    public integer recordCount = 0;
    
    public DataBase.QueryLocator start (Database.BatchableContext bc) {
        return Database.getQueryLocator([SELECT Id, Name FROM Opportunity]);
    }
    
    public void execute(Database.BatchableContext bc, List <Opportunity> opps){
        for(Opportunity op : opps){
         op.LeadSource = 'Phone Inquiry';       
            
        }
        
        update opps;
        recordCount = recordCount + opps.size();
    }
    
    public void finish(Database.BatchableContext bc){
        System.debug('Total records Processed' + recordCount);
    }
}