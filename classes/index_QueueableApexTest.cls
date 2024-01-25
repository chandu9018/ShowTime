@isTest
public class index_QueueableApexTest {
    @testSetup
    private static void AccountSetUp(){
        List<Account> CreateAcc = new List<Account>();
        for(integer i=1;i<=200;i++){
            Account NewAcc = new Account();
            NewAcc.Name='NewAccount'+i;
            CreateAcc.add(NewAcc);
        }
        if(!CreateAcc.isEmpty()){
          insert CreateAcc;
        }
    }
    @isTest
    private static void UpdateParentAccount(){
        List<Account> GetAccount= [Select Id,Name From Account where Name Like 'NewAccount%'];
        Id ParentId=GetAccount[0].Id;
        List<Account> ChildAccount = new List<Account>();
        for(Account acc : GetAccount){
            if(acc.Id!=ParentId){
                ChildAccount.add(acc);
            }
        }
        Test.Starttest();
        index_QueueableApex IQA=new index_QueueableApex(ChildAccount,ParentId);
        Id JobId = System.enqueueJob(IQA);
        Test.Stoptest();
        List<Account> NewChildAccount = [Select Id From Account where parentId=:ParentId];
        system.assertEquals(199,NewChildAccount.size());
    }
}