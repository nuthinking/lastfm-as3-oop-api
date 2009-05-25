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
{	import fm.last.model.vo.FMChartDateRange;
	import fm.last.model.FMTag;
	import fm.last.model.FMArtist;
	import fm.last.enum.FMImageSizeType;
	import fm.last.model.FMAlbum;
	import fm.last.model.FMEvent;
	import fm.last.model.FMPlayList;
	import fm.last.model.FMTrack;
	import fm.last.model.FMUser;
	import fm.last.model.vo.FMShout;

	import test.last.model.FMModelTest;

	import flash.events.Event;

	/**	 * @author christian	 */	public class FMUserTest extends FMModelTest 
	{
		[Embed("../../../data/constructors/user.xml", mimeType="application/octet-stream")]
      	private static const CONSTRUCTOR_XML_CLASS:Class;
      			public function FMUserTest(methodName : String = null)
		{			super(methodName);		}
		
		public function testCreateFromXML () : void
		{
			var r : FMUser = FMUser.createFromXML(getEmbeddedXML(CONSTRUCTOR_XML_CLASS));
			assertEquals("FMUser.createFromXML should set user name", "maslyn", r.name);
			assertEquals("FMUser.createFromXML should set user url", "http://www.last.fm/user/maslyn", r.url);
			assertEquals("FMUser.createFromXML should set user image small", "http://userserve-ak.last.fm/serve/34/19897677.jpg", r.getImageUrlBySize(FMImageSizeType.SMALL));
			assertEquals("FMUser.createFromXML should set user weight", 12317587, r.weight);
		}
		
		public function testGetEvents () : void
		{
			var o : FMUser = new FMUser();
			try{
				o.getEvents();
				fail("to get user events, user should have a name");
			}catch(e : Error){
			}
			o.name = "foo";
			o.addEventListener(FMUser.GET_EVENTS, onEventsLoaded);
			o.getEvents();
		}
		
		private function onEventsLoaded ( event : Event ) : void
		{
			var o : FMUser = FMUser(event.currentTarget);
			assertTrue("FMUser.getEvents should return some events", o.events.length>0);
			var firstEvent : FMEvent = o.events[0];
			assertEquals("FMUser.getEvents should return the first event id", 1030003, firstEvent.id);
			assertEquals("FMUser.getEvents should return the first event name", "The Mars Volta", firstEvent.name);
			assertEquals("FMUser.getEvents should return the first headliner name", "The Mars Volta", firstEvent.headliner.name);
			assertEquals("FMUser.getEvents should return the first venue name", "Somerset House", firstEvent.venue.name);
			var lastEvent : FMEvent = o.events.pop();
			assertEquals("FMUser.getEvents should return the last event id", 1028116, lastEvent.id);
			assertEquals("FMUser.getEvents should return the last event name", "ATP Nightmare Before Christmas curated by My Bloody Valentine", lastEvent.name);
			assertEquals("FMUser.getEvents should return the last headliner name", "My Bloody Valentine", lastEvent.headliner.name);
			assertEquals("FMUser.getEvents should return the last venue name", "Butlins Holiday Resort", lastEvent.venue.name);
		}
		
		public function testGetFriends () : void
		{
			var o : FMUser = new FMUser();
			try{
				o.getFriends();
				fail("to get user friends, user should have a name");
			}catch(e : Error){
			}
			o.name = "foo";
			o.addEventListener(FMUser.GET_FRIENDS, onFriendsLoaded);
			o.getFriends(true, 75);
		}

		private function onFriendsLoaded ( event : Event ) : void
		{
			var o : FMUser = FMUser(event.currentTarget);
			assertEquals("FMUser.getFriends should return correct amount of users", 75, o.friends.length);
			var firstFriend : FMUser = o.friends[0];
			assertEquals("FMUser.getFriends should return the first friend name", "lobsterclaw", firstFriend.name);
			assertEquals("FMUser.getFriends should return the first friend name", "Laura Weiss", firstFriend.realname);
			assertEquals("FMUser.getFriends should return the first friend image small", "http://userserve-ak.last.fm/serve/34/1733471.jpg", firstFriend.getImageUrlBySize(FMImageSizeType.SMALL));
			assertEquals("FMUser.getFriends should return the first friend recent track name", "Buttoned Down Disco", firstFriend.recentTrack.name);
			assertEquals("FMUser.getFriends should return the first friend recent track artist name", "Clinton", firstFriend.recentTrack.artist.name);
			var lastUser : FMUser = o.friends.pop();
			assertEquals("FMUser.getFriends should return the last friend name", "HairMetalAddict", lastUser.name);
			assertEquals("FMUser.getFriends should return the last friend name", "Never stop the rock when it's started to Roll...", lastUser.realname);
			assertEquals("FMUser.getFriends should return the last friend image small", "http://userserve-ak.last.fm/serve/34/2312702.gif", lastUser.getImageUrlBySize(FMImageSizeType.SMALL));
			assertEquals("FMUser.getFriends should return the last friend recent track name", "New Future Weapon", lastUser.recentTrack.name);
			assertEquals("FMUser.getFriends should return the last friend recent track artist name", "Billy Idol", lastUser.recentTrack.artist.name);
		}
		
		public function testGetLovedTracks () : void
		{
			var o : FMUser = new FMUser();
			try{
				o.getLovedTracks();
				fail("to get user loved tracks, user should have a name");
			}catch(e : Error){
			}
			o.name = "foo";
			o.addEventListener(FMUser.GET_LOVED_TRACKS, onLovedTracksLoaded);
			o.getLovedTracks();
		}
		
		private function onLovedTracksLoaded ( event : Event ) : void
		{
			var o : FMUser = FMUser(event.currentTarget);
			assertTrue("FMUser.getLovedTracks should return some loved tracks", o.lovedTracks != null &&  o.lovedTracks.length > 0);
			var firstTrack : FMTrack = o.lovedTracks[0];
			assertEquals("FMUser.getLovedTracks should return the first loved track name", "Conversations (feat. Stevie Wonder)", firstTrack.name);
			assertEquals("FMUser.getLovedTracks should return the first loved track artist name", "Snoop Dogg", firstTrack.artist.name);
			var lastTrack : FMTrack = o.lovedTracks.pop();
			assertEquals("FMUser.getLovedTracks should return the last loved track name", "Smut", lastTrack.name);
			assertEquals("FMUser.getLovedTracks should return the last loved track artist name", "Tom Lehrer", lastTrack.artist.name);
		}
		
		public function testGetNeighbours () : void
		{
			var o : FMUser = new FMUser();
			try{
				o.getNeighbours();
				fail("to get user neighbours, user should have a name");
			}catch(e : Error){
			}
			o.name = "foo";
			o.addEventListener(FMUser.GET_NEIGHBOURS, onNeighboursLoaded);
			o.getNeighbours();
		}
		
		private function onNeighboursLoaded ( event : Event ) : void
		{
			var o : FMUser = FMUser(event.currentTarget);
			assertEquals("FMUser.getNeighbours should return the correct amount of user", 60, o.neighbours.length);
			var firstUser : FMUser = o.neighbours[0];
			assertEquals("FMUser.getNeighbours should return the first neighbour name", "eljota69", firstUser.name);
			assertEquals("FMUser.getNeighbours should return the first neighbour url", "http://www.last.fm/user/eljota69", firstUser.url);
			assertEquals("FMUser.getNeighbours should return the first neighbour image small", "http://userserve-ak.last.fm/serve/34/4828430.gif", firstUser.getImageUrlBySize(FMImageSizeType.SMALL));
			assertEquals("FMUser.getNeighbours should return the first neighbour match", 0.0010436978191137, firstUser.match);
			var lastUser : FMUser = o.neighbours.pop();
			assertEquals("FMUser.getNeighbours should return the first neighbour name", "ImagewrapDoug", lastUser.name);
			assertEquals("FMUser.getNeighbours should return the first neighbour url", "http://www.last.fm/user/ImagewrapDoug", lastUser.url);
			assertEquals("FMUser.getNeighbours should return the first neighbour image small", null, lastUser.getImageUrlBySize(FMImageSizeType.SMALL));
			assertEquals("FMUser.getNeighbours should return the first neighbour match", 0.0012487581698224, lastUser.match);
		}
		
		public function testGetPastEvents () : void
		{
			var o : FMUser = new FMUser();
			try{
				o.getPastEvents();
				fail("to get user past events, user should have a name");
			}catch(e : Error){
			}
			o.name = "foo";
			try{
				o.getPastEvents(0);
				fail("to get user past events, you should set a limit higher than 0");
			}catch(e : Error){
			}
			o.addEventListener(FMUser.GET_PAST_EVENTS, onPastEventsLoaded);
			o.getPastEvents(75);
		}

		private function onPastEventsLoaded ( event : Event ) : void
		{
			var o : FMUser = FMUser(event.currentTarget);
			assertEquals("FMUser.getPastEvents should return the correct amount of past events", 75, o.pastEvents.length);
			var firstEvent : FMEvent  = o.pastEvents[0];
			assertEquals("FMUser.getPastEvents shoud return the first event id", 802783, firstEvent.id);
			assertEquals("FMUser.getPastEvents shoud return the first event name", "BLOC", firstEvent.name);
			assertEquals("FMUser.getPastEvents shoud return the first event headliner name", "The Future Sound of London", firstEvent.headliner.name);
			assertEquals("FMUser.getPastEvents shoud return the first event venue name", "Butlins Holiday Resort", firstEvent.venue.name);
			assertEquals("FMUser.getPastEvents shoud return the first event start date raw", "Fri, 13 Mar 2009 14:57:01", firstEvent.startDateRaw);
			assertEquals("FMUser.getPastEvents shoud return the first event end date raw", "Sun, 15 Mar 2009 14:57:01", firstEvent.endDateRaw);
			var lastEvent : FMEvent  = o.pastEvents.pop();
			assertEquals("FMUser.getPastEvents shoud return the last event id", 238907, lastEvent.id);
			assertEquals("FMUser.getPastEvents shoud return the last event name", "Meat Raffle", lastEvent.name);
			assertEquals("FMUser.getPastEvents shoud return the last event headliner name", "Punks Jump Up", lastEvent.headliner.name);
			assertEquals("FMUser.getPastEvents shoud return the last event venue name", "The Lock Tavern", lastEvent.venue.name);
			assertEquals("FMUser.getPastEvents shoud return the last event start date raw", "Mon, 28 May 2007 15:00:00", lastEvent.startDateRaw);
			assertEquals("FMUser.getPastEvents shoud return the last event end date raw", null, lastEvent.endDateRaw);
		}
		
		public function testGetPlaylists () : void
		{
			var o : FMUser = new FMUser();
			try{
				o.getPlaylists();
				fail("to get user playlists, user should have a name");
			}catch(e : Error){
			}
			o.name = "foo";
			o.addEventListener(FMUser.GET_PLAYLISTS, onPlaylistsLoaded);
			o.getPlaylists();
		}
		
		private function onPlaylistsLoaded ( event : Event ) : void
		{
			var o : FMUser = FMUser(event.currentTarget);
			assertEquals("FMUser.getPlaylists should return the correct amount of playlists", 4, o.playlists.length);
			var firstPlaylist : FMPlayList = o.playlists[0];
			assertEquals("FMUser.getPlaylists should return the first playlist id", 5606, firstPlaylist.id);
			assertEquals("FMUser.getPlaylists should return the first playlist name", "Misc gubbins", firstPlaylist.name);
			assertEquals("FMUser.getPlaylists should return the first playlist description", "This is a misc test playlist with a few random tracks in it.", firstPlaylist.description);
			assertEquals("FMUser.getPlaylists should return the first playlist date row", "2006-11-15T13:05:48", firstPlaylist.dateRaw);
			assertEquals("FMUser.getPlaylists should return the first playlist size", 10, firstPlaylist.size);
			assertEquals("FMUser.getPlaylists should return the first playlist duration", 2825, firstPlaylist.duration);
			assertEquals("FMUser.getPlaylists should return the first playlist streamable", false, firstPlaylist.streamable);
			assertEquals("FMUser.getPlaylists should return the first playlist creator", "http://www.last.fm/user/RJ", firstPlaylist.creator);
			assertEquals("FMUser.getPlaylists should return the first playlist url", "http://www.last.fm/user/RJ/library/playlists/4bq_misc_gubbins", firstPlaylist.url);
			assertEquals("FMUser.getPlaylists should return the first playlist image small", "http://userserve-ak.last.fm/serve/34/4218758.jpg", firstPlaylist.getImageUrlBySize(FMImageSizeType.SMALL));
			var lastPlaylist : FMPlayList = o.playlists.pop();
			assertEquals("FMUser.getPlaylists should return the last playlist id", 2612216, lastPlaylist.id);
			assertEquals("FMUser.getPlaylists should return the last playlist name", "Sexyplaylist", lastPlaylist.name);
			assertEquals("FMUser.getPlaylists should return the last playlist description", "My only regret is that the search feature doesn't give me more than 10 results", lastPlaylist.description);
			assertEquals("FMUser.getPlaylists should return the last playlist date row", "2008-05-21T19:43:46", lastPlaylist.dateRaw);
			assertEquals("FMUser.getPlaylists should return the last playlist size", 9, lastPlaylist.size);
			assertEquals("FMUser.getPlaylists should return the last playlist duration", 2416, lastPlaylist.duration);
			assertEquals("FMUser.getPlaylists should return the last playlist streamable", false, lastPlaylist.streamable);
			assertEquals("FMUser.getPlaylists should return the last playlist creator", "http://www.last.fm/user/RJ", lastPlaylist.creator);
			assertEquals("FMUser.getPlaylists should return the last playlist url", "http://www.last.fm/user/RJ/library/playlists/1jzlk_sexyplaylist", lastPlaylist.url);
			assertEquals("FMUser.getPlaylists should return the last playlist image small", "http://userserve-ak.last.fm/serve/34/5976429.jpg", lastPlaylist.getImageUrlBySize(FMImageSizeType.SMALL));
		}
		
		public function testGetRecentTracks () : void
		{
			var o : FMUser = new FMUser();
			try{
				o.getRecentTracks();
				fail("to get user recent tracks, user should have a name");
			}catch(e : Error){
			}
			o.name = "foo";
			o.addEventListener(FMUser.GET_RECENT_TRACKS, onRecentTracksLoaded);
			o.getRecentTracks();
		}
		
		private function onRecentTracksLoaded ( event : Event ) : void
		{
			var o : FMUser = FMUser(event.currentTarget);
			assertEquals("FMUser.getRecentTracks should return the correct amount of tracks", 10, o.recentTracks.length);
			var firstTrack : FMTrack = o.recentTracks[0];
			assertEquals("FMUser.getRecentTracks should return the first recent track name", "Oh No (feat. 50 Cent)", firstTrack.name);
			assertEquals("FMUser.getRecentTracks should return the first recent track artist name", "Snoop Dogg", firstTrack.artist.name);
			assertEquals("FMUser.getRecentTracks should return the first recent track artist mbid", "f90e8b26-9e52-4669-a5c9-e28529c47894", firstTrack.artist.mbid);
			assertEquals("FMUser.getRecentTracks should return the first recent track album name", "R & G (Rhythm & Gangsta): The Masterpiece", firstTrack.album.name);
			assertEquals("FMUser.getRecentTracks should return the first recent track album mbid", "7d05c8ec-09e1-48de-9f22-eb11ec65db36", firstTrack.album.mbid);
			var lastTrack : FMTrack = o.recentTracks.pop();
			assertEquals("FMUser.getRecentTracks should return the last recent track name", "Ups & Downs (feat. The Bee Gees)", lastTrack.name);
			assertEquals("FMUser.getRecentTracks should return the last recent track artist name", "Snoop Dogg", lastTrack.artist.name);
			assertEquals("FMUser.getRecentTracks should return the last recent track artist mbid", "f90e8b26-9e52-4669-a5c9-e28529c47894", lastTrack.artist.mbid);
			assertEquals("FMUser.getRecentTracks should return the last recent track album name", "R & G (Rhythm & Gangsta): The Masterpiece", lastTrack.album.name);
			assertEquals("FMUser.getRecentTracks should return the last recent track album mbid", "7d05c8ec-09e1-48de-9f22-eb11ec65db36", lastTrack.album.mbid);
		}
		
		public function testGetShouts () : void
		{
			var o : FMUser = new FMUser();
			try{
				o.getShouts();
				fail("to get user shouts, user should have a name");
			}catch(e : Error){
			}
			o.name = "foo";
			o.addEventListener(FMUser.GET_SHOUTS, onShoutsLoaded);
			o.getShouts();
		}
		
		private function onShoutsLoaded ( event : Event ) : void
		{
			var o : FMUser = FMUser(event.currentTarget);
			assertTrue("FMUser.getShouts should return some shouts", o.shouts!=null && o.shouts.length>0);
			var firstShout : FMShout = o.shouts[0];
			assertEquals("FMUser.getShouts should returne the first shout body", "Loving the abuse, thanks girl! (from a third world loser)", firstShout.body);
			assertEquals("FMUser.getShouts should returne the first shout author", "patanpatan", firstShout.author);
			assertEquals("FMUser.getShouts should returne the first shout date row", "Tue, 19 May 2009 02:10:42", firstShout.dateRaw);
			var lastShout : FMShout = o.shouts.pop();
			assertEquals("FMUser.getShouts should returne the last shout body", ":-(", lastShout.body);
			assertEquals("FMUser.getShouts should returne the last shout author", "RJ", lastShout.author);
			assertEquals("FMUser.getShouts should returne the last shout date row", "Thu, 2 Feb 2006 17:06:28", lastShout.dateRaw);
		}
		
		public function testGetTopAlbums () : void
		{
			var o : FMUser = new FMUser();
			try{
				o.getTopAlbums();
				fail("to get user top albums, user should have a name");
			}catch(e : Error){
			}
			o.name = "foo";
			o.addEventListener(FMUser.GET_TOP_ALBUMS, onTopAlbumsLoaded);
			o.getTopAlbums();
		}
		
		private function onTopAlbumsLoaded ( event : Event ) : void
		{
			var a : FMUser = FMUser(event.currentTarget);
			assertEquals("FMUser.getTopAlbums should return some albums", 50, a.topAlbums.length);
			var firstAlbum : FMAlbum = a.topAlbums[0];
			assertEquals("FMUser.getTopAlbums should return the first top album name", "The Very Best of Cher", firstAlbum.name);
			assertEquals("FMUser.getTopAlbums should return the first top album playCount", 166685, firstAlbum.playCount);
			assertEquals("FMUser.getTopAlbums should return the first top album artist name", "Cher", firstAlbum.artist.name);
			var lastAlbum : FMAlbum = a.topAlbums.pop();
			assertEquals("FMUser.getTopAlbums should return the last top album name", "Music For Eighties", lastAlbum.name);
			assertEquals("FMUser.getTopAlbums should return the last top album playCount", 145, lastAlbum.playCount);
			assertEquals("FMUser.getTopAlbums should return the last top album artist name", "Various Artists", lastAlbum.artist.name);
		}
		
		public function testGetTopArtists () : void
		{
			var o : FMUser = new FMUser();
			try{
				o.getTopArtists();
				fail("to get user top artists, user should have a name");
			}catch(e : Error){
			}
			o.name = "foo";
			o.addEventListener(FMUser.GET_TOP_ARTISTS, onTopArtistsLoaded);
			o.getTopArtists();
		}
		
		private function onTopArtistsLoaded( event : Event ) : void
		{
			var o : FMUser = FMUser(event.currentTarget);
			assertEquals("FMUser.getTopArtists should return the correct amount of artists", 50, o.topArtists.length);
			var firstArtist : FMArtist = o.topArtists[0];
			assertEquals("FMUser.getTopArtists should set the first artist name", "Dream Theater", firstArtist.name);
			assertEquals("FMUser.getTopArtists should set the first artist playCount", 1643, firstArtist.playCount);
			assertEquals("FMUser.getTopArtists should set the first artist mdib", "28503ab7-8bf2-4666-a7bd-2644bfc7cb1d", firstArtist.mbid);
			assertEquals("FMUser.getTopArtists should set the first artist url", "http://www.last.fm/music/Dream+Theater", firstArtist.url);
			assertEquals("FMUser.getTopArtists should set the first artist streamable", true, firstArtist.streamable);
			assertEquals("FMUser.getTopArtists should set the first artist image small", "http://userserve-ak.last.fm/serve/34/393249.jpg", firstArtist.getImageUrlBySize(FMImageSizeType.SMALL));
			var lastArtist : FMArtist = o.topArtists.pop();
			assertEquals("FMUser.getTopArtists should set the last artist name", "Santana", lastArtist.name);
			assertEquals("FMUser.getTopArtists should set the last artist playCount", 205, lastArtist.playCount);
			assertEquals("FMUser.getTopArtists should set the last artist mdib", "9a3bf45c-347d-4630-894d-7cf3e8e0b632", lastArtist.mbid);
			assertEquals("FMUser.getTopArtists should set the last artist url", "http://www.last.fm/music/Santana", lastArtist.url);
			assertEquals("FMUser.getTopArtists should set the last artist streamable", true, lastArtist.streamable);
			assertEquals("FMUser.getTopArtists should set the last artist image small", "http://userserve-ak.last.fm/serve/34/2224987.jpg", lastArtist.getImageUrlBySize(FMImageSizeType.SMALL));
		}
		
		public function testGetTopTags () : void
		{
			var o : FMUser = new FMUser();
			try{
				o.getTopTags();
				fail("to get user top tags, user should have a name");
			}catch(e : Error){
			}
			o.name = "foo";
			o.addEventListener(FMUser.GET_TOP_TAGS, onTopTagsLoaded);
			o.getTopTags();
		}
		
		private function onTopTagsLoaded ( event : Event ) : void
		{
			var o : FMUser = FMUser(event.currentTarget);
			assertTrue("FMUser.getTopTags should return some tags", o.topTags != null && o.topTags.length > 0);
			var firstTag : FMTag = o.topTags[0];
			assertEquals("FMUser.getTopTags should set the first tag name", "rock", firstTag.name);
			assertEquals("FMUser.getTopTags should set the first tag count", 16, firstTag.count);
			assertEquals("FMUser.getTopTags should set the first tag url", "www.last.fm/tag/rock", firstTag.url);
			var lastTag : FMTag = o.topTags.pop();
			assertEquals("FMUser.getTopTags should set the last tag name", "hair metal", lastTag.name);
			assertEquals("FMUser.getTopTags should set the last tag count", 1, lastTag.count);
			assertEquals("FMUser.getTopTags should set the last tag url", "www.last.fm/tag/hair%20metal", lastTag.url);
		}
		
		public function testGetTopTracks () : void
		{
			var o : FMUser = new FMUser();
			try{
				o.getTopTracks();
				fail("to get user top tracks, user should have a name");
			}catch(e : Error){
			}
			o.name = "foo";
			o.addEventListener(FMUser.GET_TOP_TRACKS, onTopTracksLoaded);
			o.getTopTracks();
		}
		
		private function onTopTracksLoaded(event : Event) : void
		{
			var o : FMUser = FMUser(event.currentTarget);
			assertTrue("FMUser.getTopTracks should return some tracks", o.topTracks != null && o.topTracks.length > 0);
			var firstTrack : FMTrack = o.topTracks[0];
			assertEquals("FMUser.getTopTracks should set the first track name", "Three Minute Warning", firstTrack.name);
			assertEquals("FMUser.getTopTracks should set the first track playCount", 51, firstTrack.playCount);
			assertEquals("FMUser.getTopTracks should set the first track mbid", "", firstTrack.mbid);
			assertEquals("FMUser.getTopTracks should set the first track url", "http://www.last.fm/music/Liquid+Tension+Experiment/_/Three+Minute+Warning", firstTrack.url);
			assertEquals("FMUser.getTopTracks should set the first track streamable", true, firstTrack.streamable);
			assertEquals("FMUser.getTopTracks should set the first track streamableAsFullTrack", true, firstTrack.streamableAsFullTrack);
			assertEquals("FMUser.getTopTracks should set the first track artist name", "Liquid Tension Experiment", firstTrack.artist.name);
			assertEquals("FMUser.getTopTracks should set the first track image small", "http://userserve-ak.last.fm/serve/34s/15779373.jpg", firstTrack.getImageUrlBySize(FMImageSizeType.SMALL));
			var lastTrack : FMTrack = o.topTracks.pop();
			assertEquals("FMUser.getTopTracks should set the last track name", "Welcome to the Jungle", lastTrack.name);
			assertEquals("FMUser.getTopTracks should set the last track playCount", 24, lastTrack.playCount);
			assertEquals("FMUser.getTopTracks should set the last track mbid", "", lastTrack.mbid);
			assertEquals("FMUser.getTopTracks should set the last track url", "http://www.last.fm/music/Guns+N%27+Roses/_/Welcome+to+the+Jungle", lastTrack.url);
			assertEquals("FMUser.getTopTracks should set the last track streamable", true, lastTrack.streamable);
			assertEquals("FMUser.getTopTracks should set the last track streamableAsFullTrack", true, lastTrack.streamableAsFullTrack);
			assertEquals("FMUser.getTopTracks should set the last track artist name", "Guns N' Roses", lastTrack.artist.name);
			assertEquals("FMUser.getTopTracks should set the last track image small", "http://userserve-ak.last.fm/serve/34s/8616041.jpg", lastTrack.getImageUrlBySize(FMImageSizeType.SMALL));
		}
		
		public function testGetWeeklyChartList () : void
		{
			var o : FMUser = new FMUser();
			try{
				o.getWeeklyChartList();
				fail("to get user weekly chart list, user should have a name");
			}catch(e : Error){
			}
			o.name = "foo";
			o.addEventListener(FMUser.GET_WEEKLY_CHART_LIST, onWeeklyChartListLoaded);
			o.getWeeklyChartList();
		}
		
		private function onWeeklyChartListLoaded ( event : Event ) : void
		{
			var o : FMUser = FMUser(event.currentTarget);
			assertTrue("FMUser.getWeeklyChartList should return some charts", o.weeklyChartDateRanges != null && o.weeklyChartDateRanges.length > 0);
			var firstChart : FMChartDateRange = o.weeklyChartDateRanges[0];
			assertEquals("FMUser.getWeeklyChartList should return the first chart from", 1108296002, firstChart.dateFromAsInt);
			assertEquals("FMUser.getWeeklyChartList should return the first chart to", 1108900802, firstChart.dateToAsInt);
			var lastChart : FMChartDateRange = o.weeklyChartDateRanges.pop();
			assertEquals("FMUser.getWeeklyChartList should return the last chart from", 1241956800, lastChart.dateFromAsInt);
			assertEquals("FMUser.getWeeklyChartList should return the last chart to", 1242561600, lastChart.dateToAsInt);
		}
		
		public function testGetWeeklyAlbumChart () : void
		{
			var o : FMUser = new FMUser();
			try{
				o.getWeeklyAlbumChart();
				fail("to get user weekly album chart, user should have a name");
			}catch(e : Error){
			}
			o.name = "foo";
			o.addEventListener(FMUser.GET_WEEKLY_ALBUM_CHART, onWeeklyAlbumChartLoaded);
			o.getWeeklyAlbumChart();
		}
		
		private function onWeeklyAlbumChartLoaded ( event : Event ) : void
		{
			var o : FMUser = FMUser(event.currentTarget);
			assertTrue("FMUser.getWeeklyAlbumChart should return some albums", o.weeklyAlbumChart != null && o.weeklyAlbumChart.length > 0);
			var firstAlbum : FMAlbum = o.weeklyAlbumChart[0];
			assertEquals("FMUser.getWeeklyAlbumChart should return the first album name", "Doggystyle", firstAlbum.name);
			assertEquals("FMUser.getWeeklyAlbumChart should return the first album playCount", 26, firstAlbum.playCount);
			assertEquals("FMUser.getWeeklyAlbumChart should return the first album mbid", "092bebff-dcf6-4fc4-8c34-837651703155", firstAlbum.mbid);
			assertEquals("FMUser.getWeeklyAlbumChart should return the first album artist name", "Snoop Dogg", firstAlbum.artist.name);
			assertEquals("FMUser.getWeeklyAlbumChart should return the first album artist mbid", "f90e8b26-9e52-4669-a5c9-e28529c47894", firstAlbum.artist.mbid);
			var lastAlbum : FMAlbum = o.weeklyAlbumChart.pop();
			assertEquals("FMUser.getWeeklyAlbumChart should return the last album name", "AC/DC We Salute You: A Tribute", lastAlbum.name);
			assertEquals("FMUser.getWeeklyAlbumChart should return the last album playCount", 1, lastAlbum.playCount);
			assertEquals("FMUser.getWeeklyAlbumChart should return the last album mbid", "", lastAlbum.mbid);
			assertEquals("FMUser.getWeeklyAlbumChart should return the last album artist name", "Doug Pinnick", lastAlbum.artist.name);
			assertEquals("FMUser.getWeeklyAlbumChart should return the last album artist mbid", "8caafd6a-3a82-4e17-afb0-611fe49779b6", lastAlbum.artist.mbid);
		}
		
		public function testGetWeeklyArtistChart () : void
		{
			var o : FMUser = new FMUser();
			try{
				o.getWeeklyArtistChart();
				fail("to get user weekly artist chart, user should have a name");
			}catch(e : Error){
			}
			o.name = "foo";
			o.addEventListener(FMUser.GET_WEEKLY_ARTIST_CHART, onWeeklyArtistChartLoaded);
			o.getWeeklyArtistChart();
		}
		
		private function onWeeklyArtistChartLoaded ( event : Event ) : void
		{
			var o : FMUser = FMUser(event.currentTarget);
			assertTrue("FMUser.getWeeklyArtistChart should return some artists", o.weeklyArtistChart != null && o.weeklyArtistChart.length > 0);
			var firstArtist : FMArtist = o.weeklyArtistChart[0];
			assertEquals("FMUser.getWeeklyArtistChart should return the first artist name", "Gui Boratto", firstArtist.name);
			assertEquals("FMUser.getWeeklyArtistChart should return the first artist mbid", "f3e2ad21-900e-46a0-8597-2a3e457a7c27", firstArtist.mbid);
			assertEquals("FMUser.getWeeklyArtistChart should return the first artist playCount", 91, firstArtist.playCount);
			assertEquals("FMUser.getWeeklyArtistChart should return the first artist url", "http://www.last.fm/music/Gui+Boratto", firstArtist.url);
			var lastArtist : FMArtist = o.weeklyArtistChart.pop();
			assertEquals("FMUser.getWeeklyArtistChart should return the last artist name", "Nine Inch Nails", lastArtist.name);
			assertEquals("FMUser.getWeeklyArtistChart should return the last artist mbid", "b7ffd2af-418f-4be2-bdd1-22f8b48613da", lastArtist.mbid);
			assertEquals("FMUser.getWeeklyArtistChart should return the last artist playCount", 26, lastArtist.playCount);
			assertEquals("FMUser.getWeeklyArtistChart should return the last artist url", "http://www.last.fm/music/Nine+Inch+Nails", lastArtist.url);
		}
		
		public function testGetWeeklyTrackChart () : void
		{
			var o : FMUser = new FMUser();
			try{
				o.getWeeklyTrackChart();
				fail("to get user weekly track chart, user should have a name");
			}catch(e : Error){
			}
			o.name = "foo";
			o.addEventListener(FMUser.GET_WEEKLY_TRACK_CHART, onWeeklyTrackChartLoaded);
			o.getWeeklyTrackChart();
		}
		
		private function onWeeklyTrackChartLoaded ( event : Event ) : void
		{
			var o : FMUser = FMUser(event.currentTarget);
			assertTrue("FMUser.getWeeklyTrackChart should return some tracks", o.weeklyTrackChart != null && o.weeklyTrackChart.length > 0);
			var firstTrack : FMTrack = o.weeklyTrackChart[0];
			assertEquals("FMUser.getWeeklyTrackChart should return the first track name", "Murder Was The Case", firstTrack.name);
			assertEquals("FMUser.getWeeklyTrackChart should return the first track mbid", "", firstTrack.mbid);
			assertEquals("FMUser.getWeeklyTrackChart should return the first track playCount", 3, firstTrack.playCount);
			assertEquals("FMUser.getWeeklyTrackChart should return the first track url", "www.last.fm/music/Snoop+Dogg/_/Murder+Was+The+Case", firstTrack.url);
			assertEquals("FMUser.getWeeklyTrackChart should return the first track artist name", "Snoop Dogg", firstTrack.artist.name);
			assertEquals("FMUser.getWeeklyTrackChart should return the first track artist mbid", "f90e8b26-9e52-4669-a5c9-e28529c47894", firstTrack.artist.mbid);
			var lastTrack : FMTrack = o.weeklyTrackChart.pop();
			assertEquals("FMUser.getWeeklyTrackChart should return the last track name", "Come When I Call", lastTrack.name);
			assertEquals("FMUser.getWeeklyTrackChart should return the last track mbid", "", lastTrack.mbid);
			assertEquals("FMUser.getWeeklyTrackChart should return the last track playCount", 1, lastTrack.playCount);
			assertEquals("FMUser.getWeeklyTrackChart should return the last track url", "www.last.fm/music/Snoop+Dogg/_/Come+When+I+Call", lastTrack.url);
			assertEquals("FMUser.getWeeklyTrackChart should return the last track artist name", "Snoop Dogg", lastTrack.artist.name);
			assertEquals("FMUser.getWeeklyTrackChart should return the last track artist mbid", "f90e8b26-9e52-4669-a5c9-e28529c47894", lastTrack.artist.mbid);
		}
	}}