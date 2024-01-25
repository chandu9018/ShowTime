public class index_ScheduleBatchApex implements Schedulable {
    public void execute(SchedulableContext SC){
        Index_BatchApex IBA = new Index_BatchApex();
        Id BatchId = Database.executeBatch(IBA);
    }
}