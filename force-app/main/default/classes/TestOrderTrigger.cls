@isTest
private class TestOrderTrigger{
    static List<Order> orders = new List<Order>();
    static List<Account> accts = new List<Account>();
    @TestSetup
    static void setup(){
        //Add Acounts
        accts = TestDataFactory.createAccounts(1);
        // Add 1 Order with shipmentCost = 200
        orders = TestDataFactory.createOrders(accts, 1, 200);
        // Add OrderItem with quantity of item = 10 AND price unity = 150 and Update Orders
        // TotalAmount : 10*15 = 1500
        TestDataFactory.createOrderItem(orders, 10, 150);
    }
    @isTest
    static void testCalculNetAmounts(){

        // Get 1 account and set ID in setAccountIds
        List<Account> acctsData = QueriesService.AccountsList();
        Set<Id> setAccountIds = new Set<Id>();
        setAccountIds.add(acctsData[0].Id);
        // Get Orders with LIMIT = 1
        List<Order> ordersData = QueriesService.OrdersByAccountIds(setAccountIds, 1);

        // NetAmount (1300) = TotalAmount (1500) - ShipmentCost(200)
        System.assertEquals(1300, ordersData[0].NetAmount__c);
    }
    @isTest
    static void testCalculNetAmountsForTenOrders(){

        // Get 1 account and set ID in setAccountIds
        List<Account> acctsData = QueriesService.AccountsList();
        Set<Id> setAccountIds = new Set<Id>();
        setAccountIds.add(acctsData[0].Id);
        // Get Orders with LIMIT = 10
        List<Order> ordersData = QueriesService.OrdersByAccountIds(setAccountIds, 10);

        // NetAmount (1300) = TotalAmount (1500) - ShipmentCost(200)
        for (Integer i = 0; i < ordersData.size(); i++) {
            System.assertEquals(1300, ordersData[i].NetAmount__c);
        }
    }

    @isTest
    static void TestUpdateAccountTurnovers(){

        // Get 1 account and set ID in setAccountIds
        List<Account> acctsData = QueriesService.AccountsList();
        Set<Id> setAccountIds = new Set<Id>();
        setAccountIds.add(acctsData[0].Id);

        // Get Orders with LIMIT = 1
        List<Order> ordersData = QueriesService.OrdersByAccountIds(setAccountIds, 1);
        // Update shipment cost
        ordersData[0].ShipmentCost__c = 500;
        Test.startTest();
        update ordersData;
        Test.stopTest();
        
        // account's Turnover updated
        List<Account> accts = QueriesService.AccountsList();
            System.assertEquals(1000, accts[0].Turnover__c);
    }

}