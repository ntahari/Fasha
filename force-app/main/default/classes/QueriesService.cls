public with sharing class QueriesService {
    public QueriesService() {

    }
    public static String AllAcountsQueryLocator() {
        return 'SELECT Id FROM Account WHERE Id IN (SELECT AccountId FROM Order WHERE status = \'Ordered\')';
    }

    public static List<Account> AccountsList() {
        List<Account> accounts = [SELECT Id, Turnover__c 
        FROM Account 
        WHERE Id IN (SELECT AccountId FROM Order WHERE status = 'Ordered')];
        return accounts;
    }

    public static List<Account> AllAccountsWithOrders() {
        List<Account> accounts = [SELECT Id, Turnover__c, 
        (SELECT TotalAmount,NetAmount__c, ShipmentCost__c, AccountId FROM Orders WHERE status = 'Ordered') 
        FROM Account ];
        return accounts;
    }

    public static List<Order> OrdersByAccountIds(Set<Id> setAccountIds, Integer limitOrder) {
        List<Order> orders = [SELECT Id, TotalAmount, ShipmentCost__c, NetAmount__c, AccountId FROM Order
        WHERE AccountId IN :setAccountIds
        AND Status = 'Ordered'
        LIMIT :limitOrder];
        return orders;
    }

    public static List<Account> AccountsWithOrders(set<Id> setAccountIds) {
        List<Account> accounts = [SELECT Id, Turnover__c, 
        (SELECT TotalAmount,NetAmount__c, ShipmentCost__c, AccountId FROM Orders WHERE status = 'Ordered') 
        FROM Account WHERE Id IN :setAccountIds];
        return accounts;
    }
    


}    



