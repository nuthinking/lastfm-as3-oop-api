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
{	import fm.last.model.FMArtist;
	import fm.last.enum.FMImageSizeType;
	import fm.last.model.FMAlbum;
	import fm.last.model.FMTag;

	import test.last.model.FMModelTest;

	import flash.events.Event;

	/**	 * @author christian	 */	public class FMAlbumTest extends FMModelTest 
	{
		[Embed("../../../data/constructors/album.xml", mimeType="application/octet-stream")]
      	private static const CONSTRUCTOR_XML_CLASS:Class;
      			public function FMAlbumTest(methodName : String = null)
		{			super(methodName);		}
		
		public function testCreateFromXML () : void
		{
			var a : FMAlbum = FMAlbum.createFromXML(getEmbeddedXML(CONSTRUCTOR_XML_CLASS));
			assertEquals("createFromXML should set the album name", "Make Believe", a.name);
			assertEquals("createFromXML should set the album artist", "Weezer", a.artist.name);
			assertEquals("createFromXML should set the album id", "2025180", a.id);
			assertEquals("createFromXML should set the album url", "http://www.last.fm/music/Weezer/Make+Believe", a.url);
			assertEquals("createFromXML should set the album image small", "http://userserve-ak.last.fm/serve/34s/8673675.jpg", a.getImageUrlBySize(FMImageSizeType.SMALL));
			assertEquals("createFromXML should set the album image large", "http://userserve-ak.last.fm/serve/126/8673675.jpg", a.getImageUrlBySize(FMImageSizeType.LARGE));
			assertEquals("createFromXML should set the album streamable", true, a.streamable);
		}
		
		public function testGetInfo() : void
		{
			var a : FMAlbum = new FMAlbum();
			a.artist = new FMArtist("Cher");
			try{
				a.getInfo();
				fail("FMAlbum.getInfo should fire an error if only artist is defined");
			}catch(e:Error){
				
			}
			a = new FMAlbum("Believe");
			try{
				a.getInfo();
				fail("FMAlbum.getInfo should fire an error if only name is defined");
			}catch(e:Error){
				
			}
			a.artist = new FMArtist("Cher");
			a.addEventListener(FMAlbum.GET_INFO, onInfoLoaded);
		}
		
		private function onInfoLoaded(event : Event) : void
		{
			var a : FMAlbum = FMAlbum(event.currentTarget);
			assertEquals("FMAlbum.getInfo should set album id", "2026126", a.id);
			assertEquals("FMAlbum.getInfo should set album release date", "6 Apr 1999, 00:00", a.releaseDateRaw);
			assertEquals("FMAlbum.getInfo should set album listeners", 106110, a.listeners);
			assertEquals("FMAlbum.getInfo should set album playCount", 419291, a.playCount);
			assertEquals("FMAlbum.getInfo should set album top tags", 5, a.topTags.length);
			var firstTag : FMTag = a.topTags[0];
			assertEquals("FMAlbum.getInfo should set the first album top tag name", "pop", firstTag.name);
			assertEquals("FMAlbum.getInfo should set the first album top tag url", "http://www.last.fm/tag/pop", firstTag.url);
			var lastTag : FMTag = a.topTags.pop();
			assertEquals("FMAlbum.getInfo should set the last album top tag name", "albums i own", lastTag.name);
			assertEquals("FMAlbum.getInfo should set the last album top tag url", "http://www.last.fm/tag/albums%20i%20own", lastTag.url);
			assertEquals("FMAlbum.getInfo should set album info publish date", "Sun, 27 Jul 2008 15:55:58 +0000", a.info.publishedDateRaw);
			assertContained("FMAlbum.getInfo should set album info summary", "Records at the end of 1998.", a.info.summary);
			assertNotContained("FMAlbum.getInfo should set album info summary", "The album featured a change in Cher's music", a.info.summary);
			assertContained("FMAlbum.getInfo should set album info content", "The album featured a change in Cher's music", a.info.content);
		}
	}}