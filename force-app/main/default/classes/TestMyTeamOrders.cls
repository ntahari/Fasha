@isTest
private class TestMyTeamOrders {
    @isTest 
    static void TestSumOrders() {
        //Add Acounts 
        List<Account> accts = TestDataFactory.createAccounts(1);

        // Add 5 Order with shipmentCost = 0
        List<Order> orders = TestDataFactory.createOrders(accts, 5, 0);
        
        // Add OrderItem with quantity of item = 10 AND price unity = 150 and Update Orders 
        // TotalAmount : 10*15 = 1500
        TestDataFactory.createOrderItem(orders, 10, 150);

        Test.startTest();
        Decimal totalSumOrders = MyTeamOrdersController.sumOrders;
        Test.stopTest();
        System.debug('total des sommes orders: ' + totalSumOrders);

        // total sum orders(7500) = num of orders(5) * totalAmount(1500) 
        System.assertEquals(7500, totalSumOrders);

    }
}
