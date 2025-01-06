public with sharing class OpportunityProductsController {
    public Opportunity opp;    
    public List<Terrorblade__c> tb { get; set; }
    public List<OpportunityLineItem> OpportunityProducts { get; set; }
    
    public OpportunityProductsController(ApexPages.StandardController controller) {
        opp = (Opportunity)controller.getRecord();
        tb = [SELECT Id, Form__c FROM Terrorblade__c];
        OpportunityProducts = [SELECT Id, Product2.Name, Quantity, UnitPrice FROM OpportunityLineItem WHERE OpportunityId = :opp.Id];
    }

    // Generate PDF content
   
}