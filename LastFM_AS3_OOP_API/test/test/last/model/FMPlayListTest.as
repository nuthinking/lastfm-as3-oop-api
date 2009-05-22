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
package test.last.model 
{	import fm.last.enum.FMImageSizeType;
	import fm.last.model.FMPlayList;
	import fm.last.model.FMTrack;

	import test.last.model.FMModelTest;

	import flash.events.Event;

	/**	 * @author christian	 */	public class FMPlayListTest extends FMModelTest 
	{		public function FMPlayListTest(methodName : String = null)
		{			super(methodName);		}
		
		public function testFetch () : void
		{
			var o : FMPlayList = new FMPlayList();
			try{
				o.fetch();
				fail("Playlist shouldn't be able to fetch if url is not defined");
			}catch( e : Error ) {};
			o.url ="http....";
			o.addEventListener(FMPlayList.FETCH, onFetched);
			o.fetch();
		}
		
		private function onFetched(event : Event) : void
		{
			var o : FMPlayList = FMPlayList(event.currentTarget);
			assertEquals("FMPlayList.fetch should set the playlist title", "Cher - Believe", o.title);
			assertEquals("FMPlayList.fetch should set the playlist annotation", "Previews for Cher - Believe", o.annotation);
			assertEquals("FMPlayList.fetch should set the playlist creator", "http://www.last.fm/music/Cher/Believe", o.creator);
			assertEquals("FMPlayList.fetch should set the playlist dateraw", "2009-05-08T09:13:20", o.dateRaw);
			assertEquals("FMPlayList.fetch should set the playlist trackList tracks", 10, o.trackList.length);
			var firstTrack : FMTrack = o.trackList[0];
			assertEquals("FMPlayList.fetch should set the first track name", "Believe", firstTrack.name);
			assertEquals("FMPlayList.fetch should set the first track url", "http://www.last.fm/music/Cher/_/Believe", firstTrack.url);
			assertEquals("FMPlayList.fetch should set the first track artist name", "Cher", firstTrack.artist.name);
			assertEquals("FMPlayList.fetch should set the first track duration", 222000, firstTrack.duration);
			assertEquals("FMPlayList.fetch should set the first track image large", "http://userserve-ak.last.fm/serve/126/8674593.jpg", firstTrack.getImageUrlBySize(FMImageSizeType.LARGE));
		}
	}}