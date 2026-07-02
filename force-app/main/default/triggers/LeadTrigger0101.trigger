trigger LeadTrigger0101 on Lead (before insert , before update) {
    if(Trigger.isBefore && Trigger.isUpdate){
        for(Lead eachLead : Trigger.new){
            Lead oldLead = Trigger.oldmap.get(eachLead.id);
            if((eachLead.Status == 'Closed - Converted' || eachLead.Status == 'Closed - Not Converted') && (oldLead.Status != 'Working - Contacted')){
                eachLead.addError('Sorry The Lead Can Not Be Closed Without Contacting The Person');
            }
        }
    }
}