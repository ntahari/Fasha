public with sharing class MyTeamOrdersController {
    public static decimal sumOrders{
        get{
			AggregateResult groupedResults = 
            [SELECT SUM(TotalAmount) total FROM Order 
            WHERE Status = 'ordered'];
			return (decimal)groupedResults.get('total');

        }
        set;
    }
}