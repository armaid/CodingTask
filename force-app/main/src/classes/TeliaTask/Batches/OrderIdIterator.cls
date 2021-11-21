/**
 * Created by Armandas on 2021-11-21.
 */

public class OrderIdIterator implements Iterator<Id>, Iterable<Id>
{
		private List<Id> source;

		public Iterator<Id> iterator()
		{
			return this;
		}

		public OrderIdIterator(List<Id> newSource)
		{
			source = newSource;
		}

		public Id next()
		{
			return source.remove(0);
		}

		public Boolean hasNext()
		{
			return source != null && !source.isEmpty();
		}
}