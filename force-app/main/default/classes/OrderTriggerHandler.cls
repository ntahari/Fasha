public with sharing class OrderTriggerHandler {
    public static void CalculNetAmounts(List<Order> newOrders) {
        for(integer i=0; i< newOrders.size(); i++){
            Order newOrder= newOrders[i];
            newOrder.NetAmount__c = 0;
            if (newOrder.ShipmentCost__c == null) {
                newOrder.ShipmentCost__c = 0;
            }
            newOrder.NetAmount__c = newOrder.TotalAmount - newOrder.ShipmentCost__c;
        }
    }

    public static void UpdateAccountTurnovers(List<Order> newOrders) {
        set<Id> setAccountIds = new set<Id>();
        for(integer i=0; i< newOrders.size(); i++){
            Order newOrder= newOrders[i];
            setAccountIds.add(newOrder.AccountId);
        }
        //update the turnover
        AccountService.UpdateTurnOver(setAccountIds);
    }

}
