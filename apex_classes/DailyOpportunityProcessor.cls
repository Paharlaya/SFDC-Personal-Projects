public class DailyOpportunityProcessor implements Schedulable {
    public void execute(schedulableContext ctx){
        
        List<Opportunity> oppList = [SELECT Id,LeadSource FROM Opportunity WHERE LeadSource = null LIMIT 200];
        
        for(Opportunity opp:opplist){
            opp.LeadSource = 'Web';
        }
        
        if(!oppList.isEmpty()){
        update oppList;
        }
    }
}