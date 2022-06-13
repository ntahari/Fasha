@isTest
private class TestAllContactsTurnoversUpdate {
    @isTest 
    static void testUpdateTurnoverForMoreHundredOrders() {
        TestDataFactory.createAccountsWithOrders(1,101);

        List<Account> accts = QueriesService.AllAccountsWithOrders();
        Account acct = accts[0];
        List<Order> orders = new List<Order>();
        // update orders befor calcul Turnover
        for (Integer i = 0; i < acct.Orders.size(); i++) {
            Order ord = acct.Orders[i];
            ord.ShipmentCost__c = 500;
            orders.add(ord);
        }
        
        Test.startTest();
        update orders;
        UpdateAllAccountsTurnoverBatch updateTurnover = new UpdateAllAccountsTurnoverBatch();
        Database.executeBatch(updateTurnover);
        Test.stopTest();

        List<Account> acctsUpdatedTurnover = QueriesService.AllAccountsWithOrders();
        System.assertEquals(101, acctsUpdatedTurnover[0].orders.size());

        System.assertEquals(1000*101, acctsUpdatedTurnover[0].Turnover__c);

    }
}
