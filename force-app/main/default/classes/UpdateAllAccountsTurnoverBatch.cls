global class UpdateAllAccountsTurnoverBatch implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext info){ 
        //Requeter seulement les comptes qui ont au moins une commande avec le Status 'Ordered'
         return Database.getQueryLocator(QueriesService.AllAcountsQueryLocator());
 
    }
     
    global void execute(Database.BatchableContext info, List<Account> scope){
        Set<Id> setAccountIds = (new Map<Id,SObject>(scope)).keySet();
        AccountService.UpdateTurnOver(setAccountIds);
    }    
     
    global void finish(Database.BatchableContext info){     
        
    } 
 }