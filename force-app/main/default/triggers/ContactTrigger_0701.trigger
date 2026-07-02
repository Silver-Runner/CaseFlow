trigger ContactTrigger_0701 on Contact (before Insert, before Update, after Delete, After Insert) {
    Switch on Trigger.operationType{
        When BEFORE_UPDATE{
            ContactTriggerHandlerClass_0701.ContactBeforeUpdate(Trigger.new);
        }
        When AFTER_DELETE{
            ContactTriggerHandlerClass_0701.AfterContactDeletion(Trigger.old);
        }
        When AFTER_INSERT{
            ContactTriggerHandlerClass_0701.AfterContactInsertion(Trigger.new);
        }
    }
}