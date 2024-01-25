@isTest
public class index_ScheduleBatchApexTest {
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
        index_ScheduleBatchApex ISBA = new index_ScheduleBatchApex();
        string Sch = '0 6 16 24 1 ? 2024';
        Id JobId=system.schedule('Schedule Batch APex',Sch,ISBA);
        Test.stopTest();
        List<Opportunity> GetOpp = [Select Id,leadSource From Opportunity where leadSource='Web'];
        if(!GetOpp.isEmpty()){
            system.assertEquals(200,GetOpp.size());
        }
    }
}