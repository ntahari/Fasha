global class UpdateAccountCA implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext info){ 
        //Requeter seulement les comptes qui ont au moins une commande avec le Status 'Ordered'
        return Database.getQueryLocator('SELECT Id, (SELECT TotalAmount FROM Order WHERE Status = \'Ordered\') FROM Account');
 
    }
     
    global void execute(Database.BatchableContext info, List<Account> scope){ 

    }    
     
    global void finish(Database.BatchableContext info){     
        
    } 
 }