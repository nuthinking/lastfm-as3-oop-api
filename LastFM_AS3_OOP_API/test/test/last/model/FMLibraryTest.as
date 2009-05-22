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
{	import fm.last.model.FMTrack;
	import fm.last.enum.FMImageSizeType;
	import fm.last.model.FMArtist;
	import fm.last.model.FMAlbum;
	import fm.last.model.FMLibrary;
	import fm.last.model.FMUser;

	import test.last.model.FMModelTest;

	import flash.events.Event;

	/**	 * @author christian	 */	public class FMLibraryTest extends FMModelTest 
	{		public function FMLibraryTest(methodName : String = null)
		{			super(methodName);		}
		
		public function testGetAlbums () : void
		{
			var o : FMLibrary = new FMLibrary();
			try{
				o.getAlbums();
				fail("Library shouldn't be able to get albums if user is not defined");
			}catch ( e: Error){}
			o.user = new FMUser();
			try{
				o.getAlbums();
				fail("Library shouldn't be able to get albums if user name is not defined");
			}catch ( e: Error){}
			o.user.name = "user";
			try{
				o.getAlbums(0);
				fail("Library shouldn't be able to get albums if limit is <= 0");
			}catch ( e: Error){}
			o.addEventListener(FMLibrary.GET_ALBUMS, onAlbumsLoaded);
			o.getAlbums(75);
		}

		private function onAlbumsLoaded ( event : Event ) : void
		{
			var o : FMLibrary = FMLibrary(event.currentTarget);
			assertEquals("FMLibrary should get the correct amount of albums", 75, o.albums.length);
			var firstAlbum : FMAlbum = o.albums[0];
			assertEquals("FMLibrary should set the first album name", "Gold", firstAlbum.name);
			assertEquals("FMLibrary should set the first album playCount", 451, firstAlbum.playCount);
			assertTrue("FMLibrary should set the first album tagCount", isNaN(firstAlbum.tagCount));
			assertEquals("FMLibrary should set the first album artist name", "Komet", firstAlbum.artist.name);
			assertEquals("FMLibrary should set the first album image small", "http://userserve-ak.last.fm/serve/34s/23854105.png", firstAlbum.getImageUrlBySize(FMImageSizeType.SMALL));
			var otherAlbum : FMAlbum = o.albums[5];
			assertEquals("FMLibrary should set the other album name", "LOVEBEAT", otherAlbum.name);
			assertEquals("FMLibrary should set the other album playCount", 167, otherAlbum.playCount);
			assertEquals("FMLibrary should set the other album tagCount", 1, otherAlbum.tagCount);
			assertEquals("FMLibrary should set the other album artist name", "砂原良徳", otherAlbum.artist.name);
			assertEquals("FMLibrary should set the other album image small", "http://userserve-ak.last.fm/serve/34s/12991485.jpg", otherAlbum.getImageUrlBySize(FMImageSizeType.SMALL));
		}
		
		public function testGetArtists () : void
		{
			var o : FMLibrary = new FMLibrary();
			try{
				o.getArtists();
				fail("Library shouldn't be able to get artists if user is not defined");
			}catch ( e: Error){}
			o.user = new FMUser();
			try{
				o.getArtists();
				fail("Library shouldn't be able to get artists if user name is not defined");
			}catch ( e: Error){}
			o.user.name = "user";
			try{
				o.getArtists(0);
				fail("Library shouldn't be able to get artists if limit is <= 0");
			}catch ( e: Error){}
			o.addEventListener(FMLibrary.GET_ARTISTS, onArtistsLoaded);
			o.getArtists(75);
		}
		
		private function onArtistsLoaded ( event : Event ) : void
		{
			var o : FMLibrary = FMLibrary(event.currentTarget);
			assertEquals("FMLibrary should get the correct amount of artists", 75, o.artists.length);
			var firstArtist : FMArtist = o.artists[0];
			assertEquals("FMLibrary should set the first artist name", "Fennesz", firstArtist.name);
			assertEquals("FMLibrary should set the first artist playCount", 1041, firstArtist.playCount);
			assertTrue("FMLibrary should set the first artist tagCount", isNaN(firstArtist.tagCount));
			assertEquals("FMLibrary should set the first artist streamable", true, firstArtist.streamable);
			assertEquals("FMLibrary should set the first artist image small", "http://userserve-ak.last.fm/serve/34/388319.jpg", firstArtist.getImageUrlBySize(FMImageSizeType.SMALL));
			var otherArtist : FMArtist = o.artists[2];
			assertEquals("FMLibrary should set the other artist name", "SND", otherArtist.name);
			assertEquals("FMLibrary should set the other artist playCount", 650, otherArtist.playCount);
			assertEquals("FMLibrary should set the other artist tagCount", 1, otherArtist.tagCount);
			assertEquals("FMLibrary should set the other artist streamable", true, otherArtist.streamable);
			assertEquals("FMLibrary should set the other artist image small", "http://userserve-ak.last.fm/serve/34/6109703.jpg", otherArtist.getImageUrlBySize(FMImageSizeType.SMALL));
		}
		
		public function testGetTracks () : void
		{
			var o : FMLibrary = new FMLibrary();
			try{
				o.getTracks();
				fail("Library shouldn't be able to get tracks if user is not defined");
			}catch ( e: Error){}
			o.user = new FMUser();
			try{
				o.getTracks();
				fail("Library shouldn't be able to get tracks if user name is not defined");
			}catch ( e: Error){}
			o.user.name = "user";
			try{
				o.getTracks(0);
				fail("Library shouldn't be able to get tracks if limit is <= 0");
			}catch ( e: Error){}
			o.addEventListener(FMLibrary.GET_TRACKS, onTracksLoaded);
			o.getTracks(75);
		}
		
		private function onTracksLoaded ( event : Event ) : void
		{
			var o : FMLibrary = FMLibrary(event.currentTarget);
			assertEquals("FMLibrary should get the correct amount of tracks", 75, o.tracks.length);
			var firstTrack : FMTrack = o.tracks[0];
			assertEquals("FMLibrary should set the first track name", "Let It Rock", firstTrack.name);
			assertEquals("FMLibrary should set the first track playCount", 155, firstTrack.playCount);
			assertEquals("FMLibrary should set the first track tagCount", 1, firstTrack.tagCount);
			assertEquals("FMLibrary should set the first track streamable", true, firstTrack.streamable);
			assertEquals("FMLibrary should set the first track streamableAsFullTrack", true, firstTrack.streamableAsFullTrack);
			assertEquals("FMLibrary should set the first track image small", null, firstTrack.getImageUrlBySize(FMImageSizeType.SMALL));
			assertEquals("FMLibrary should set the first track artist name", "Kid606", firstTrack.artist.name);
			var otherTrack : FMTrack = o.tracks[2];
			assertEquals("FMLibrary should set the other track name", "Blau", otherTrack.name);
			assertEquals("FMLibrary should set the other track playCount", 95, otherTrack.playCount);
			assertTrue("FMLibrary should set the other track tagCount", isNaN(otherTrack.tagCount));
			assertEquals("FMLibrary should set the other track streamable", true, otherTrack.streamable);
			assertEquals("FMLibrary should set the other track streamableAsFullTrack", false, otherTrack.streamableAsFullTrack);
			assertEquals("FMLibrary should set the other artist image small", "http://userserve-ak.last.fm/serve/34s/23854105.png", otherTrack.getImageUrlBySize(FMImageSizeType.SMALL));
			assertEquals("FMLibrary should set the other track artist name", "Komet", otherTrack.artist.name);
		}
	}}