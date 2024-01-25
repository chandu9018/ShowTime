public class index_QueueableApex implements Queueable{
    private List<Account> accList;
    private Id AccParentId;
    public index_QueueableApex(List<Account> accList,Id AccParentId){
        this.accList=accList;
        this.AccParentId=AccParentId;
    }
    public void execute(QueueableContext Qc){
        for(Account acc : accList){
            acc.ParentId=AccParentId;
        }
        update accList;
    }
}