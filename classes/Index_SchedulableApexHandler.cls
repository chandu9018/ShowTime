public class Index_SchedulableApexHandler {
    public static void CreateReminderTastonOpportunity(List<Opportunity> OppList){
        List<Task> CreateTask = new List<Task>();
        for(Opportunity opp : OppList){
            Task NewTask = new Task();
            NewTask.Subject='Opportunity not Closed';
            NewTask.Status='Not Started';
            NewTask.Priority='Normal';
            NewTask.WhatId=opp.Id;
            NewTask.OwnerId=opp.OwnerId;
            CreateTask.add(NewTask);
        }
        if(!CreateTask.isEmpty()){
          insert CreateTask;
        }
    }
}