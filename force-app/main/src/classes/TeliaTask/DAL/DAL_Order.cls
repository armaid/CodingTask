/**
 * Created by Armandas on 2021-11-21.
 */

public class DAL_Order
{
	public static List<Order> getOrdersWithOrderItemsByIds(List<Id> orderIdList)
	{
		List<Order> orders =
		[
				SELECT Id,
						Item_Count__c,
						(SELECT Id,Provisioning_Date__c FROM OrderItems)
				FROM Order
				WHERE Id IN :orderIdList
		];

		return orders;
	}
}