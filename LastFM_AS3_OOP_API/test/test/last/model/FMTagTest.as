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
	import fm.last.model.FMTag;

	import test.last.model.FMModelTest;

	import flash.events.Event;

	/**	 * @author christian	 */	public class FMTagTest extends FMModelTest 
	{
		[Embed("../../../data/constructors/tag.xml", mimeType="application/octet-stream")]
      	private static const CONSTRUCTOR_XML_CLASS:Class;
				public function FMTagTest(methodName : String = null)
		{			super(methodName);		}
		
		public function testCreateFromXML () : void
		{
			var t : FMTag = FMTag.createFromXML(getEmbeddedXML(CONSTRUCTOR_XML_CLASS));
			assertEquals("FMTag.createFromXML should set the name", "disco house", t.name);
			assertEquals("FMTag.createFromXML should set the count", 3438, t.count);
			assertEquals("FMTag.createFromXML should set the url", "www.last.fm/tag/disco%20house", t.url);
		}
		
		public function testGetSimilar () : void
		{
			var o : FMTag = new FMTag();
			try{
				o.getSimilar();
				fail("FMTag shouldn't be able to getSimilar if name is not defined");
			}catch(e : Error){};
			o.name = "disco";
			o.addEventListener(FMTag.GET_SIMILAR, onSimilarLoaded);
			o.getSimilar();
		}
		
		private function onSimilarLoaded(event : Event) : void
		{
			var o : FMTag = FMTag(event.currentTarget);
			assertEquals("FMTag.getSimilar should return the correct amount of tags", 50, o.similar.length);
			var firstTag : FMTag = o.similar[0];
			assertEquals("FMTag.getSimilar should return the first tag name", "italo disco", firstTag.name);
			assertEquals("FMTag.getSimilar should return the first tag url", "http://www.last.fm/tag/italo%20disco", firstTag.url);
			assertEquals("FMTag.getSimilar should return the first tag streamable", true, firstTag.streamable);
			var lastTag : FMTag = o.similar.pop();
			assertEquals("FMTag.getSimilar should return the last tag name", "sampled", lastTag.name);
			assertEquals("FMTag.getSimilar should return the last tag url", "http://www.last.fm/tag/sampled", lastTag.url);
			assertEquals("FMTag.getSimilar should return the last tag streamable", true, lastTag.streamable);
		}
		
		public function testGetTopAlbums () : void
		{
			var o : FMTag = new FMTag();
			try{
				o.getTopAlbums();
				fail("FMTag shouldn't be able to getTopAlbums if name is not defined");
			}catch(e : Error){};
			o.name = "disco";
			o.addEventListener(FMTag.GET_TOP_ALBUMS, onTopAlbumsLoaded);
			o.getTopAlbums();
		}
		private function onTopAlbumsLoaded( event : Event ) : void
		{
			var o : FMTag = FMTag(event.currentTarget);
			assertEquals("FMTag.getTopAlbums should return the correct amount of albums", 50, o.topAlbums.length);
			var firstAlbum : FMAlbum = o.topAlbums[0];
			assertEquals("FMTag.getTopAlbums should set the first album name", "Overpowered", firstAlbum.name);
			assertEquals("FMTag.getTopAlbums should set the first album tagCount", 105, firstAlbum.tagCount);
			assertEquals("FMTag.getTopAlbums should set the first album mbid", "", firstAlbum.mbid);
			assertEquals("FMTag.getTopAlbums should set the first album url", "http://www.last.fm/music/R%C3%B3is%C3%ADn+Murphy/Overpowered", firstAlbum.url);
			assertEquals("FMTag.getTopAlbums should set the first album artist name", "Róisín Murphy", firstAlbum.artist.name);
			assertEquals("FMTag.getTopAlbums should set the first album image small", "http://userserve-ak.last.fm/serve/34s/26856969.png", firstAlbum.getImageUrlBySize(FMImageSizeType.SMALL));
			var lastAlbum : FMAlbum = o.topAlbums.pop();
			assertEquals("FMTag.getTopAlbums should set the last album name", "I Will Survive", lastAlbum.name);
			assertEquals("FMTag.getTopAlbums should set the last album tagCount", 6, lastAlbum.tagCount);
			assertEquals("FMTag.getTopAlbums should set the last album mbid", "ba92d952-a8ec-4936-bd37-303d67011c16", lastAlbum.mbid);
			assertEquals("FMTag.getTopAlbums should set the last album url", "http://www.last.fm/music/Gloria+Gaynor/I+Will+Survive", lastAlbum.url);
			assertEquals("FMTag.getTopAlbums should set the last album artist name", "Gloria Gaynor", lastAlbum.artist.name);
			assertEquals("FMTag.getTopAlbums should set the last album image small", "http://images.amazon.com/images/P/B00000BIHA.01.THUMBZZZ.jpg", lastAlbum.getImageUrlBySize(FMImageSizeType.SMALL));
		}
		
		public function testGetTopArtists () : void
		{
			var o : FMTag = new FMTag();
			try{
				o.getTopArtists();
				fail("FMTag shouldn't be able to getTopArtists if name is not defined");
			}catch(e : Error){};
			o.name = "disco";
			o.addEventListener(FMTag.GET_TOP_ARTISTS, onTopArtistsLoaded);
			o.getTopArtists();
		}
		private function onTopArtistsLoaded( event : Event ) : void
		{
			var o : FMTag = FMTag(event.currentTarget);
			assertEquals("FMTag.getTopArtists should return the correct amount of artists", 50, o.topArtists.length);
			var firstArtist : FMArtist = o.topArtists[0];
			assertEquals("FMTag.getTopArtists should set the first artist name", "ABBA", firstArtist.name);
			assertEquals("FMTag.getTopArtists should set the first artist tagCount", 1261, firstArtist.tagCount);
			assertEquals("FMTag.getTopArtists should set the first artist mdib", "d87e52c5-bb8d-4da8-b941-9f4928627dc8", firstArtist.mbid);
			assertEquals("FMTag.getTopArtists should set the first artist url", "http://www.last.fm/music/ABBA", firstArtist.url);
			assertEquals("FMTag.getTopArtists should set the first artist streamable", true, firstArtist.streamable);
			assertEquals("FMTag.getTopArtists should set the first artist image small", "http://userserve-ak.last.fm/serve/34/2776841.jpg", firstArtist.getImageUrlBySize(FMImageSizeType.SMALL));
			var lastArtist : FMArtist = o.topArtists.pop();
			assertEquals("FMTag.getTopArtists should set the last artist name", "Santa Esmeralda", lastArtist.name);
			assertEquals("FMTag.getTopArtists should set the last artist tagCount", 87, lastArtist.tagCount);
			assertEquals("FMTag.getTopArtists should set the last artist mdib", "b233a9a9-2538-4c5b-986a-5843650e2611", lastArtist.mbid);
			assertEquals("FMTag.getTopArtists should set the last artist url", "http://www.last.fm/music/Santa+Esmeralda", lastArtist.url);
			assertEquals("FMTag.getTopArtists should set the last artist streamable", true, lastArtist.streamable);
			assertEquals("FMTag.getTopArtists should set the last artist image small", "http://userserve-ak.last.fm/serve/34/134799.jpg", lastArtist.getImageUrlBySize(FMImageSizeType.SMALL));
		}
		
		public function testGetTopTracks () : void
		{
			var o : FMTag = new FMTag();
			try{
				o.getTopTracks();
				fail("FMTag shouldn't be able to getTopTracks if name is not defined");
			}catch(e : Error){};
			o.name = "disco";
			o.addEventListener(FMTag.GET_TOP_TRACKS, onTopTracksLoaded);
			o.getTopTracks();
		}
		private function onTopTracksLoaded( event : Event ) : void
		{
			var o : FMTag = FMTag(event.currentTarget);
			assertEquals("FMTag.getTopTracks should return the correct amount of tracks", 50, o.topTracks.length);
			var firstTrack : FMTrack = o.topTracks[0];
			assertEquals("FMTag.getTopTracks should set the first track name", "Stayin' Alive", firstTrack.name);
			assertEquals("FMTag.getTopTracks should set the first track tagCount", 426, firstTrack.tagCount);
			assertEquals("FMTag.getTopTracks should set the first track mbid", "", firstTrack.mbid);
			assertEquals("FMTag.getTopTracks should set the first track url", "http://www.last.fm/music/Bee+Gees/_/Stayin%27+Alive", firstTrack.url);
			assertEquals("FMTag.getTopTracks should set the first track streamable", true, firstTrack.streamable);
			assertEquals("FMTag.getTopTracks should set the first track streamableAsFullTrack", false, firstTrack.streamableAsFullTrack);
			assertEquals("FMTag.getTopTracks should set the first track artist name", "Bee Gees", firstTrack.artist.name);
			assertEquals("FMTag.getTopTracks should set the first track artist mbid", "bf0f7e29-dfe1-416c-b5c6-f9ebc19ea810", firstTrack.artist.mbid);
			assertEquals("FMTag.getTopTracks should set the first track image small", "http://images.amazon.com/images/P/B00069590Q.01._SCMZZZZZZZ_.jpg", firstTrack.getImageUrlBySize(FMImageSizeType.SMALL));
			var lastTrack : FMTrack = o.topTracks.pop();
			assertEquals("FMTag.getTopTracks should set the last track name", "What Is Love", lastTrack.name);
			assertEquals("FMTag.getTopTracks should set the last track tagCount", 100, lastTrack.tagCount);
			assertEquals("FMTag.getTopTracks should set the last track mbid", "", lastTrack.mbid);
			assertEquals("FMTag.getTopTracks should set the last track url", "http://www.last.fm/music/Haddaway/_/What+Is+Love", lastTrack.url);
			assertEquals("FMTag.getTopTracks should set the last track streamable", true, lastTrack.streamable);
			assertEquals("FMTag.getTopTracks should set the last track streamableAsFullTrack", true, lastTrack.streamableAsFullTrack);
			assertEquals("FMTag.getTopTracks should set the last track artist name", "Haddaway", lastTrack.artist.name);
			assertEquals("FMTag.getTopTracks should set the last track artist mbid", "6508cf1d-4da2-4d71-81ec-0e072338991f", lastTrack.artist.mbid);
			assertEquals("FMTag.getTopTracks should set the last track image small", "http://images.amazon.com/images/P/B000002VNW.01.MZZZZZZZ.jpg", lastTrack.getImageUrlBySize(FMImageSizeType.SMALL));
		}
	}}