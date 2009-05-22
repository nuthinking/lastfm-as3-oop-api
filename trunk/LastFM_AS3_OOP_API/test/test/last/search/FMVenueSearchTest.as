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
	import flexunit.framework.TestCase;

	import fm.last.model.FMVenue;
	import fm.last.search.FMVenueSearch;

	import flash.events.Event;

	/**
	 * @author christian
	 */
	public class FMVenueSearchTest extends TestCase 
	{
		public function FMVenueSearchTest(methodName : String = null)
		{
			super(methodName);
		}
		
		public function testExecute () : void
		{
			var s : FMVenueSearch = new FMVenueSearch();
			try{
				s.execute();
				fail("FMVenueSearch shouldn't execute if no term is defined");
			}catch(e:Error){
			}
			s.term = "believe";
			s.addEventListener(Event.COMPLETE, onSearchComplete);
			s.execute(20);
		}
		
		private function onSearchComplete(event : Event) : void
		{
			var s : FMVenueSearch = FMVenueSearch(event.currentTarget);
			assertEquals("FMVenueSearch should return the correct amount of results", 20, s.venues.length);
			var firstVenue : FMVenue = s.venues[0];
			assertEquals("FMVenueSearch should retrieve correctly the first venue id", 8778545, firstVenue.id);
			assertEquals("FMVenueSearch should retrieve correctly the first venue name", "Arena", firstVenue.name);
			assertEquals("FMVenueSearch should retrieve correctly the first venue location country", "Austria", firstVenue.location.country);
			assertEquals("FMVenueSearch should retrieve correctly the first venue url", "http://www.last.fm/venue/8778545", firstVenue.url);
			var lastVenue : FMVenue = s.venues.pop();
			assertEquals("FMVenueSearch should retrieve correctly the last venue id", 8965420, lastVenue.id);
			assertEquals("FMVenueSearch should retrieve correctly the last venue name", "Tesla Arena", lastVenue.name);
			assertEquals("FMVenueSearch should retrieve correctly the last venue location country", "Czech Republic", lastVenue.location.country);
			assertEquals("FMVenueSearch should retrieve correctly the last venue url", "http://www.last.fm/venue/8965420", lastVenue.url);
		}
	}
}
