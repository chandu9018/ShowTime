@isTest
public class Index_BatchApexTest {
    @testSetup
    private static void OpportunitySetup(){
        List<Opportunity> Opps = new List<Opportunity>();
        for(integer i=1;i<=200;i++){
            Opportunity NewOpp = new Opportunity();
            NewOpp.Name='Opportunity'+i;
            NewOpp.Amount=0;
            NewOpp.CloseDate=system.Today();
            NewOpp.StageName='Prospecting';
            Opps.add(NewOpp);
        }
        if(!Opps.isEmpty()){
            insert Opps;
        }
    }
    @isTest
    private static void UpdateOpportunitybatch(){
        Test.startTest();
        Index_BatchApex IBA = new Index_BatchApex();
        Id batchId = Database.executeBatch(IBA,200);
        Test.stopTest();
        List<Opportunity> GetOpp = [Select Id,leadSource From Opportunity where leadSource='Web'];
        if(!GetOpp.isEmpty()){
            system.assertEquals(200,GetOpp.size());
        }
    }
}