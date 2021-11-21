/**
 * Created by Armandas on 2021-11-21.
 */

public class AssetManagementTask implements OrchestrationTask
{
	public static final Integer MAXSIZE_ORDER = 470;

	public void executeBatch(List<Id> orderIdList)
	{
		OrderIdIterator orderIdIterator = new OrderIdIterator(orderIdList);
		BATCH_OrderBatch orderBatch = new BATCH_OrderBatch(orderIdIterator);
		Database.executeBatch(orderBatch, MAXSIZE_ORDER);
	}
}