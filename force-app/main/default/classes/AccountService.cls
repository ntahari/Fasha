public with sharing class AccountService {
    public static void UpdateTurnOver(Set<Id> setAccountsId) {

        //get accounts by Ids with order's status = ordered
        List<Account> accounts = QueriesService.AccountsWithOrders(setAccountsId);
        for (Integer i = 0; i < accounts.size(); i++) {
            Account acc = accounts[i];
            acc.Turnover__c = 0;
            for (Integer j = 0; j < acc.Orders.size(); j++) {
                acc.Turnover__c = acc.Turnover__c + acc.Orders[j].NetAmount__c;
            }
        }
        update accounts;
        System.debug('turnover mclass accountservice: '+ accounts);

    }
}
