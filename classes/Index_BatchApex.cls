public class Index_BatchApex implements Database.Batchable<sObject>,
Database.stateful{
    public integer recordCount=0;
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([Select Id,name From Opportunity]);
    }
    public void execute(Database.BatchableContext bc,List<Opportunity> Opps){
        for(Opportunity op : Opps){
            op.leadSource='Web';
        }
        update Opps;
        recordCount=recordCount+Opps.size();
    }
    public void finish(Database.BatchableContext bc){
        system.debug('Records Proccessed : '+recordCount);
    }
}