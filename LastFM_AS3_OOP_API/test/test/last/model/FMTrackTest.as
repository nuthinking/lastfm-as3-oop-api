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
{	import fm.last.model.FMUser;
	import fm.last.enum.FMImageSizeType;
	import fm.last.model.FMArtist;
	import fm.last.model.FMTag;
	import fm.last.model.FMTrack;

	import flash.events.Event;

	/**	 * @author christian	 */	public class FMTrackTest extends FMModelTest 
	{
		[Embed("../../../data/constructors/track.xml", mimeType="application/octet-stream")]
      	private static const CONSTRUCTOR_XML_CLASS:Class;
      			public function FMTrackTest(methodName : String = null)
		{			super(methodName);		}
		
		public function testCreateFromXML() : void
		{
			var t : FMTrack = FMTrack.createFromXML(getEmbeddedXML(CONSTRUCTOR_XML_CLASS));
			assertEquals("createFromXML should set track rank", 1, t.rank);
			assertEquals("createFromXML should set track name", "Viva la Vida", t.name);
			assertEquals("createFromXML should set track playcount", 925, t.playCount);
			assertEquals("createFromXML should set track mbid", "", t.mbid);
			assertEquals("createFromXML should set track url", "http://www.last.fm/music/Coldplay/_/Viva+la+Vida", t.url);
			assertEquals("createFromXML should set track streamable", true, t.streamable);
			assertEquals("createFromXML should set track streamable fulltrack", true, t.streamableAsFullTrack);
			assertEquals("createFromXML should set track artist", "Coldplay", t.artist.name);
			assertEquals("createFromXML should set track image", "http://userserve-ak.last.fm/serve/34s/14349365.jpg", t.getImageUrlBySize(FMImageSizeType.SMALL));
		}
		
		public function testGetInfo () : void
		{
			var t : FMTrack = new FMTrack("Believe");
			try{
				t.getInfo();
				fail("FMTrack can't getInfo if only the name is provided");
			}catch(e : Error){}
			
			t = new FMTrack();
			t.artist = new FMArtist("Cher");
			try{
				t.getInfo();
				fail("FMTrack can't getInfo if only the artist is provided");
			}catch(e : Error){
			}
			t.name = "Believe";
			t.addEventListener(FMTrack.GET_INFO, onInfoLoaded);
			t.getInfo();
		}
		private function onInfoLoaded ( event : Event ) : void
		{
			var o : FMTrack = FMTrack(event.currentTarget);
			assertEquals("FMTrack.getInfo should set track id", 1019817, o.id);
			assertEquals("FMTrack.getInfo should set track duration", 222000, o.duration);
			assertEquals("FMTrack.getInfo should set track listeners", 112422, o.listeners);
			assertEquals("FMTrack.getInfo should set track playCount", 425165, o.playCount);
			assertEquals("FMTrack.getInfo should set track artist mbid", "bfcc6d75-a6a5-4bc6-8282-47aec8531818", o.artist.mbid);
			assertEquals("FMTrack.getInfo should set track album mbid", "61bf0388-b8a9-48f4-81d1-7eb02706dfb0", o.album.mbid);
			assertEquals("FMTrack.getInfo should set track topTags", 5, o.topTags.length);
			var firstTag : FMTag = o.topTags[0];
			assertEquals("FMTrack.getInfo should set track the first topTags", "pop", firstTag.name);
			var lastTag : FMTag = o.topTags.pop();
			assertEquals("FMTrack.getInfo should set track the last topTags", "female vocalists", lastTag.name);
			assertEquals("FMTrack.getInfo should set track info publish date", "Sun, 27 Jul 2008 15:44:58 +0000", o.info.publishedDateRaw);
			assertContained("FMTrack.getInfo should set track info publish summary", "The song is featured on the Karaoke Revolution video game", o.info.summary);
			assertNotContained("FMTrack.getInfo should set track info publish summary", "In March 2007, the United World Chart ranked", o.info.summary);
			assertContained("FMTrack.getInfo should set track info publish content", "In March 2007, the United World Chart ranked", o.info.content);
		}
		
		public function testGetSimilar () : void
		{
			var t : FMTrack = new FMTrack("Believe");
			try{
				t.getSimilar();
				fail("FMTrack can't getSimilar if only the name is provided");
			}catch(e : Error){}
			
			t = new FMTrack();
			t.artist = new FMArtist("Cher");
			try{
				t.getSimilar();
				fail("FMTrack can't getSimilar if only the artist is provided");
			}catch(e : Error){
			}
			t.name = "Believe";
			t.addEventListener(FMTrack.GET_SIMILAR, onSimilarLoaded);
			t.getSimilar();
		}
		
		private function onSimilarLoaded ( event : Event ) : void
		{
			var o : FMTrack = FMTrack(event.currentTarget);
			assertTrue("FMTrack.getSimilar should return some tracks", o.similar != null && o.similar.length>0);
			var firstTrack : FMTrack = o.similar[0];
			assertEquals("FMTrack.getSimilar should set the first similar track name", "Ray of Light", firstTrack.name);
			assertEquals("FMTrack.getSimilar should set the first similar track match", 10.95, firstTrack.match);
			assertEquals("FMTrack.getSimilar should set the first similar track artist name", "Madonna", firstTrack.artist.name);
			var lastTrack : FMTrack = o.similar.pop();
			assertEquals("FMTrack.getSimilar should set the last similar track name", "Everything Changes", lastTrack.name);
			assertEquals("FMTrack.getSimilar should set the last similar track match", 3.11, lastTrack.match);
			assertEquals("FMTrack.getSimilar should set the last similar track artist name", "Take That", lastTrack.artist.name);
		}
		
		public function testGetTopFans () : void
		{
			var t : FMTrack = new FMTrack("Believe");
			try{
				t.getTopFans();
				fail("FMTrack can't getTopFans if only the name is provided");
			}catch(e : Error){}
			
			t = new FMTrack();
			t.artist = new FMArtist("Cher");
			try{
				t.getTopFans();
				fail("FMTrack can't getTopFans if only the artist is provided");
			}catch(e : Error){
			}
			t.name = "Believe";
			t.addEventListener(FMTrack.GET_TOP_FANS, onTopFansLoaded);
			t.getTopFans();
		}
		
		private function onTopFansLoaded ( event : Event ) : void
		{
			var o : FMTrack = FMTrack(event.currentTarget);
			assertTrue("FMTrack.getTopFans should return some users", o.topFans != null && o.topFans.length > 0);
			var firstFan : FMUser = o.topFans[0];
			assertEquals("FMTrack.getTopFans should set the first fan name", "luka622", firstFan.name);
			assertEquals("FMTrack.getTopFans should set the first fan url", "http://www.last.fm/user/luka622", firstFan.url);
			assertEquals("FMTrack.getTopFans should set the first fan image small", "http://userserve-ak.last.fm/serve/34/20982437.jpg", firstFan.getImageUrlBySize(FMImageSizeType.SMALL));
			assertEquals("FMTrack.getTopFans should set the first fan weight", 360000, firstFan.weight);
			var lastFan : FMUser = o.topFans.pop();
			assertEquals("FMTrack.getTopFans should set the last fan name", "dreamarie", lastFan.name);
			assertEquals("FMTrack.getTopFans should set the last fan url", "http://www.last.fm/user/dreamarie", lastFan.url);
			assertEquals("FMTrack.getTopFans should set the last fan image small", null, lastFan.getImageUrlBySize(FMImageSizeType.SMALL));
			assertEquals("FMTrack.getTopFans should set the last fan weight", 7272, lastFan.weight);
		}
		
		public function testGetTopTags () : void
		{
			var t : FMTrack = new FMTrack("Believe");
			try{
				t.getTopTags();
				fail("FMTrack can't getTopTags if only the name is provided");
			}catch(e : Error){}
			
			t = new FMTrack();
			t.artist = new FMArtist("Cher");
			try{
				t.getTopTags();
				fail("FMTrack can't getTopTags if only the artist is provided");
			}catch(e : Error){
			}
			t.name = "Believe";
			t.addEventListener(FMTrack.GET_TOP_TAGS, onTopTagsLoaded);
			t.getTopTags();
		}
		
		private function onTopTagsLoaded ( event : Event ) : void
		{
			var o : FMTrack = FMTrack(event.currentTarget);
			assertTrue("FMTrack.getTopTags should return some tags", o.topTags != null && o.topTags.length>0);
			var firstTag : FMTag = o.topTags[0];
			assertEquals("FMTrack.getTopTags should return the first tag name", "pop", firstTag.name);
			assertEquals("FMTrack.getTopTags should return the first tag url", "http://www.last.fm/tag/pop", firstTag.url);
			assertEquals("FMTrack.getTopTags should return the first tag count", 100, firstTag.count);
			var lastTag : FMTag = o.topTags.pop();
			assertEquals("FMTrack.getTopTags should return the last tag name", "sexy", lastTag.name);
			assertEquals("FMTrack.getTopTags should return the last tag url", "http://www.last.fm/tag/sexy", lastTag.url);
			assertEquals("FMTrack.getTopTags should return the last tag count", 0, lastTag.count);
		}
	}}