trigger OrderTrigger on Order (before update, after update) {
    if (trigger.isBefore) {
        if (trigger.isUpdate) {
            OrderTriggerHandler.CalculNetAmounts(trigger.new);
        }
        
    }
    if (trigger.isAfter) {
        if (trigger.isUpdate) {
            OrderTriggerHandler.UpdateAccountTurnovers(trigger.new);
        }

   }

}