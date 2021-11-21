/**
 * Created by Armandas on 2021-11-21.
 */

@IsTest
public class TEST_AssetManagementTask
{
	@IsTest
	static void test_executeBatch()
	{
		List<Id> orderIds = new List<Id>{TEST_OrderService.insertTestData().Id};

		Integer orderItemCount = [SELECT COUNT() FROM OrderItem];
		Integer orderCount = [SELECT COUNT() FROM Order];

		Test.startTest();
		AssetManagementTask task = new AssetManagementTask();
		task.executeBatch(orderIds);
		Test.stopTest();

		Integer orderCountResult = [SELECT COUNT() FROM Order WHERE Item_Count__c != NULL];
		Integer orderItemCountResult = [SELECT COUNT() FROM OrderItem WHERE Provisioning_Date__c != NULL];

		System.assertEquals(orderCount,orderCountResult);
		System.assertEquals(orderItemCount,orderItemCountResult);
	}
}