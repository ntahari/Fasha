@isTest
private class TestOrderTrigger {
    @isTest static void testCalculNetAmounts() {

    //Add Acounts 
    List<Account> accts = TestDataFactory.createAccounts(1);

    // Add 1 Order with shipmentCost = 200
    List<Order> orders = TestDataFactory.createOrders(accts, 1, 200);
    
    // Add OrderItem with quantity of item = 10 AND price unity = 150 and Update Orders 
    // TotalAmount : 10*15 = 1500
    TestDataFactory.createOrderItem(orders, 10, 150);

    // Get Order
    Set<Id> setAccountIds = new Set<Id>();
    setAccountIds.add(accts[0].Id);
    List<Order> ordersData = QueriesService.OrdersByAccountIds(setAccountIds, 1);
    
    // NetAmount (1300) = TotalAmount (1500) - ShipmentCost(200)
    system.assertEquals(1300, ordersData[0].NetAmount__c);
    }
}