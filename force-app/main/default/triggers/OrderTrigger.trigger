trigger OrderTrigger on Order (before update, after update) {
    if (trigger.isBefore) {
        if (trigger.isUpdate) {
            //execute function beforre update
            OrderTriggerHandler.CalculNetAmounts(trigger.new);
        }
        // if (Trigger.isInsert()) {
        //     //execute functions before insert
        // }
        // if (Trigger.isDelete()) {
        //     //execute functions before delete
        // }
        
    }
    if (trigger.isAfter) {
        if (trigger.isUpdate) {
            //execute function after update
            OrderTriggerHandler.UpdateAccountTurnovers(trigger.new);
        }
        // if (Trigger.isInsert()) {
        //     //execute functions after insert
        // }
        // if (Trigger.isDelete()) {
        //     //execute functions after delete
        // }
        // if (Trigger.isUndelete()) {
        //     //execute functions after undelete
        // }
   }

}