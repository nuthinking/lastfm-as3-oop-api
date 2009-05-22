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

	import fm.last.model.FMTrack;
	import fm.last.search.FMTrackSearch;

	import flash.events.Event;

	/**
	 * @author christian
	 */
	public class FMTrackSearchTest extends TestCase 
	{
		public function FMTrackSearchTest(methodName : String = null)
		{
			super(methodName);
		}
		
		public function testExecute () : void
		{
			var s : FMTrackSearch = new FMTrackSearch();
			try{
				s.execute();
				fail("if no term is defined, execute should throw an error");
			}catch(e:Error){
			}
			s.term = "believe";
			s.addEventListener(Event.COMPLETE, onSearchComplete);
			s.execute(20);
		}
		
		private function onSearchComplete(event : Event) : void
		{
			var s : FMTrackSearch = FMTrackSearch(event.currentTarget);
			assertEquals("FMTrackSearch should return the correct amount of results", 20, s.tracks.length);
			var firstTrack : FMTrack = s.tracks[0];
			assertEquals("FMTrackSearch should retrieve correctly the first track name", "Believe Me Natalie", firstTrack.name);
			assertEquals("FMTrackSearch should retrieve correctly the first track artist name", "The Killers", firstTrack.artist.name);
			assertEquals("FMTrackSearch should retrieve correctly the first track listeners", 346001, firstTrack.listeners);
			var lastTrack : FMTrack = s.tracks.pop();
			assertEquals("FMTrackSearch should retrieve correctly the last track name", "Make Me Believe", lastTrack.name);
			assertEquals("FMTrackSearch should retrieve correctly the last track artist name", "Godsmack", lastTrack.artist.name);
			assertEquals("FMTrackSearch should retrieve correctly the last track listeners", 56464, lastTrack.listeners);
		}
	}
}
