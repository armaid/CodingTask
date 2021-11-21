/**
 * Created by Armandas on 2021-11-21.
 */

public class BATCH_OrderBatch implements Database.Batchable<Object>
{
	public static final String MESSAGE_SUCCESS = 'Order batch finished successfully';
	OrderIdIterator orderIdIterator;

	public BATCH_OrderBatch(OrderIdIterator newOrderIdIterator)
	{
		orderIdIterator = newOrderIdIterator;
	}

	public void execute(Database.BatchableContext BC, List<Object> orderIds)
	{
		List<Order> orders = DAL_Order.getOrdersWithOrderItemsByIds( (List<Id>) orderIds);

		OrderService.updateRecords(orders);
	}

	public void finish(Database.BatchableContext param1)
	{
		System.debug(LoggingLevel.INFO, MESSAGE_SUCCESS);
	}

	public Iterable<Object> start(Database.BatchableContext param1)
	{
		return (Iterable<Object>) orderIdIterator;
	}
}