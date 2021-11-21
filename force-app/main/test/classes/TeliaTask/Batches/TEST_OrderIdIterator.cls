/**
 * Created by Armandas on 2021-11-21.
 */

@IsTest
private class TEST_OrderIdIterator
{
	@IsTest
	static void testIterator()
	{

		Id id1 = '8019E00000260dnQAA';
		Id id2 = '8019E00000260e4QAA';
		List<Id> idList = new List<Id>{id1,id2};

		OrderIdIterator orderIdIterator = new OrderIdIterator(idList);

		System.assertNotEquals(null,orderIdIterator.iterator());
		System.assertEquals(true,orderIdIterator.hasNext());
		System.assertEquals(id1, orderIdIterator.next());
	}
}