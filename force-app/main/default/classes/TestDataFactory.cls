@isTest
public class TestDataFactory {
    static final Id PRICEBOOK2ID = Test.getStandardPricebookId();
    public static List<Account> createAccountsWithOrders(Integer numAccts, Integer numOrdersPerAcct) {
        
        //Add Acounts 
        List<Account> accts = createAccounts(numAccts);

        // Add a product
        // PricebookEntry pbe = creatProduct(1020);

        // Add Orders with shipmentCost = 100
        List<Order> orders = createOrders(accts, numOrdersPerAcct, 100);

        // Add OrderItem with quantity of item = 10 AND price unity = 150 and Update Orders 
        createOrderItem(orders, 10, 150);

        return accts;

    }

    public static List<Account> createAccounts(Integer numAccts) {
        List<Account> accts = new List<Account>();
        for(Integer i=0;i<numAccts;i++) {
            Account a = new Account(Name='TestAccount' + i);
            accts.add(a);
        }
        insert accts;
        return accts;
    }
    
    //Create Orders
    public static List<Order> createOrders(List<Account> accts, Integer numOfOrders, Integer shipmentCost) {
        List<Order> orders = new List<Order>();
        for (Integer i=0;i<accts.size();i++) {
            Account acct = accts[i];

            // For each account just inserted, add contract
            Contract con = new Contract(
                AccountId = acct.Id,
                Status = 'Draft',
                StartDate = System.today(),
                ContractTerm = 3
            );
            insert con;
            con.Status = 'Activated';
            update con;

            // For each account just inserted, add orders
            for (Integer j=0;j<numOfOrders;j++) {
                orders.add(new Order(AccountId = acct.Id,
                                    ContractId = con.Id,
                                    EffectiveDate= System.today(),
                                    Status = 'Draft',
                                    ShipmentCost__c = ShipmentCost,
                                    Pricebook2Id = PRICEBOOK2ID));  
                
            }
        }
        // Insert all orders for all accounts.
        insert orders;
        return orders;
    }

    // create order Item 
    public static void createOrderItem(List<Order> orders, Integer quantity, Integer unitPrice) {
        PricebookEntry pbe = creatProduct(1020);
        for (Integer i = 0; i < orders.size(); i++) {
            Order ord = orders[i];
            ord.Status = 'Ordered';
            // Create an order item
            OrderItem oi1 = new OrderItem (OrderId = ord.Id, 
            PricebookEntryId = pbe.Id, 
            Quantity = quantity, 
            UnitPrice = unitPrice);
            insert oi1;
            System.debug('quantity ordersItem: ' + oi1.Quantity);
            System.debug('unite price ordersItem: ' + oi1.UnitPrice);
        }
        update orders;
        System.debug('total amount : ' + orders[0].TotalAmount);
    }
    
    // Create a product with PricebookEntry

    public static PricebookEntry creatProduct (Integer unitPrice){
    Product2 pd1 = new Product2(Name = 'Chemise Verte longue XYX', Family = 'Chemise');
    insert pd1;
    //Create the PricebookEntry
    PricebookEntry pbe = new PricebookEntry(
        Pricebook2Id = PRICEBOOK2ID,
        Product2Id = pd1.Id,
        UnitPrice = unitPrice,
        IsActive = true
    );
    insert pbe;
    return pbe;
   }

  
}