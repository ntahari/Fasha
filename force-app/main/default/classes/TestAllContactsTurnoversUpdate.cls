@isTest
private class TestAllContactsTurnoversUpdate {
    @isTest static void testUpdateTurnoverForHundredOrders() {
        List<Account> accts = TestDataFactory.createAccountsWithOrders(1,101);
        // System.debug('comptes: ' + accts);
        // List<Order> orders = [SELECT Id, TotalAmount FROM Order WHERE AccountId = :accts[0].Id];
        // System.debug('Orders total amount: '+ orders[0].TotalAmount);
        // orders[0].ShipmentCost__c = 100;
        // update orders[0];
        
        Test.startTest();
        UpdateAllAccountsTurnoverBatch updateTurnover = new UpdateAllAccountsTurnoverBatch();
        Database.executeBatch(updateTurnover);
        Test.stopTest();

        System.assertEquals(101, [SELECT count() from Order where Status = 'Ordered']);
        // System.assertEquals(100, orders[0].ShipmentCost__c);

    }
}
