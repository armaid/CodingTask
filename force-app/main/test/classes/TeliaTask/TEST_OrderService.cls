/**
 * Created by Armandas on 2021-11-21.
 */

@IsTest
public class TEST_OrderService
{

	@IsTest
	static void test_updateRecords()
	{
        insertTestData();

        List<Order> orders =
        [
                SELECT Id,
                Item_Count__c,
                (SELECT Id,Provisioning_Date__c FROM OrderItems)
        FROM Order
        ];
        Integer orderItemCount = [SELECT COUNT() FROM OrderItem];

        Test.startTest();
        OrderService.updateRecords(orders);
        Test.stopTest();

        Integer orderCountResult = [SELECT COUNT() FROM Order WHERE Item_Count__c != NULL];
        Integer orderItemCountResult = [SELECT COUNT() FROM OrderItem WHERE Provisioning_Date__c != NULL];

        System.assertEquals(orders.size(),orderCountResult);
        System.assertEquals(orderItemCount,orderItemCountResult);
	}

	@IsTest
	static void test_updateOrderItems()
	{
        Integer orderItemSize = 20;
        List<Order> orders = new List<Order>{prepareOrder(orderItemSize)};

        List<OrderItem> updatedOrderItems = OrderService.updateOrderItems(orders.get(0).OrderItems);

        for (OrderItem oi : updatedOrderItems)
        {
            System.assertNotEquals(null, oi.Provisioning_Date__c);
        }
	}

	@IsTest
	static void test_updateOrders()
	{
        Integer orderItemSize = 20;
        List<Order> orders = new List<Order>{prepareOrder(orderItemSize)};

        List<Order> updatedOrders = OrderService.updateOrders(orders);

        for (Order o : updatedOrders)
        {
            System.assertEquals(orderItemSize, o.Item_Count__c);
        }
	}

	@IsTest
	static void test_updateOrders_throwException()
	{
        Integer orderItemSize = 21;
        List<Order> orders = new List<Order>{prepareOrder(orderItemSize)};

        try
        {
            OrderService.updateOrders(orders);
        }
        catch (OrchestrationUnrecoverableException e)
        {
            System.assertEquals(OrderService.EXCEPTION_TOOMANYITEMS,e.getMessage());
        }
	}

    public static Order prepareOrder(Integer orderItemSize)
    {
        //Order newOrder = (Order) new sfab_FabricatedSObject(Order.class);
        sfab_FabricatedSObject fabricatedOrder = new sfab_FabricatedSObject(Order.class);
        addOrderItems(fabricatedOrder,orderItemSize);
        //newOrder.OrderItems = orderItems;
        return (Order) fabricatedOrder.toSObject();
    }

    public static void addOrderItems(sfab_FabricatedSObject fabricatedOrder,Integer size)
    {
        for (Integer i = 0; i < size; i++)
        {
            fabricatedOrder.add('OrderItems', new sfab_FabricatedSObject(OrderItem.class));
        }
    }

    public static Order insertTestData()
    {
        Account testAcc = new Account(Name = 'Test Account');
        insert testAcc;

        Product2 product = new Product2(Name = 'Test Product');
        insert product;

        Id pricebookId = Test.getStandardPricebookId();
        PricebookEntry pbe = new PricebookEntry(
                Product2Id = product.Id, Pricebook2Id = pricebookId, UnitPrice = 10, IsActive = true
        );
        insert pbe;

        Order anOrder = new Order(AccountId = testAcc.Id, Pricebook2Id = pricebookId, EffectiveDate = Date.today(), Status = 'Draft');
        insert anOrder;

        OrderItem anOrderItem = new OrderItem(OrderId = anOrder.Id, Product2Id = product.Id, Quantity = 1, UnitPrice = 100, PricebookEntryId = pbe.Id);
        insert anOrderItem;

        return anOrder;
    }
}