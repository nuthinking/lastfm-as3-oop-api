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

	import fm.last.model.vo.FMChartDateRange;
	import flash.events.Event;
	import fm.last.utils.PageResults;
	/**
	 * Incapsulates all the methods of the Last.fm group web service
     */
	public class FMGroup extends FMModelBase
	{
		/**
		 * Defines the related web service method and has been used also as event type id when to dispatch outside the status complete of the method
		 */
		public static const GET_MEMBERS:String = "group.getMembers";
		
		/**
		 * Defines the related web service method and has been used also as event type id when to dispatch outside the status complete of the method
		 */
		public static const GET_WEEKLY_ALBUM_CHART:String = "group.getWeeklyAlbumChart";
		
		/**
		 * Defines the related web service method and has been used also as event type id when to dispatch outside the status complete of the method
		 */
		public static const GET_WEEKLY_ARTIST_CHART:String = "group.getWeeklyArtistChart";
		
		/**
		 * Defines the related web service method and has been used also as event type id when to dispatch outside the status complete of the method
		 */
		public static const GET_WEEKLY_CHART_LIST:String = "group.getWeeklyChartList";
		
		/**
		 * Defines the related web service method and has been used also as event type id when to dispatch outside the status complete of the method
		 */
		public static const GET_WEEKLY_TRACK_CHART:String = "group.getWeeklyTrackChart";
		
		/**
		 * The group name
		 */
		public var name : String;
		
		private var membersResults : PageResults;
		
		/**
		 * The list of albums in the chart loaded from a given date range
		 */
		public var weeklyAlbumChart : Array;
		
		/**
		 * The list of date range available to load charts
		 */
		public var weeklyChartDateRanges : Array;
		
		/**
		 * The list of artists in the chart loaded from a given date range
		 */
		public var weeklyArtistChart : Array;
		
		/**
		 * The list of tracks in the chart loaded from a given date range
		 */
		public var weeklyTrackChart : Array;
	
		/**
		 * The loaded members of this group
		 */
		public function get members () : Array
		{
			if(membersResults == null)
				return null;
			return membersResults.items;
		}
		
		/**
		 * Constructor
		 * 
		 * @param the group name
		 */
		public function FMGroup(name : String = null) {
			this.name = name;
		}
		
		/**
		 * Load a list of members for this group. 
		 * 
		 * Ref: http://www.last.fm/api/show?service=379
		 * 
		 * On succesfully complete, it will dispatch the event type GET_MEMBERS
		 * 
		 * @param the max amount of members to load
		 */
		
		public function getMembers (limit : int = 50) : void
		{
			assert(name != null, "To get the group members, you must supply the group name" );
			assert(limit > 0, "Group should request more than 0 members");
			
			membersResults = new PageResults(limit);
			loadNextMembers();
		}
		
		private function loadNextMembers() : void
		{
			var variables : Object = {
				group: name,
				page: membersResults.currentPage + 1
			};
			requestURL(GET_MEMBERS, variables, onMembersLoaded);
		}
		
		private function onMembersLoaded ( response : XML ) : void
		{
			var items : Array = [];
			var children : XMLList = response.members.user;
			for each(var child : XML in children){
				items.push(mf.createUser(child));
			}
			membersResults.addPage(items);
			var page : uint = parseInt(response.members.@page);
			var totalPages : uint = parseInt(response.members.@totalPages);
			if(!membersResults.isFilled && page < totalPages){
				loadNextMembers();
			}else{
				dispatchEvent(new Event(GET_MEMBERS));
			}
		}
		
		/**
		 * Load a list of available charts for this group, expressed as FMChart can be sent to the chart services. 
		 * 
		 * Ref: http://www.last.fm/api/show?service=295
		 * 
		 * On succesfully complete, it will dispatch the event type GET_WEEKLY_CHART_LIST
		 */	
		public function getWeeklyChartList():void
		{
			assert(name != null, "To get the group weekly chart list, you must supply the group name" );
			
			requestURL(GET_WEEKLY_CHART_LIST, {group: name}, onWeeklyChartListLoaded);
		}
		
		private function onWeeklyChartListLoaded ( response : XML ) : void
		{
			weeklyChartDateRanges = [];
			var children : XMLList = response.weeklychartlist.chart;
			for each (var child : XML in children) {
				weeklyChartDateRanges.push(mf.createChartDateRange(child));
			}
			dispatchEvent(new Event(GET_WEEKLY_CHART_LIST));
		}
		
		/**
		 * Load an album chart for this group, for a given date range.
		 * If no date range is supplied, it will return the most recent album chart for this group. 
		 * 
		 * Ref: http://www.last.fm/api/show?service=293
		 * 
		 * On succesfully complete, it will dispatch the event type GET_WEEKLY_ALBUM_CHART
		 * 
		 * @param the date range for the chart
		 */
		public function getWeeklyAlbumChart(dateRange : FMChartDateRange = null) : void
		{
			assert(name != null, "To get the group weekly album chart, you must supply the group name" );
			
			var variables : Object = {group: name};
			if(dateRange != null){
				variables.from = dateRange.dateFromAsInt;
				variables.to = dateRange.dateToAsInt;
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
		 * Load an artist chart for this group, for a given date range.
		 * If no date range is supplied, it will return the most recent album chart for this group. 
		 * 
		 * Ref: 
		 * 
		 * On succesfully complete, it will dispatch the event type GET_WEEKLY_ARTIST_CHART
		 * 
		 * @param the date range for the chart
		 */
		public function getWeeklyArtistChart( dateRange : FMChartDateRange = null ) : void
		{
			assert(name != null, "To get the group weekly artist chart, you must supply the group name" );
			
			var variables : Object = {group: name};
			if(dateRange != null) {
				variables.from = dateRange.dateFromAsInt;
				variables.to = dateRange.dateToAsInt;
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
		 * Load a track chart for this group, for a given date range.
		 * If no date range is supplied, it will return the most recent album chart for this group. 
		 * 
		 * Ref:
		 * 
		 * On succesfully complete, it will dispatch the event type GET_WEEKLY_TRACK_CHART
		 * 
		 * @param the date range for the chart
		 */
		public function getWeeklyTrackChart( dateRange : FMChartDateRange = null ):void
		{
			assert(name != null, "To get the group weekly track chart, you must supply the group name" );
			
			var variables : Object = {group: name};
			if(dateRange != null) {
				variables.from = dateRange.dateFromAsInt;
				variables.to = dateRange.dateToAsInt;
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