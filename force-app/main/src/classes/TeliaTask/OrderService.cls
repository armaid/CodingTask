/**
 * Created by Armandas on 2021-11-21.
 */

public class OrderService
{
	public static final String EXCEPTION_TOOMANYITEMS = 'An order has more than 20 items';

	public static void updateRecords(List<Order> orders)
	{
		//Add updated orders to the list
		List<Order> updatedOrders = updateOrders(orders);
		update updatedOrders;

		//Add updated orderItems to the list
		List<OrderItem> updatedOrderItems = new List<OrderItem>();
		for (Order orderToUpdate : orders)
		{
			updatedOrderItems.addAll(updateOrderItems(orderToUpdate.OrderItems));
		}
		update updatedOrderItems;
	}

	@TestVisible
	private static List<Order> updateOrders(List<Order> orders)
	{
		List<Order> updatedOrderList = new List<Order>();
		Order newOrder;

		for (Order orderToUpdate : orders)
		{
			//throw error if order has more than 20 OrderItems
			if (orderToUpdate.OrderItems.size() > 20)
			{
				throw new OrchestrationUnrecoverableException(EXCEPTION_TOOMANYITEMS);
			}

			newOrder = new Order(Id = orderToUpdate.Id);
			newOrder.Item_Count__c = orderToUpdate.OrderItems.size();

			updatedOrderList.add(newOrder);
		}

		return updatedOrderList;
	}

	@TestVisible
	private static List<OrderItem> updateOrderItems(List<OrderItem> orderItems)
	{
		List<OrderItem> updatedOrderItemList = new List<OrderItem>();
		Date currentDate = Date.today();

		for (OrderItem oiToUpdate : orderItems)
		{
			oiToUpdate.Provisioning_Date__c = currentDate;
			updatedOrderItemList.add(oiToUpdate);
		}

		return updatedOrderItemList;
	}
}