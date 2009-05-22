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
	import fm.last.model.FMTag;
	import fm.last.model.FMUser;
	import fm.last.enum.FMImageSizeType;
	import fm.last.model.FMAlbum;
	import fm.last.model.FMArtist;
	import fm.last.model.FMEvent;
	import fm.last.model.vo.FMImage;
	import fm.last.model.vo.FMShout;

	import test.last.model.FMModelTest;

	import flash.events.Event;

	/**	 * @author christian	 */	public class FMArtistTest extends FMModelTest 
	{
		[Embed("../../../data/constructors/artist.xml", mimeType="application/octet-stream")]
      	private static const CONSTRUCTOR_XML_CLASS:Class;
      			public function FMArtistTest(methodName : String = null)
		{			super(methodName);		}
		
		public function testCreateFromXML () : void
		{
			var a : FMArtist = FMArtist.createFromXML(getEmbeddedXML(CONSTRUCTOR_XML_CLASS));
			assertEquals("createFromXML should set artist name", "Cher", a.name);
			assertEquals("createFromXML should set artist mbid", "bfcc6d75-a6a5-4bc6-8282-47aec8531818", a.mbid);
			assertEquals("createFromXML should set artist url", "http://www.last.fm/music/Cher", a.url);
			assertEquals("createFromXML should set artist image small", "http://userserve-ak.last.fm/serve/34/13638451.jpg", a.getImageUrlBySize(FMImageSizeType.SMALL));
			assertEquals("createFromXML should set artist image medium", "http://userserve-ak.last.fm/serve/64/13638451.jpg", a.getImageUrlBySize(FMImageSizeType.MEDIUM));
			assertEquals("createFromXML should set artist image large", "http://userserve-ak.last.fm/serve/126/13638451.jpg", a.getImageUrlBySize(FMImageSizeType.LARGE));
			assertEquals("createFromXML should set artist streamable", true, a.streamable);
			assertEquals("createFromXML should set artist listeners", 373372, a.listeners);
			assertEquals("createFromXML should set artist playcount", 3021008, a.playCount);
			assertEquals("createFromXML should set artist similar", 5, a.similar.length);
			var similarArtist : FMArtist = a.similar[0];
			assertEquals("createFromXML should set artist similar name", "Sonny & Cher", similarArtist.name);
			assertEquals("createFromXML should set artist similar listeners", NaN, similarArtist.listeners);
			assertEquals("createFromXML should set artist similar playcount", NaN, similarArtist.playCount);
			assertEquals("createFromXML should set artist similar image small", "http://userserve-ak.last.fm/serve/34/4987379.jpg", similarArtist.getImageUrlBySize(FMImageSizeType.SMALL));
			similarArtist = a.similar[a.similar.length-1];
			assertEquals("createFromXML should set artist last similar name", "Céline Dion", similarArtist.name);
			assertContained("createFromXML should set artist summary", "Cher first rose to prominence in 1965 as one half of the pop/rock duo Sonny &amp; Cher.", a.bio.summary);
			assertNotContained("createFromXML should set artist summary", "She became a television star in the 1970s", a.bio.summary);
			assertContained("createFromXML should set artist summary", "She became a television star in the 1970s", a.bio.content);
		}
		
		public function testGetEvents () : void
		{
			var a : FMArtist = new FMArtist();
			try{
				a.getEvents();
				fail("FMArtist shouldn't be able to get events if it doesn't have a name");
			}catch(e : Error){}
			a.name = "Cher";
			a.addEventListener(FMArtist.GET_EVENTS, onEventsLoaded);
			a.getEvents();
		}
		
		private function onEventsLoaded(event : Event) : void
		{
			var a : FMArtist = FMArtist(event.currentTarget);
			assertEquals("FMArtist.getEvents should return the events", 10, a.events.length);
			var firstEvent : FMEvent = a.events[0];
			assertEquals("the first event should have the right id", 963563, firstEvent.id);
			assertEquals("the first event should have the right venue", "Penélope", firstEvent.venue.name);
			var lastEvent : FMEvent = a.events.pop();
			assertEquals("the last event should have the right id", 1033966, lastEvent.id);
			assertEquals("the last event should have the right venue", "Sala Clamores", lastEvent.venue.name);
		}
		
		public function testGetImages () : void
		{
			var a : FMArtist = new FMArtist();
			try{
				a.getImages();
				fail("FMArtist shouldn't be able to get images if it doesn't have a name");
			}catch(e : Error){}
			a.name = "Cher";
			try{
				a.getImages(0);
				fail("FMArtist shouldn't be able to get images if less than 1 are requested");
			}catch(e : Error){}
			a.addEventListener(FMArtist.GET_IMAGES, onImagesLoaded);
			a.getImages(70);
		}
		
		private function onImagesLoaded(event : Event) : void
		{
			var a : FMArtist = FMArtist(event.currentTarget);
			assertEquals("FMArtist.getEvents should return the images", 70, a.images.length);
			var firstImage : FMImage = a.images[0];
			assertEquals("the first image should have the right title", "CHER14", firstImage.title);
			assertEquals("the first image should have the right url", "http://www.last.fm/music/Cher/+images/13638451", firstImage.url);
			assertEquals("the first image should have the right owner name", "AngelPOA", firstImage.owner.name);
			var lastImage : FMImage = a.images.pop();
			assertEquals("the last image should have the right title", "normal_photo1992greatest_03", lastImage.title);
			assertEquals("the last image should have the right url", "http://www.last.fm/music/Cher/+images/20233011", lastImage.url);
			assertEquals("the last image should have the right owner name", "JoKo93", lastImage.owner.name);
		}
		
		public function testGetInfo () : void
		{
			var a : FMArtist = new FMArtist();
			try{
				a.getInfo();
				fail("FMArtist sholdn't be able to get info if it doesn't have a name and musicbrainz id");
			}catch(e:Error){			}
			a.name = "cher";
			a.addEventListener(FMArtist.GET_INFO, onInfoLoaded);
			a.getInfo();
		}
		
		private function onInfoLoaded(event : Event) : void
		{
			var a : FMArtist = FMArtist(event.currentTarget);
			assertEquals("FMArtist.getInfo should set the artist name", "Cher", a.name);
			assertEquals("FMArtist.getInfo should set the artist mbid", "bfcc6d75-a6a5-4bc6-8282-47aec8531818", a.mbid);
			assertEquals("FMArtist.getInfo should set the artist url", "http://www.last.fm/music/Cher", a.url);
			assertEquals("FMArtist.getInfo should set the artist image small", "http://userserve-ak.last.fm/serve/34/13638451.jpg", a.getImageUrlBySize(FMImageSizeType.SMALL));
			assertEquals("FMArtist.getInfo should set the artist listeners", 375297, a.listeners);
			assertEquals("FMArtist.getInfo should set the artist playCount", 3043544, a.playCount);
			var firstSimilarArtist : FMArtist = a.similar[0];
			assertEquals("FMArtist.getInfo should set the artist first similar artist name", "Sonny & Cher", firstSimilarArtist.name);
			assertEquals("FMArtist.getInfo should set the artist first similar artist image small", "http://userserve-ak.last.fm/serve/34/4987379.jpg", firstSimilarArtist.getImageUrlBySize(FMImageSizeType.SMALL));
			var lastSimilarArtist : FMArtist = a.similar.pop();
			assertEquals("FMArtist.getInfo should set the artist last similar artist name", "Céline Dion", lastSimilarArtist.name);
			assertEquals("FMArtist.getInfo should set the artist last similar artist image small", "http://userserve-ak.last.fm/serve/34/15509697.jpg", lastSimilarArtist.getImageUrlBySize(FMImageSizeType.SMALL));
		}
		
		public function testGetShouts () : void
		{
			var a : FMArtist = new FMArtist();
			try{
				a.getShouts();
				fail("FMArtist shouldn't be able to get shouts if it doesn't have a name");
			}catch(e:Error){}
			a.name = "Cher";
			a.addEventListener(FMArtist.GET_SHOUTS, onShoutsLoaded);
			a.getShouts();
		}
		
		private function onShoutsLoaded(event : Event) : void
		{
			var a : FMArtist = FMArtist(event.currentTarget);
			assertEquals("FMArtist.getShouts should return some shouts", 669, a.shouts.length); // the xml provided seems to be bugged
			var firstShout : FMShout = a.shouts[0];
			assertEquals("FMArtist.getShouts should return the first shout body", "∞", firstShout.body);
			assertEquals("FMArtist.getShouts should return the first shout author", "Generic_101", firstShout.author);
			assertEquals("FMArtist.getShouts should return the first shout dateRaw", "Wed, 6 May 2009 10:41:28", firstShout.dateRaw);
			var lastShout : FMShout = a.shouts.pop();
			assertEquals("FMArtist.getShouts should return the last shout body", "can't get enough of this", lastShout.body);
			assertEquals("FMArtist.getShouts should return the last shout author", "qadnoun3", lastShout.author);
			assertEquals("FMArtist.getShouts should return the last shout dateRaw", "Wed, 3 May 2006 11:28:22", lastShout.dateRaw);
		}
		
		public function testGetSimilar () : void
		{
			var a : FMArtist = new FMArtist();
			try{
				a.getSimilar();
				fail("FMArtist shouldn't be able to get similar if it doesn't have a name");
			}catch(e:Error){}
			a.name = "Cher";
			a.addEventListener(FMArtist.GET_SIMILAR, onSimilarLoaded);
			a.getSimilar();
		}
		
		private function onSimilarLoaded(event : Event) : void
		{
			var a : FMArtist = FMArtist(event.currentTarget);
			assertEquals("FMArtist.getSimilar should return some similar artists", 100, a.similar.length);
			var firstArtist : FMArtist = a.similar[0];
			assertEquals("FMArtist.getSimilar should return the first similar artist name", "Sonny & Cher", firstArtist.name);
			assertEquals("FMArtist.getSimilar should return the first similar artist match", 100, firstArtist.match);
			var lastArtist : FMArtist = a.similar.pop();
			assertEquals("FMArtist.getSimilar should return the last similar artist name", "Carly Simon", lastArtist.name);
			assertEquals("FMArtist.getSimilar should return the last similar artist match", 18.37, lastArtist.match);
		}
		
		public function testGetTopAlbums () : void
		{
			var a : FMArtist = new FMArtist();
			try{
				a.getTopAlbums();
				fail("FMArtist shouldn't be able to get top albums if it doesn't have a name");
			}catch(e:Error){}
			a.name = "cher";
			a.addEventListener(FMArtist.GET_TOP_ALBUMS, onTopAlbumsLoaded);
			a.getTopAlbums();
		}
		
		private function onTopAlbumsLoaded(event : Event) : void
		{
			var a : FMArtist = FMArtist(event.currentTarget);
			assertEquals("FMArtist.getTopAlbums should return some albums", 50, a.topAlbums.length);
			var firstAlbum : FMAlbum = a.topAlbums[0];
			assertEquals("FMArtist.getTopAlbums should return the first top album name", "The Very Best of Cher", firstAlbum.name);
			assertEquals("FMArtist.getTopAlbums should return the first top album playCount", 166685, firstAlbum.playCount);
			assertEquals("FMArtist.getTopAlbums should return the first top album artist name", "Cher", firstAlbum.artist.name);
			var lastAlbum : FMAlbum = a.topAlbums.pop();
			assertEquals("FMArtist.getTopAlbums should return the last top album name", "Music For Eighties", lastAlbum.name);
			assertEquals("FMArtist.getTopAlbums should return the last top album playCount", 145, lastAlbum.playCount);
			assertEquals("FMArtist.getTopAlbums should return the last top album artist name", "Various Artists", lastAlbum.artist.name);
		}
		
		public function testGetTopFans () : void
		{
			var a : FMArtist = new FMArtist();
			try{
				a.getTopFans();
				fail("FMArtist shouldn't be able to get top fans if it doesn't have a name");
			}catch(e:Error){}
			a.name = "cher";
			a.addEventListener(FMArtist.GET_TOP_FANS, onTopFansLoaded);
			a.getTopAlbums();
		}
		
		private function onTopFansLoaded(event : Event) : void
		{
			var a : FMArtist = FMArtist(event.currentTarget);
			assertEquals("FMArtist.getFans should return the right amount of users", 50, a.topFans.length);
			var firstFan : FMUser = a.topFans[0];
			assertEquals("FMArtist.getFans should return the first fan small image", "http://userserve-ak.last.fm/serve/34/19897677.jpg",
				firstFan.getImageUrlBySize(FMImageSizeType.SMALL));
			assertEquals("FMArtist.getFans should return the first fan weight", 12317587, firstFan.weight);
			var lastFan : FMUser = a.topFans.pop();
			assertEquals("FMArtist.getFans should return the last fan name", "black_saviour", lastFan.name);
			assertEquals("FMArtist.getFans should return the last fan url", "http://www.last.fm/user/black_saviour", lastFan.url);
			assertEquals("FMArtist.getFans should return the last fan small image", "http://userserve-ak.last.fm/serve/34/6013869.png",
				lastFan.getImageUrlBySize(FMImageSizeType.SMALL));
			assertEquals("FMArtist.getFans should return the last fan weight", 444444, lastFan.weight);
		}
		
		public function testGetTopTags () : void
		{
			var a : FMArtist = new FMArtist();
			try{
				a.getTopTags();
				fail("FMArtist shouldn't be able to get top tags if it doesn't have a name");
			}catch(e:Error){}
			a.name = "cher";
			a.addEventListener(FMArtist.GET_TOP_TAGS, onTopTagsLoaded);
			a.getTopTags();
		}
		
		private function onTopTagsLoaded ( event : Event ) : void
		{
			var a : FMArtist = FMArtist(event.currentTarget);
			assertEquals("FMArtist.getTopTags should return the right amount of tags", 100, a.topTags.length);
			var firstTag : FMTag = a.topTags[0];
			assertEquals("FMArtist.getTopTags should return the first tag name", "pop", firstTag.name);
			assertEquals("FMArtist.getTopTags should return the first tag url", "http://www.last.fm/tag/pop", firstTag.url);
			assertEquals("FMArtist.getTopTags should return the first tag count", 100, firstTag.count);
			var lastTag : FMTag = a.topTags.pop();
			assertEquals("FMArtist.getTopTags should return the last tag name", "sexy", lastTag.name);
			assertEquals("FMArtist.getTopTags should return the last tag url", "http://www.last.fm/tag/sexy", lastTag.url);
			assertEquals("FMArtist.getTopTags should return the last tag count", 0, lastTag.count);
		}
		
		public function testTopTracks () : void
		{
			var a : FMArtist = new FMArtist();
			try{
				a.getTopTracks();
				fail("FMArtist shouldn't be able to get top tracks if it doesn't have a name");
			}catch(e:Error){}
			a.name = "cher";
			a.addEventListener(FMArtist.GET_TOP_TRACKS, onTopTracksLoaded);
			a.getTopTracks();
		}
		
		public function onTopTracksLoaded ( e : Event ) : void
		{
			var a : FMArtist = FMArtist(e.currentTarget);
			assertEquals("FMArtist.getTopTracks should load the correct amount of tracks", 50, a.topTracks.length);
			var firstTrack : FMTrack = a.topTracks[0];
			assertEquals("top track in geo should be", "Viva la Vida", firstTrack.name);
			assertEquals("top track in geo should have the correct rank", 1, firstTrack.rank);
			var lastTrack : FMTrack = a.topTracks.pop();
			assertEquals("the last top track in geo should be", "No You Girls", lastTrack.name);
			assertEquals("the last top track in geo should have the correct rank", 50, lastTrack.rank);
		}
	}}