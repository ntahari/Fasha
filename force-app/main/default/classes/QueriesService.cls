public with sharing class QueriesService {
    public QueriesService() {

    }
    public static String AllAcountsWithOrders() {
        return 'SELECT Id FROM Account WHERE Id IN (SELECT AccountId FROM Order WHERE status = \'Ordered\')';
    }
    
    public static List<Account> AccountsWithOrders(set<Id> setAccountIds) {
        List<Account> accounts = [SELECT Id, Turnover__c, 
        (SELECT TotalAmount, AccountId FROM Orders WHERE status = 'Ordered') 
        FROM Account WHERE Id IN :setAccountIds];
        return accounts;
    }

    public static List<Order> OrdersByAccountIds(Set<Id> setAccountIds, Integer limitOrder) {
        List<Order> orders = [SELECT Id, TotalAmount, ShipmentCost__c, NetAmount__c, AccountId FROM Order
        WHERE AccountId IN :setAccountIds
        AND Status = 'Ordered'
        LIMIT :limitOrder];
        return orders;
    }

}    



