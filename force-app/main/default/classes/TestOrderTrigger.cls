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
        accts = QueriesService.AccountsList();
        Set<Id> setAccountIds = new Set<Id>();
        setAccountIds.add(accts[0].Id);
        // Get Orders with LIMIT = 1
        orders = QueriesService.OrdersByAccountIds(setAccountIds, 1);

        // NetAmount (1300) = TotalAmount (1500) - ShipmentCost(200)
        System.assertEquals(1300, orders[0].NetAmount__c);
    }

    @isTest
    static void testCalculNetAmountsForTenOrders(){

        // Get 1 account and set ID in setAccountIds
        accts = QueriesService.AccountsList();
        Set<Id> setAccountIds = new Set<Id>();
        setAccountIds.add(accts[0].Id);
        // Get Orders with LIMIT = 10
        orders = QueriesService.OrdersByAccountIds(setAccountIds, 10);

        // NetAmount (1300) = TotalAmount (1500) - ShipmentCost(200)
        for (Integer i = 0; i < orders.size(); i++) {
            System.assertEquals(1300, orders[i].NetAmount__c);
        }
    }

    @isTest
    static void TestUpdateAccountTurnovers(){

        accts = QueriesService.AllAccountsWithOrders();
        orders = accts[0].Orders; 

        // Update shipment cost
        orders[0].ShipmentCost__c = 500;
        Test.startTest();
        update orders;
        Test.stopTest();
        
        // account's Turnover updated
        List<Account> accts = QueriesService.AccountsList();
        System.assertEquals(1000, accts[0].Turnover__c);
    }

}