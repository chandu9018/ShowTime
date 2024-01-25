global class Index_SchedulableApex implements Schedulable {
    global void execute(SchedulableContext SC){
        List<Opportunity> opplist = [Select Id,Name,OwnerId,CloseDate
                                    From Opportunity
                                    Where IsClosed=False 
                                    AND CloseDate < TODAY];
        Index_SchedulableApexHandler.CreateReminderTastonOpportunity(opplist);
        List<Opportunity> getOpportunity = [
            Select Id,Name,LeadSource From Opportunity 
            Where LeadSource = null Limit 200
        ];
        for(Opportunity opp : getOpportunity){
            opp.LeadSource='Web';
        }
        if(!getOpportunity.isEmpty()){
            update getOpportunity;
        }
    }
}