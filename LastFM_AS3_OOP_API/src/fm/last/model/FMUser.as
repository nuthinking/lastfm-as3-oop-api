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
package fm.last.model
{
	import fm.last.enum.FMPeriodType;
	import fm.last.model.vo.FMChart;
	import fm.last.utils.PageResults;

	import flash.events.Event;

	/**
	 * Incapsulates all the methods of the Last.fm user web service
     */
	public class FMUser extends FMModelBase
	{
		public static const GET_EVENTS:String = "user.getEvents";
		public static const GET_FRIENDS:String = "user.getFriends";
		public static const GET_LOVED_TRACKS:String = "user.getLovedTracks";
		public static const GET_NEIGHBOURS:String = "user.getNeighbours";
		public static const GET_PAST_EVENTS:String = "user.getPastEvents";
		public static const GET_PLAYLISTS:String = "user.getPlaylists";
		public static const GET_RECENT_TRACKS:String = "user.getRecentTracks";
		public static const GET_SHOUTS:String = "user.getShouts";
		public static const GET_TOP_ALBUMS:String = "user.getTopAlbums";
		public static const GET_TOP_ARTISTS:String = "user.getTopArtists";
		public static const GET_TOP_TAGS:String = "user.getTopTags";
		public static const GET_TOP_TRACKS:String = "user.getTopTracks";
		public static const GET_WEEKLY_ALBUM_CHART:String = "user.getWeeklyAlbumChart";
		public static const GET_WEEKLY_ARTIST_CHART:String = "user.getWeeklyArtistChart";
		public static const GET_WEEKLY_CHART_LIST:String = "user.getWeeklyChartList";
		public static const GET_WEEKLY_TRACK_CHART:String = "user.getWeeklyTrackChart";
		
		public var name : String;
		public var realname : String;
		public var url : String;
		public var weight : int;
		public var match : Number;
		public var events : Array;
		
		public var recentTrack : FMTrack;
		
		private var friendsResults : PageResults;
		private var hasToGetFriendsRecentTracks : Boolean;
		public var lovedTracks : Array;
		public var neighbours : Array;
		private var pastEventsResults : PageResults;
		public var playlists : Array;
		public var recentTracks : Array;
		public var shouts : Array;
		public var topAlbums : Array;
		public var topArtists : Array;
		public var topTags : Array;
		public var topTracks : Array;
		public var weeklyChartList : Array;
		public var weeklyAlbumChart : Array;
		public var weeklyArtistChart : Array;
		public var weeklyTrackChart : Array;
		
		/**
		 * Creates an instance of the model starting from the XML node returned by the web service
		 * 
		 * @param the xml node representing the model
		 * @return the new populated instance
		 */
		public static function createFromXML( xml : XML ) : FMUser
		{
			var r : FMUser = new FMUser();
			r.populateFromXML(xml);
			return r;
		}

		public function FMUser(name : String = null)
		{
			this.name = name;
		}
		
		/**
		 * Populate the model from the different XML formats returned by the web service
		 * 
		 * @param the XML node representing the model
		 */
		protected function populateFromXML ( xml : XML ) : void
		{
			name = xml.name.text();
			if(xml.realname[0] != null)
				realname = xml.realname.text();
			url = xml.url.text();
			addImages(xml.image);
			if(xml.weight[0] != null)
				weight = parseInt(xml.weight.text());
			if(xml.recenttrack[0] != null)
				recentTrack = mf.createTrack(xml.recenttrack[0]);
			if(xml.match[0])
				match = parseFloat(xml.match[0]);
		}
		
		public function get friends () : Array
		{
			if(friendsResults == null)
				return null;
			return friendsResults.items;
		}
		
		public function get pastEvents () : Array
		{
			if(pastEventsResults == null)
				return null;
			return pastEventsResults.items;
		}

		/**
		 * Get the list of the upcoming events that this user is attending.
		 * 
		 * Ref: http://www.last.fm/api/show?service=291
		 */
		public function getEvents() : void
		{
			assert(name != null, "to get user events, user should have the name set");
			
			requestURL(GET_EVENTS, {user: name}, onEventsLoaded);
		}
		private function onEventsLoaded ( response : XML ) : void
		{
			events = [];
			var children : XMLList = response.events.event;
			for each( var child : XML in children) {
				events.push(mf.createEvent(child));
			}
			dispatchEvent(new Event(GET_EVENTS));
		}
		
		/**
		 * Get a list of friends for this user, and eventually their recent tracks.
		 * 
		 * Ref: http://www.last.fm/api/show?service=263
		 */
		public function getFriends(recentTracks:Boolean = false, limit:int = 50):void
		{
			assert(name != null, "to get user friends, user should have the name set");
			assert(limit > 0, "you should request more than 0 friends");
			
			hasToGetFriendsRecentTracks = recentTracks;
			friendsResults = new PageResults(limit);
			getNextFriends();
		}
		
		private function getNextFriends () : void
		{
			var variables : Object = {
				user: name,
				page: friendsResults.currentPage + 1
			};
			if(hasToGetFriendsRecentTracks)
				variables.recenttracks = 1;
			requestURL(GET_FRIENDS, variables, onFriendsLoaded);
		}
		
		private function onFriendsLoaded ( response : XML ) : void
		{
			var items : Array = [];
			var children : XMLList = response.friends.user;
			for each(var child : XML in children) {
				items.push(mf.createUser(child));
			}
			friendsResults.addPage(items);
			var page : uint = parseInt(response.friends.@page);
			var totalpages : uint = parseInt(response.friends.@totalPages);
			if(!friendsResults.isFilled && page < totalpages){
				getNextFriends();
			}else{
				dispatchEvent(new Event(GET_FRIENDS));
			}
		}
		
		/**
		 * Get the last 50 tracks loved by this user.
		 * 
		 * Ref: http://www.last.fm/api/show?service=329
		 */
		public function getLovedTracks() : void
		{
			assert(name != null, "to get user loved tracks, user should have the name set");
			
			requestURL(GET_LOVED_TRACKS, {user: name}, onLovedTracksLoaded);
		}
		
		private function onLovedTracksLoaded ( response : XML ) : void
		{
			lovedTracks = [];
			var children : XMLList = response.lovedtracks.track;
			for each(var child : XML in children) {
				lovedTracks.push(mf.createTrack(child));
			}
			dispatchEvent(new Event(GET_LOVED_TRACKS));
		}
		
		/**
		 * Get a the neighbours for this user.
		 * 
		 * Ref: http://www.last.fm/api/show?service=264
		 */
		public function getNeighbours(limit:int = 60):void
		{
			assert(name != null, "to get user loved tracks, user should have the name set");
			assert(limit > 0, "you should request more than 0 neighbours");
			
			requestURL(GET_NEIGHBOURS, {user: name, limit: limit}, onNeighBoursLoaded);
		}
		
		private function onNeighBoursLoaded ( response : XML ) : void
		{
			neighbours = [];
			var children : XMLList = response.neighbours.user;
			for each(var child : XML in children) {
				neighbours.push(mf.createUser(child));
			}
			dispatchEvent(new Event(GET_NEIGHBOURS));
		}
		
		/**
		 * Get the list of all the events this user has attended in the past. 
		 * 
		 * Ref: http://www.last.fm/api/show?service=343
		 */
		 
		public function getPastEvents(limit:uint = 30) : void
		{
			assert(name != null, "to get user past events, user should have the name set");
			assert(limit > 0, "you should request more than 0 past events");
			
			pastEventsResults = new PageResults(limit);
			getNextPastEvents();
		}
		
		private function getNextPastEvents () : void
		{
			var variables : Object = {
				user: name,
				page: pastEventsResults.currentPage + 1
			};
			requestURL(GET_PAST_EVENTS, variables, onNextPastEventsLoaded);
		}
		
		private function onNextPastEventsLoaded ( response : XML ) : void
		{
			var items : Array = [];
			var children : XMLList = response.events.event;
			for each(var child : XML in children) {
				items.push(mf.createEvent(child));
			}
			pastEventsResults.addPage(items);
			var page : uint = parseInt(response.events.@page);
			var totalpages : uint = parseInt(response.events.@totalPages);
			if(!pastEventsResults.isFilled && page < totalpages){
				getNextPastEvents();
			}else{
				dispatchEvent(new Event(GET_PAST_EVENTS));
			}
		}
		
		/**
		 * Get the list of this user's playlists.
		 * 
		 * Ref: http://www.last.fm/api/show?service=313
		 */
		public function getPlaylists() : void
		{
			assert(name != null, "to get user playlists, user should have the name set");
			
			requestURL(GET_PLAYLISTS, {user: name}, onPlaylistLoaded);
		}
		
		private function onPlaylistLoaded ( response : XML ) : void
		{
			playlists = [];
			var children : XMLList = response.playlists.playlist;
			for each(var child : XML in children) {
				playlists.push(mf.createPlayList(child));
			}
			dispatchEvent(new Event(GET_PLAYLISTS));
		}
		
		/**
		 * Get a list of the recent tracks listened to by this user.
		 * Indicates now playing track if the user is currently listening.
		 * 
		 * If limit is equals to 0, it will return the maximum available
		 * 
		 * Ref: http://www.last.fm/api/show?service=278
		 */
		public function getRecentTracks(limit:uint = 10) : void
		{
			assert(name != null, "to get user playlists, user should have the name set");
			assert(limit > -1, "you should request more than -1 past events");
			
			requestURL(GET_RECENT_TRACKS, {user: name, limit: limit}, onRecentTracksLoaded);
		}
		
		private function onRecentTracksLoaded ( response : XML ) : void
		{
			recentTracks = [];
			var children : XMLList = response.recenttracks.track;
			for each(var child : XML in children) {
				recentTracks.push(mf.createTrack(child));
			}
			dispatchEvent(new Event(GET_RECENT_TRACKS));
		}
		
		/**
		 * Get the shouts for this user.
		 * 
		 * Ref: http://www.last.fm/api/show?service=401
		 */
		
		public function getShouts () : void
		{
			assert(name != null, "to get user shouts, user should have the name set");
			
			requestURL(GET_SHOUTS, {user: name}, onShoutsLoaded);
		}
		
		private function onShoutsLoaded ( response : XML ) : void
		{
			shouts = [];
			var children : XMLList = response.shouts.shout;
			for each(var child : XML in children) {
				shouts.push(mf.createShout(child));
			}
			dispatchEvent(new Event(GET_SHOUTS));
		}
		
		/**
		 * Get the top albums listened to by this user.
		 * You can stipulate a time period.
		 * Sends the overall chart by default.
		 * 
		 * Ref: http://www.last.fm/api/show?service=299
		 */
		
		public function getTopAlbums (period : FMPeriodType = null)  : void
		{
			assert(name != null, "to get top albums, user should have the name set");
			
			if(period == null)
				period =  FMPeriodType.OVERALL;
				
			requestURL(GET_TOP_ALBUMS, {user: name, period: period.value}, onTopAlbumsLoaded);
		}
		
		private function onTopAlbumsLoaded ( response : XML ) : void
		{
			topAlbums = [];
			var children : XMLList = response.topalbums.album;
			for each(var child : XML in children){
				topAlbums.push(mf.createAlbum(child));
			}
			dispatchEvent(new Event(GET_TOP_ALBUMS));
		}
		
		/**
		 * Get the top artists listened to by this user.
		 * You can stipulate a time period.
		 * Sends the overall chart by default. 
		 * 
		 * Ref: http://www.last.fm/api/show?service=300
		 */
		public function getTopArtists(period : FMPeriodType = null) : void
		{
			assert(name != null, "to get top artists, user should have the name set");
			
			if(period == null)
				period =  FMPeriodType.OVERALL;
			
			requestURL(GET_TOP_ARTISTS, {user: name, period: period.value}, onTopArtistsLoaded);
		}
		
		private function onTopArtistsLoaded ( response : XML ) : void
		{
			topArtists = [];
			var children : XMLList = response.topartists.artist;
			for each(var child : XML in children){
				topArtists.push(mf.createArtist(child));
			}
			dispatchEvent(new Event(GET_TOP_ARTISTS));
		}
		
		/**
		 * Get the top tags used by this user.
		 * @param if 0, will return without limit
		 * 
		 * Ref: http://www.last.fm/api/show?service=123
		 */
		public function getTopTags(limit:int = 30):void
		{
			assert(name != null, "to get top tags, user should have the name set");
			assert(limit > -1, "you should request more than -1 past events");
			
			requestURL(GET_TOP_TAGS, {user: name, limit: limit}, onTopTagsLoaded);
		}
		
		private function onTopTagsLoaded ( response : XML ) : void
		{
			topTags = [];
			var children : XMLList = response.toptags.tag;
			for each(var child : XML in children) {
				topTags.push(mf.createTag(child));
			}
			dispatchEvent(new Event(GET_TOP_TAGS));
		}
		
		/**
		 * Get the top tracks listened to by this user.
		 * You can stipulate a time period.
		 * Sends the overall chart by default.
		 * 
		 * Ref: http://www.last.fm/api/show?service=301
		 */
		public function getTopTracks(period : FMPeriodType = null) : void
		{
			assert(name != null, "to get top tracks, user should have the name set");
			
			if(period == null)
				period =  FMPeriodType.OVERALL;
				
			requestURL(GET_TOP_TRACKS, {user: name, period: period.value}, onTopTracksLoaded);
		}
		
		private function onTopTracksLoaded ( response : XML ) : void
		{
			topTracks = [];
			var children : XMLList = response.toptracks.track;
			for each(var child : XML in children) {
				topTracks.push(mf.createTrack(child));
			}
			dispatchEvent(new Event(GET_TOP_TRACKS));
		}
		
		/**
		 * Get the album chart for this user, for a given date range.
		 * If no date range is supplied, it will return the most recent album chart for this user. 
		 * 
		 * Ref: http://www.last.fm/api/show?service=279
		 */
		
		public function getWeeklyAlbumChart(chart : FMChart = null) : void
		{
			assert(name != null, "To get the user weekly album chart, you must supply the user name" );
			
			var variables : Object = {user: name};
			if(chart != null){
				variables.from = chart.dateFromAsInt;
				variables.to = chart.dateToAsInt;
			}
			requestURL(GET_WEEKLY_ALBUM_CHART, variables, onWeeklyAlbumChartLoaded);
		}
		
		private function onWeeklyAlbumChartLoaded ( response : XML ) : void
		{
			weeklyAlbumChart = [];
			var children : XMLList = response.weeklyalbumchart.album;
			for each (var child : XML in children) {
				weeklyAlbumChart.push(mf.createAlbum(child));
			}
			dispatchEvent(new Event(GET_WEEKLY_ALBUM_CHART));
		}
		
		/**
		 * Get the artist chart for this user, for a given date range.
		 * If no date range is supplied, it will return the most recent artist chart for this user. 
		 * 
		 * Ref: http://www.last.fm/api/show?service=281
		 */
		
		public function getWeeklyArtistChart( chart : FMChart = null ) : void
		{
			assert(name != null, "To get the user weekly artist chart, you must supply the user name" );
			
			var variables : Object = {user: name};
			if(chart != null) {
				variables.from = chart.dateFromAsInt;
				variables.to = chart.dateToAsInt;
			}
			requestURL(GET_WEEKLY_ARTIST_CHART, variables, onWeeklyArtistChartLoaded);
		}
		private function onWeeklyArtistChartLoaded ( response : XML ) : void
		{
			weeklyArtistChart = [];
			var children : XMLList = response.weeklyartistchart.artist;
			for each (var child : XML in children) {
				weeklyArtistChart.push(mf.createArtist(child));
			}
			dispatchEvent(new Event(GET_WEEKLY_ARTIST_CHART));
		}
		
		/**
		 * Get the list of available charts for this user, expressed as date ranges which can be sent to the chart services. 
		 * 
		 * Ref: http://www.last.fm/api/show?service=280
		 */
		
		public function getWeeklyChartList():void
		{
			assert(name != null, "To get the user weekly chart list, you must supply the user name" );
			
			requestURL(GET_WEEKLY_CHART_LIST, {user: name}, onWeeklyChartListLoaded);
		}
		
		private function onWeeklyChartListLoaded ( response : XML ) : void
		{
			weeklyChartList = [];
			var children : XMLList = response.weeklychartlist.chart;
			for each (var child : XML in children) {
				weeklyChartList.push(mf.createChart(child));
			}
			dispatchEvent(new Event(GET_WEEKLY_CHART_LIST));
		}
		
		/**
		 * Get the track chart for this user, for a given date range.
		 * If no date range is supplied, it will return the most recent track chart for this user. 
		 * 
		 * Ref: http://www.last.fm/api/show?service=282
		 */ 
		 
		public function getWeeklyTrackChart( chart : FMChart = null ):void
		{
			assert(name != null, "To get the user weekly track chart, you must supply the user name" );
			
			var variables : Object = {user: name};
			if(chart != null) {
				variables.from = chart.dateFromAsInt;
				variables.to = chart.dateToAsInt;
			}
			requestURL(GET_WEEKLY_TRACK_CHART, variables, onWeeklyTrackChartLoaded);
		}
		
		private function onWeeklyTrackChartLoaded ( response : XML ) : void
		{
			weeklyTrackChart = [];
			var children : XMLList = response.weeklytrackchart.track;
			for each (var child : XML in children) {
				weeklyTrackChart.push(mf.createTrack(child));
			}
			dispatchEvent(new Event(GET_WEEKLY_TRACK_CHART));
		}
	}
}