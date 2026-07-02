trigger AccountTrigger_3112 on Account (Before insert, After insert, Before update, After update) {
    
    switch on Trigger.OperationType{
        when BEFORE_INSERT{
            AccountTriggerHandlerClass_0201.beforeAccountInsertion(Trigger.new);
        }
        when AFTER_INSERT{
            AccountTriggerHandlerClass_0201.afterAccountInsertion(Trigger.new);
        }
        when BEFORE_UPDATE{
            //AccountTriggerHandlerClass_0201.beforeAccountUpdation(Trigger.new, Trigger.oldMap); 
            AccoutHandlerClass.CheckForActiveContact(Trigger.new);
        }
        when AFTER_UPDATE{
            AccountTriggerHandlerClass_0201.afterAccountUpdation(Trigger.new);  
        }
        when BEFORE_DELETE{
            
        }
        when AFTER_DELETE{
            
        }
        when AFTER_UNDELETE{
            
        }
    }
}