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

	import fm.last.model.vo.FMChart;
	import flash.events.Event;
	import fm.last.utils.PageResults;
	/**
	 * Incapsulates all the methods of the Last.fm group web service
     */
	public class FMGroup extends FMModelBase
	{
		public static const GET_MEMBERS:String = "group.getMembers";
		public static const GET_WEEKLY_ALBUM_CHART:String = "group.getWeeklyAlbumChart";
		public static const GET_WEEKLY_ARTIST_CHART:String = "group.getWeeklyArtistChart";
		public static const GET_WEEKLY_CHART_LIST:String = "group.getWeeklyChartList";
		public static const GET_WEEKLY_TRACK_CHART:String = "group.getWeeklyTrackChart";
		
		public var name : String;
		
		private var membersResults : PageResults;
		public var weeklyAlbumChart : Array;
		public var weeklyChartList : Array;
		public var weeklyArtistChart : Array;
		public var weeklyTrackChart : Array;

		public function get members () : Array
		{
			if(membersResults == null)
				return null;
			return membersResults.items;
		}

		public function FMGroup(name : String = null) {
			this.name = name;
		}
		
		/**
		 * Get a list of members for this group. 
		 * 
		 * Ref: http://www.last.fm/api/show?service=379
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
				items.push(FMUser.createFromXML(child));
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
		 * Get a list of available charts for this group, expressed as FMChart can be sent to the chart services. 
		 * 
		 * Ref: http://www.last.fm/api/show?service=295
		 */	
		public function getWeeklyChartList():void
		{
			assert(name != null, "To get the group weekly chart list, you must supply the group name" );
			
			requestURL(GET_WEEKLY_CHART_LIST, {group: name}, onWeeklyChartListLoaded);
		}
		
		private function onWeeklyChartListLoaded ( response : XML ) : void
		{
			weeklyChartList = [];
			var children : XMLList = response.weeklychartlist.chart;
			for each (var child : XML in children) {
				weeklyChartList.push(FMChart.createFromXML(child));
			}
			dispatchEvent(new Event(GET_WEEKLY_CHART_LIST));
		}
		
		/**
		 * Get an album chart for this group, for a given date range.
		 * If no date range is supplied, it will return the most recent album chart for this group. 
		 * 
		 * Ref: http://www.last.fm/api/show?service=293
		 */
		public function getWeeklyAlbumChart(chart : FMChart = null) : void
		{
			assert(name != null, "To get the group weekly album chart, you must supply the group name" );
			
			var variables : Object = {group: name};
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
				weeklyAlbumChart.push(FMAlbum.createFromXML(child));
			}
			dispatchEvent(new Event(GET_WEEKLY_ALBUM_CHART));
		}
		
		/**
		 * Get an artist chart for this group, for a given date range.
		 * If no date range is supplied, it will return the most recent album chart for this group. 
		 */
		public function getWeeklyArtistChart( chart : FMChart = null ) : void
		{
			assert(name != null, "To get the group weekly artist chart, you must supply the group name" );
			
			var variables : Object = {group: name};
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
				weeklyArtistChart.push(FMArtist.createFromXML(child));
			}
			dispatchEvent(new Event(GET_WEEKLY_ARTIST_CHART));
		}
		
		/**
		 * Get a track chart for this group, for a given date range.
		 * If no date range is supplied, it will return the most recent album chart for this group. 
		 */
		public function getWeeklyTrackChart( chart : FMChart = null ):void
		{
			assert(name != null, "To get the group weekly track chart, you must supply the group name" );
			
			var variables : Object = {group: name};
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
				weeklyTrackChart.push(FMTrack.createFromXML(child));
			}
			dispatchEvent(new Event(GET_WEEKLY_TRACK_CHART));
		}
	}
}