@isTest
public class Index_SchedulableApexTest {
    @testsetup
    private static void Opportunity(){
        List<Opportunity> Opps = new List<Opportunity>();
        for(integer i=1;i<=200;i++){
            Opportunity NewOpp = new Opportunity();
            NewOpp.Name='Opportunity'+i;
            NewOpp.Amount=0;
            NewOpp.CloseDate=system.Today() - 7;
            NewOpp.StageName='Prospecting';
            Opps.add(NewOpp);
        }
        if(!Opps.isEmpty()){
            insert Opps;
        }
    }
    @isTest
    private static void UpdateOpportunity(){
        Test.startTest();
        Index_SchedulableApex ISA = new Index_SchedulableApex();
        string Sch = '0 50 15 24 1 ? 2024';
        String JobId = system.schedule('Remind Opp Owner 2',Sch,ISA);
        Test.stopTest();
        List<Opportunity> GetOpp = [Select Id,leadSource From Opportunity where leadSource='Web'];
        if(!GetOpp.isEmpty()){
            system.assertEquals(200,GetOpp.size());
        }
    }
    @isTest
    private static void CreateTaskonOpportunity(){
        Map<Id,Opportunity> opplist = new Map<Id,Opportunity>([Select Id,Name,OwnerId,CloseDate
                                    From Opportunity
                                    Where IsClosed=False 
                                    AND CloseDate < TODAY]);
        Test.startTest();
        Index_SchedulableApex ISA = new Index_SchedulableApex();
        string Sch = '0 50 15 24 1 ? 2024';
        String JobId = system.schedule('Remind Opp Owner 4',Sch,ISA);
        Test.stopTest();
        if(!opplist.isEmpty()){
            List<Task> GetTask = [Select Id from Task where WhatId in :opplist.keySet()];
            system.assertEquals(200,GetTask.size());
        }
    }
}