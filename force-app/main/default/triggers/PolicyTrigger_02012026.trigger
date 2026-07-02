trigger PolicyTrigger_02012026 on Policy__c (After Update, After Insert, After Delete, After Undelete) {
    Switch on Trigger.OperationType{
        When AFTER_INSERT{
            PolicyTriggerHandlerClass.PolicyAfterInsert(Trigger.new);
        }
        When AFTER_UPDATE{
            PolicyTriggerHandlerClass.PolicyAfterUpdate(Trigger.new, Trigger.oldMap);
        }
        When AFTER_DELETE{
            PolicyTriggerHandlerClass.PolicyAfterDelete(Trigger.old);
        }
        When AFTER_UNDELETE{
           PolicyTriggerHandlerClass.PolicyAfterUnDelete(Trigger.new);
        }
    }	
}