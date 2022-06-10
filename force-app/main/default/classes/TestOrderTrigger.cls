@isTest
private class TestOrderTrigger{
    static List<Order> orders = new List<Order>();
    static List<Account> accts = new List<Account>();
    // @TestSetup
    // static void setup(){
    //     //Add Acounts
    //     accts = TestDataFactory.createAccounts(1);
    //     // Add 1 Order with shipmentCost = 200
    //     orders = TestDataFactory.createOrders(accts, 1, 200);
    // }
    @isTest
    static void testCalculNetAmounts(){

        //Add Acounts
        accts = TestDataFactory.createAccounts(1);
        // Add 1 Order with shipmentCost = 200
        orders = TestDataFactory.createOrders(accts, 1, 200);

        // Add OrderItem with quantity of item = 10 AND price unity = 150 and Update Orders
        // TotalAmount : 10*15 = 1500
        TestDataFactory.createOrderItem(orders, 10, 150);

        Set<Id> setAccountIds = new Set<Id>();
        setAccountIds.add(accts[0].Id);
        // Get Orders with LIMIT = 1
        List<Order> ordersData = QueriesService.OrdersByAccountIds(setAccountIds, 1);

        // NetAmount (1300) = TotalAmount (1500) - ShipmentCost(200)
        system.assertEquals(1300, ordersData[0].NetAmount__c);
    }
    @isTest
    static void testCalculNetAmountsForTenOrders(){

        //Add Acounts
        accts = TestDataFactory.createAccounts(1);
        // Add 10 Order with shipmentCost = 200
        orders = TestDataFactory.createOrders(accts, 10, 200);

        // Add OrderItem with quantity of item = 10 AND price unity = 150 and Update Orders
        // TotalAmount : 10*15 = 1500
        TestDataFactory.createOrderItem(orders, 10, 150);

        Set<Id> setAccountIds = new Set<Id>();
        setAccountIds.add(accts[0].Id);
        // Get Orders with LIMIT = 10
        List<Order> ordersData = QueriesService.OrdersByAccountIds(setAccountIds, 10);

        // NetAmount (1300) = TotalAmount (1500) - ShipmentCost(200)
        for (Integer i = 0; i < ordersData.size(); i++) {
            system.assertEquals(1300, ordersData[i].NetAmount__c);
        }
    }

    @isTest
    static void TestUpdateAccountTurnovers(){
        //Add Acounts
        accts = TestDataFactory.createAccounts(1);
        accts[0].Turnover__c = 0;

        Test.startTest();
        update accts;
        Test.stopTest();

        // Add 1 Order with shipmentCost = 200
        orders = TestDataFactory.createOrders(accts, 1, 200);

        // Add OrderItem with quantity of item = 10 AND price unity = 150 and Update Orders
        // TotalAmount : 10*15 = 1500
        TestDataFactory.createOrderItem(orders, 10, 150);

        Set<Id> setAccountIds = new Set<Id>();
        setAccountIds.add(accts[0].Id);
        List<Account> acctsData = QueriesService.AccountsWithOrders(setAccountIds);
        System.assertEquals(1500, acctsData[0].Turnover__c);
    }

    @isTest
    static void testLaodDataOrders(){
        // Load the test accounts from the static resource
        List<sObject> lOrders = Test.loadData(Order.sObjectType, 'testOrders');
        // Verify that all 3 test accounts were created
        System.assert(lOrders.size() == 5);

        // Get first test account
        for (Integer i = 0; i < lOrders.size(); i++){
            Order lo = (Order) lOrders[0];
            System.debug(lo.NetAmount__c);
        }
    }

}