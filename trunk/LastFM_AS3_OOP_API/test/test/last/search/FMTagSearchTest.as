/**
 *  This file is part of LastMF AS3 OOP API.
 *  
 *  http://code.google.com/p/lastfm-as3-oop-api/
 *
 *  LastMF AS3 OOP API is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  LastMF AS3 OOP API is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with LastMF AS3 OOP API.  If not, see <http://www.gnu.org/licenses/>.
 *  
 *  @author Christian Giordano for Tonic.co.uk
 *
 */
package test.last.search 
{
	import fm.last.model.FMTag;
	import flash.events.Event;

	import fm.last.search.FMTagSearch;
	import flexunit.framework.TestCase;
	
	/**
	 * @author christian
	 */
	public class FMTagSearchTest extends TestCase 
	{
		public function FMTagSearchTest(methodName : String = null)
		{
			super(methodName);
		}
		
		public function testExecute () : void
		{
			var s : FMTagSearch = new FMTagSearch();
			try{
				s.execute();
				fail("if no term is defined, execute should throw an error");
			}catch(e:Error){
			}
			s.term = "rock";
			s.addEventListener(Event.COMPLETE, onSearchComplete);
			s.execute(20);
		}
		
		private function onSearchComplete(event : Event) : void
		{
			var s : FMTagSearch = FMTagSearch(event.currentTarget);
			assertEquals("FMTagSearch should return the correct amount of results", 20, s.tags.length);
			var firstTag : FMTag = s.tags[0];
			assertEquals("FMTagSearch should retrieve correctly the first tag", "disco", firstTag.name);
			assertEquals("FMTagSearch should retrieve correctly the first count", 75404, firstTag.count);
			var lastTag : FMTag = s.tags.pop();
			assertEquals("FMTagSearch should retrieve correctly the last tag", "electro disco", lastTag.name);
			assertEquals("FMTagSearch should retrieve correctly the last count", 723, lastTag.count);
		}
	}
}
