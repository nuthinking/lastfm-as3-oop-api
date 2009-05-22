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
package test.last.utils 
{	import fm.last.model.FMVenue;
	import fm.last.model.FMUser;
	import fm.last.model.FMTrack;
	import fm.last.search.FMTopTags;
	import fm.last.model.FMTag;
	import fm.last.model.FMPlayList;
	import fm.last.model.FMLibrary;
	import fm.last.model.FMGroup;
	import fm.last.model.FMEvent;
	import fm.last.model.FMArtist;
	import fm.last.model.FMAlbum;
	import fm.last.model.FMGeo;
	import fm.last.events.FMLoadEvent;
	import fm.last.utils.IFMLoader;

	import flash.events.EventDispatcher;
	import flash.net.URLRequestMethod;
	import flash.utils.Dictionary;

	/**	 * @author christian	 */	public class TestLoader extends EventDispatcher implements IFMLoader 
	{
		// GEO
		[Embed("../../../data/responses/geo/getTopArtists.xml", mimeType="application/octet-stream")]
      	private static const GET_TOP_ARTISTS_XML_CLASS:Class;
      	
      	[Embed("../../../data/responses/geo/getTopTracks.xml", mimeType="application/octet-stream")]
      	private static const GET_TOP_TRACKS_XML_CLASS:Class;
      	
      	[Embed("../../../data/responses/geo/getEventsP1.xml", mimeType="application/octet-stream")]
      	private static const GET_EVENTS_P1_XML_CLASS:Class;
      	
      	[Embed("../../../data/responses/geo/getEventsP2.xml", mimeType="application/octet-stream")]
      	private static const GET_EVENTS_P2_XML_CLASS:Class;
      	
      	
      	
      	// ALBUM
      	[Embed("../../../data/responses/album/searchP1.xml", mimeType="application/octet-stream")]
      	private static const SEARCH_ALBUM_P1_XML_CLASS:Class;
      	
      	[Embed("../../../data/responses/album/searchP2.xml", mimeType="application/octet-stream")]
      	private static const SEARCH_ALBUM_P2_XML_CLASS:Class;
      	
      	[Embed("../../../data/responses/album/getInfo.xml", mimeType="application/octet-stream")]
      	private static const ALBUM_GET_INFO_XML_CLASS:Class;
      	
      	[Embed("../../../data/responses/geo/getEventsP1.xml", mimeType="application/octet-stream")]
      	private static const ALBUM_GET_EVENTS_XML_CLASS:Class;
      	
      	
      	
      	// ARTIST
      	[Embed("../../../data/responses/artist/getImagesP1.xml", mimeType="application/octet-stream")]
      	private static const ARTIST_GET_IMAGES_P1_XML_CLASS:Class;
      	
      	[Embed("../../../data/responses/artist/getImagesP2.xml", mimeType="application/octet-stream")]
      	private static const ARTIST_GET_IMAGES_P2_XML_CLASS:Class;
      	
      	[Embed("../../../data/responses/artist/getInfo.xml", mimeType="application/octet-stream")]
      	private static const ARTIST_GET_INFO_XML_CLASS:Class;
      	
      	[Embed("../../../data/responses/artist/getShouts.xml", mimeType="application/octet-stream")]
      	private static const ARTIST_GET_SHOUTS_XML_CLASS:Class;
      	
      	[Embed("../../../data/responses/artist/getSimilar.xml", mimeType="application/octet-stream")]
      	private static const ARTIST_GET_SIMILAR_XML_CLASS:Class;
      	
      	[Embed("../../../data/responses/artist/getTopAlbums.xml", mimeType="application/octet-stream")]
      	private static const ARTIST_GET_TOP_ALBUMS_XML_CLASS:Class;
      	
      	[Embed("../../../data/responses/artist/getTopFans.xml", mimeType="application/octet-stream")]
      	private static const ARTIST_GET_TOP_FANS_XML_CLASS:Class;
      	
      	[Embed("../../../data/responses/artist/getTopTags.xml", mimeType="application/octet-stream")]
      	private static const ARTIST_GET_TOP_TAGS_XML_CLASS:Class;
      	
      	[Embed("../../../data/responses/artist/searchP1.xml", mimeType="application/octet-stream")]
      	private static const ARTIST_SEARCH_P1_XML_CLASS:Class;
      	
      	[Embed("../../../data/responses/artist/searchP2.xml", mimeType="application/octet-stream")]
      	private static const ARTIST_SEARCH_P2_XML_CLASS:Class;
		
		
		
		// EVENT
		[Embed("../../../data/responses/event/getAttendees.xml", mimeType="application/octet-stream")]
      	private static const EVENT_GET_ATTENDEES_XML_CLASS:Class;

		[Embed("../../../data/responses/event/getInfo.xml", mimeType="application/octet-stream")]
      	private static const EVENT_GET_INFO_XML_CLASS:Class;
		
		
		
		// GROUP
		[Embed("../../../data/responses/group/getMembersP1.xml", mimeType="application/octet-stream")]
      	private static const GROUP_GET_MEMBERS_P1_XML_CLASS:Class;

		[Embed("../../../data/responses/group/getMembersP2.xml", mimeType="application/octet-stream")]
      	private static const GROUP_GET_MEMBERS_P2_XML_CLASS:Class;
      	
      	[Embed("../../../data/responses/group/getWeeklyChartList.xml", mimeType="application/octet-stream")]
      	private static const GROUP_GET_WEEKLY_CHART_LIST_XML_CLASS:Class;
      	
      	[Embed("../../../data/responses/group/getWeeklyAlbumChart.xml", mimeType="application/octet-stream")]
      	private static const GROUP_GET_WEEKLY_ALBUM_CHART_XML_CLASS:Class;
      	
      	[Embed("../../../data/responses/group/getWeeklyArtistChart.xml", mimeType="application/octet-stream")]
      	private static const GROUP_GET_WEEKLY_ARTIST_CHART_XML_CLASS:Class;
      	
      	[Embed("../../../data/responses/group/getWeeklyTrackChart.xml", mimeType="application/octet-stream")]
      	private static const GROUP_GET_WEEKLY_TRACK_CHART_XML_CLASS:Class;
      	
      	
      	
		// LIBRARY
		[Embed("../../../data/responses/library/getAlbumsP1.xml", mimeType="application/octet-stream")]
      	private static const LIBRARY_GET_ALBUMS_P1_XML_CLASS:Class;
      	
		[Embed("../../../data/responses/library/getAlbumsP2.xml", mimeType="application/octet-stream")]
      	private static const LIBRARY_GET_ALBUMS_P2_XML_CLASS:Class;
      	
		[Embed("../../../data/responses/library/getArtistsP1.xml", mimeType="application/octet-stream")]
      	private static const LIBRARY_GET_ARTISTS_P1_XML_CLASS:Class;
      	
		[Embed("../../../data/responses/library/getArtistsP2.xml", mimeType="application/octet-stream")]
      	private static const LIBRARY_GET_ARTISTS_P2_XML_CLASS:Class;
      	
		[Embed("../../../data/responses/library/getTracksP1.xml", mimeType="application/octet-stream")]
      	private static const LIBRARY_GET_TRACKS_P1_XML_CLASS:Class;
      	
		[Embed("../../../data/responses/library/getTracksP2.xml", mimeType="application/octet-stream")]
      	private static const LIBRARY_GET_TRACKS_P2_XML_CLASS:Class;
      	
      	
      	
      	// PLAYLIST
      	[Embed("../../../data/responses/playlist/fetch.xml", mimeType="application/octet-stream")]
      	private static const PLAYLIST_FETCH_XML_CLASS:Class;
      	
      	
      	
      	// TAG
      	[Embed("../../../data/responses/tag/getSimilar.xml", mimeType="application/octet-stream")]
      	private static const TAG_GET_SIMILAR_XML_CLASS:Class;

      	[Embed("../../../data/responses/tag/getTopAlbums.xml", mimeType="application/octet-stream")]
      	private static const TAG_GET_TOP_ALBUMS_XML_CLASS:Class;

      	[Embed("../../../data/responses/tag/getTopArtists.xml", mimeType="application/octet-stream")]
      	private static const TAG_GET_TOP_ARTISTS_XML_CLASS:Class;

      	[Embed("../../../data/responses/tag/getTopTracks.xml", mimeType="application/octet-stream")]
      	private static const TAG_GET_TOP_TRACKS_XML_CLASS:Class;
      	
      	[Embed("../../../data/responses/tag/getWeeklyArtistChart.xml", mimeType="application/octet-stream")]
      	private static const TAG_GET_WEEKLY_ARTIST_CHART_XML_CLASS:Class;
      	
      	[Embed("../../../data/responses/tag/getTopTags.xml", mimeType="application/octet-stream")]
      	private static const TAG_GET_TOP_TAGS_XML_CLASS:Class;
      		
      	[Embed("../../../data/responses/tag/search.xml", mimeType="application/octet-stream")]
      	private static const TAG_SEARCH_XML_CLASS:Class;
      	
      	
      	
      	// TRACK
      	[Embed("../../../data/responses/track/getInfo.xml", mimeType="application/octet-stream")]
      	private static const TRACK_GET_INFO_XML_CLASS:Class;
      	
      	[Embed("../../../data/responses/track/getSimilar.xml", mimeType="application/octet-stream")]
      	private static const TRACK_GET_SIMILAR_XML_CLASS:Class;
      	
      	[Embed("../../../data/responses/track/getTopFans.xml", mimeType="application/octet-stream")]
      	private static const TRACK_GET_TOP_FANS_XML_CLASS:Class;
      	
      	[Embed("../../../data/responses/track/search.xml", mimeType="application/octet-stream")]
      	private static const TRACK_SEARCH_XML_CLASS:Class;
      	
      	
      	
      	// USER
      	[Embed("../../../data/responses/user/getEvents.xml", mimeType="application/octet-stream")]
      	private static const USER_GET_EVENTS_XML_CLASS:Class;
      	
      	[Embed("../../../data/responses/user/getFriendsP1.xml", mimeType="application/octet-stream")]
      	private static const USER_GET_FRIENDS_P1_XML_CLASS:Class;
      	
      	[Embed("../../../data/responses/user/getFriendsP2.xml", mimeType="application/octet-stream")]
      	private static const USER_GET_FRIENDS_P2_XML_CLASS:Class;
      	
      	[Embed("../../../data/responses/user/getLovedTracks.xml", mimeType="application/octet-stream")]
      	private static const USER_GET_LOVED_TRACKS_XML_CLASS:Class;
      	
      	[Embed("../../../data/responses/user/getNeighbours.xml", mimeType="application/octet-stream")]
      	private static const USER_GET_NEIGHBOURS_XML_CLASS:Class;
      	
      	[Embed("../../../data/responses/user/getPastEventsP1.xml", mimeType="application/octet-stream")]
      	private static const USER_GET_PAST_EVENTS_P1_XML_CLASS:Class;
      	
      	[Embed("../../../data/responses/user/getPastEventsP2.xml", mimeType="application/octet-stream")]
      	private static const USER_GET_PAST_EVENTS_P2_XML_CLASS:Class;
      	
      	[Embed("../../../data/responses/user/getPlaylists.xml", mimeType="application/octet-stream")]
      	private static const USER_GET_PLAYLISTS_XML_CLASS:Class;
      	
      	[Embed("../../../data/responses/user/getRecentTracks.xml", mimeType="application/octet-stream")]
      	private static const USER_GET_RECENT_TRACKS_XML_CLASS:Class;
      	
      	[Embed("../../../data/responses/user/getShouts.xml", mimeType="application/octet-stream")]
      	private static const USER_GET_SHOUTS_XML_CLASS:Class;
      	
      	[Embed("../../../data/responses/user/getTopArtists.xml", mimeType="application/octet-stream")]
      	private static const USER_GET_TOP_ARTISTS_XML_CLASS:Class;
      	
      	[Embed("../../../data/responses/user/getTopTags.xml", mimeType="application/octet-stream")]
      	private static const USER_GET_TOP_TAGS_XML_CLASS:Class;
      	
      	[Embed("../../../data/responses/user/getTopTracks.xml", mimeType="application/octet-stream")]
      	private static const USER_GET_TOP_TRACKS_XML_CLASS:Class;
      	
      	[Embed("../../../data/responses/user/getWeeklyChartList.xml", mimeType="application/octet-stream")]
      	private static const USER_GET_WEEKLY_CHART_LIST_XML_CLASS:Class;
      	
      	[Embed("../../../data/responses/user/getWeeklyAlbumChart.xml", mimeType="application/octet-stream")]
      	private static const USER_GET_WEEKLY_ALBUM_CHART_XML_CLASS:Class;
      	
      	[Embed("../../../data/responses/user/getWeeklyArtistChart.xml", mimeType="application/octet-stream")]
      	private static const USER_GET_WEEKLY_ARTIST_CHART_XML_CLASS:Class;
      	
      	[Embed("../../../data/responses/user/getWeeklyTrackChart.xml", mimeType="application/octet-stream")]
      	private static const USER_GET_WEEKLY_TRACK_CHART_XML_CLASS:Class;
      	
      	
      	
      	// VENUE
      	[Embed("../../../data/responses/venue/getEvents.xml", mimeType="application/octet-stream")]
      	private static const VENUE_GET_EVENTS_XML_CLASS:Class;

      	[Embed("../../../data/responses/venue/getPastEventsP1.xml", mimeType="application/octet-stream")]
      	private static const VENUE_GET_PAST_EVENTS_P1_XML_CLASS:Class;

      	[Embed("../../../data/responses/venue/getPastEventsP2.xml", mimeType="application/octet-stream")]
      	private static const VENUE_GET_PAST_EVENTS_P2_XML_CLASS:Class;

      	[Embed("../../../data/responses/venue/search.xml", mimeType="application/octet-stream")]
      	private static const VENUE_SEARCH_XML_CLASS:Class;
      	
      	
      	
      	
		private var responseDict : Dictionary;		public function TestLoader()
		{			super(null);
			
			initResponses();		}
		
		private function initResponses() : void
		{
			responseDict = new Dictionary();
			responseDict[FMGeo.GET_TOP_ARTISTS] = new TestResponse(GET_TOP_ARTISTS_XML_CLASS);
			responseDict[FMGeo.GET_TOP_TRACKS] = new TestResponse(GET_TOP_TRACKS_XML_CLASS);
			responseDict[FMGeo.GET_EVENTS] = new TestMultiPageResponse([GET_EVENTS_P1_XML_CLASS, GET_EVENTS_P2_XML_CLASS]);
			
			responseDict[FMAlbum.GET_INFO] = new TestResponse(ALBUM_GET_INFO_XML_CLASS);
			responseDict["album.search"] = new TestMultiPageResponse([SEARCH_ALBUM_P1_XML_CLASS, SEARCH_ALBUM_P2_XML_CLASS]);

			responseDict[FMArtist.GET_EVENTS] = new TestResponse(ALBUM_GET_EVENTS_XML_CLASS);
			responseDict[FMArtist.GET_IMAGES] = new TestMultiPageResponse([ARTIST_GET_IMAGES_P1_XML_CLASS, ARTIST_GET_IMAGES_P2_XML_CLASS]);
			responseDict[FMArtist.GET_INFO] = new TestResponse(ARTIST_GET_INFO_XML_CLASS);
			responseDict[FMArtist.GET_SHOUTS] = new TestResponse(ARTIST_GET_SHOUTS_XML_CLASS);
			responseDict[FMArtist.GET_SIMILAR] = new TestResponse(ARTIST_GET_SIMILAR_XML_CLASS);
			responseDict[FMArtist.GET_TOP_ALBUMS] = new TestResponse(ARTIST_GET_TOP_ALBUMS_XML_CLASS);
			responseDict[FMArtist.GET_TOP_FANS] = new TestResponse(ARTIST_GET_TOP_FANS_XML_CLASS);
			responseDict[FMArtist.GET_TOP_TAGS] = new TestResponse(ARTIST_GET_TOP_TAGS_XML_CLASS);
			responseDict[FMArtist.GET_TOP_TRACKS] = new TestResponse(GET_TOP_TRACKS_XML_CLASS);
			responseDict["artist.search"] = new TestMultiPageResponse([ARTIST_SEARCH_P1_XML_CLASS, ARTIST_SEARCH_P2_XML_CLASS]);
			
			responseDict[FMEvent.GET_ATTENDEES] = new TestResponse(EVENT_GET_ATTENDEES_XML_CLASS);
			responseDict[FMEvent.GET_INFO] = new TestResponse(EVENT_GET_INFO_XML_CLASS);
			responseDict[FMEvent.GET_SHOUTS] = new TestResponse(ARTIST_GET_SHOUTS_XML_CLASS);
			
			responseDict[FMGroup.GET_MEMBERS] = new TestMultiPageResponse([GROUP_GET_MEMBERS_P1_XML_CLASS, GROUP_GET_MEMBERS_P2_XML_CLASS]);
			responseDict[FMGroup.GET_WEEKLY_CHART_LIST] = new TestResponse(GROUP_GET_WEEKLY_CHART_LIST_XML_CLASS);
			responseDict[FMGroup.GET_WEEKLY_ALBUM_CHART] = new TestResponse(GROUP_GET_WEEKLY_ALBUM_CHART_XML_CLASS);
			responseDict[FMGroup.GET_WEEKLY_ARTIST_CHART] = new TestResponse(GROUP_GET_WEEKLY_ARTIST_CHART_XML_CLASS);
			responseDict[FMGroup.GET_WEEKLY_TRACK_CHART] = new TestResponse(GROUP_GET_WEEKLY_TRACK_CHART_XML_CLASS);
			
			responseDict[FMLibrary.GET_ALBUMS] = new TestMultiPageResponse([LIBRARY_GET_ALBUMS_P1_XML_CLASS, LIBRARY_GET_ALBUMS_P2_XML_CLASS]);
			responseDict[FMLibrary.GET_ARTISTS] = new TestMultiPageResponse([LIBRARY_GET_ARTISTS_P1_XML_CLASS, LIBRARY_GET_ARTISTS_P2_XML_CLASS]);
			responseDict[FMLibrary.GET_TRACKS] = new TestMultiPageResponse([LIBRARY_GET_TRACKS_P1_XML_CLASS, LIBRARY_GET_TRACKS_P2_XML_CLASS]);

			responseDict[FMPlayList.FETCH] = new TestResponse(PLAYLIST_FETCH_XML_CLASS);
			
			responseDict[FMTag.GET_SIMILAR] = new TestResponse(TAG_GET_SIMILAR_XML_CLASS);
			responseDict[FMTag.GET_TOP_ALBUMS] = new TestResponse(TAG_GET_TOP_ALBUMS_XML_CLASS);
			responseDict[FMTag.GET_TOP_ARTISTS] = new TestResponse(TAG_GET_TOP_ARTISTS_XML_CLASS);
			responseDict[FMTag.GET_TOP_TRACKS] = new TestResponse(TAG_GET_TOP_TRACKS_XML_CLASS);
			responseDict[FMTopTags.GET_TOP_TAGS] = new TestResponse(TAG_GET_TOP_TAGS_XML_CLASS);
			responseDict["tag.search"] = new TestResponse(TAG_SEARCH_XML_CLASS);

			responseDict[FMTrack.GET_INFO] = new TestResponse(TRACK_GET_INFO_XML_CLASS);
			responseDict[FMTrack.GET_SIMILAR] = new TestResponse(TRACK_GET_SIMILAR_XML_CLASS);
			responseDict[FMTrack.GET_TOP_FANS] = new TestResponse(TRACK_GET_TOP_FANS_XML_CLASS);
			responseDict[FMTrack.GET_TOP_TAGS] = new TestResponse(ARTIST_GET_TOP_TAGS_XML_CLASS);
			responseDict["track.search"] = new TestResponse(TRACK_SEARCH_XML_CLASS);

			responseDict[FMUser.GET_EVENTS] = new TestResponse(USER_GET_EVENTS_XML_CLASS);
			responseDict[FMUser.GET_FRIENDS] = new TestMultiPageResponse([USER_GET_FRIENDS_P1_XML_CLASS, USER_GET_FRIENDS_P2_XML_CLASS]);
			responseDict[FMUser.GET_LOVED_TRACKS] = new TestResponse(USER_GET_LOVED_TRACKS_XML_CLASS); 
			responseDict[FMUser.GET_NEIGHBOURS] = new TestResponse(USER_GET_NEIGHBOURS_XML_CLASS); 
			responseDict[FMUser.GET_PAST_EVENTS] = new TestMultiPageResponse([USER_GET_PAST_EVENTS_P1_XML_CLASS, USER_GET_PAST_EVENTS_P2_XML_CLASS]);
			responseDict[FMUser.GET_PLAYLISTS] = new TestResponse(USER_GET_PLAYLISTS_XML_CLASS); 
			responseDict[FMUser.GET_RECENT_TRACKS] = new TestResponse(USER_GET_RECENT_TRACKS_XML_CLASS); 
			responseDict[FMUser.GET_SHOUTS] = new TestResponse(USER_GET_SHOUTS_XML_CLASS); 
			responseDict[FMUser.GET_TOP_ALBUMS] = new TestResponse(ARTIST_GET_TOP_ALBUMS_XML_CLASS); 
			responseDict[FMUser.GET_TOP_ARTISTS] = new TestResponse(USER_GET_TOP_ARTISTS_XML_CLASS); 
			responseDict[FMUser.GET_TOP_TAGS] = new TestResponse(USER_GET_TOP_TAGS_XML_CLASS); 
			responseDict[FMUser.GET_TOP_TRACKS] = new TestResponse(USER_GET_TOP_TRACKS_XML_CLASS);
			responseDict[FMUser.GET_WEEKLY_CHART_LIST] = new TestResponse(USER_GET_WEEKLY_CHART_LIST_XML_CLASS);
			responseDict[FMUser.GET_WEEKLY_ALBUM_CHART] = new TestResponse(USER_GET_WEEKLY_ALBUM_CHART_XML_CLASS);
			responseDict[FMUser.GET_WEEKLY_ARTIST_CHART] = new TestResponse(USER_GET_WEEKLY_ARTIST_CHART_XML_CLASS);
			responseDict[FMUser.GET_WEEKLY_TRACK_CHART] = new TestResponse(USER_GET_WEEKLY_TRACK_CHART_XML_CLASS);
			
			responseDict[FMVenue.GET_EVENTS] = new TestResponse(VENUE_GET_EVENTS_XML_CLASS);
			responseDict[FMVenue.GET_PAST_EVENTS] = new TestMultiPageResponse([VENUE_GET_PAST_EVENTS_P1_XML_CLASS, VENUE_GET_PAST_EVENTS_P2_XML_CLASS]);
			responseDict["venue.search"] = new TestResponse(VENUE_SEARCH_XML_CLASS);
		}

		public function requestUrl(methodName : String, variables : Object, requestMethod : String = URLRequestMethod.GET) : void
		{
			var response : TestResponse = responseDict[methodName];
			if(response == null)
				throw new Error("TestLoader couldn't find response for method: " + methodName);
			var responseXML : XML = response.getResponse(variables);
			dispatchEvent(new FMLoadEvent(FMLoadEvent.LOAD_COMPLETE, responseXML));		}
	}}