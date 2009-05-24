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
	/**
	 * Incapsulates all the methods of the Last.fm tag web service
     */
	public class FMTag extends FMModelBase
	{
		public static const GET_SIMILAR:String = "tag.getSimilar";
		public static const GET_TOP_ALBUMS:String = "tag.getTopAlbums";
		public static const GET_TOP_ARTISTS:String = "tag.getTopArtists";
		public static const GET_TOP_TRACKS:String = "tag.getTopTracks";
		public static const GET_WEEKLY_CHART_LIST:String = "tag.getWeeklyChartList";
		public static const GET_WEEKLY_ARTIST_CHART:String = "tag.getWeeklyArtistChart";
		
		public var name : String;
		public var url : String;
		public var count : Number;
		public var similar : Array;
		public var streamable : Boolean;
		public var topAlbums : Array;
		public var topArtists : Array;
		public var topTracks : Array;
		public var chartList : Array;
		public var weeklyArtistChart : Array;

		public function FMTag(name : String = null) {
			this.name = name;
		}
		
		protected function populateFromXML(xml : XML) : void
		{
			name = xml.name.text();
			if(xml.count[0] != null)
				count = parseInt(xml.count.text());
			url = xml.url.text();
			if(xml.streamable[0] != null)
				streamable = xml.streamable.text() == "1";
		}
		
		public static function createFromXML ( xml : XML ) : FMTag
		{
			var t : FMTag = new FMTag();
			t.populateFromXML(xml);
			return t;
		}
		
		/**
		 * Search for tags similar to this one.
		 * Returns tags ranked by similarity, based on listening data. 
		 * 
		 * Ref: http://www.last.fm/api/show?service=311
		 */
		public function getSimilar():void
		{
			assert(name != null, "To get similar tags, you should specify the tag name");
			
			requestURL(GET_SIMILAR, {tag: name}, onSimilarLoaded);
		}
		
		private function onSimilarLoaded ( response : XML ) : void
		{
			similar = [];
			var children : XMLList = response.similartags.tag;
			for each(var child : XML in children) {
				similar.push(mf.createTag(child));
			}
			dispatchEvent(new Event(GET_SIMILAR));
		}
		
		/**
		 * Get the top albums tagged by this tag, ordered by tag count. 
		 * 
		 * Ref: http://www.last.fm/api/show?service=283
		 */
		public function getTopAlbums():void
		{
			assert(name != null, "To get top albums, you should specify the tag name");
			
			requestURL(GET_TOP_ALBUMS, {tag: name}, onTopAlbumsLoaded);
		}
		private function onTopAlbumsLoaded ( response : XML ) : void
		{
			topAlbums = [];
			var children : XMLList = response.topalbums.album;
			for each(var child : XML in children) {
				topAlbums.push(mf.createAlbum(child));
			}
			dispatchEvent(new Event(GET_TOP_ALBUMS));
		}
		
		/**
		 * Get the top artists tagged by this tag, ordered by tag count. 
		 * 
		 * Ref: http://www.last.fm/api/show?service=284
		 */
		public function getTopArtists():void
		{
			assert(name != null, "To get top artists, you should specify the tag name");
			
			requestURL(GET_TOP_ARTISTS, {tag: name}, onTopArtistsLoaded);
		}
		private function onTopArtistsLoaded ( response : XML ) : void
		{
			topArtists = [];
			var children : XMLList = response.topartists.artist;
			for each(var child : XML in children) {
				topArtists.push(mf.createArtist(child));
			}
			dispatchEvent(new Event(GET_TOP_ARTISTS));
		}
		
		/**
		 * Get the top tracks tagged by this tag, ordered by tag count.
		 * 
		 * Ref: http://www.last.fm/api/show?service=285
		 */
		public function getTopTracks():void
		{
			assert(name != null, "To get top tracks, you should specify the tag name");
			
			requestURL(GET_TOP_TRACKS, {tag: name}, onTopTracksLoaded);
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
		 * Get the list of available charts for this tag, expressed as FMChart which can be sent to the chart services. 
		 * If no date range is supplied, it will return the most recent artist chart for this tag.
		 * 
		 * Ref: http://www.last.fm/api/show?service=359
		 */	
		public function getWeeklyChartList():void
		{
			assert(name != null, "To get weekly chart list, you should specify the tag name");
			
			requestURL(GET_WEEKLY_CHART_LIST, {tag: name}, onWeeklyChartListLoaded);
		}
		private function onWeeklyChartListLoaded ( response : XML ) : void
		{
			chartList = [];
			var children : XMLList = response.weeklychartlist.chart;
			for each(var child : XML in children) {
				chartList.push(mf.createChart(child));
			}
			dispatchEvent(new Event(GET_WEEKLY_CHART_LIST));
		}
		
		
		/**
		 * Get an artist chart for this tag, for a given FMChart.
		 * If no date range is supplied, it will return the most recent artist chart for this tag. 
		 * 
		 * Ref: http://www.last.fm/api/show?service=358
		 */
		public function getWeeklyArtistChart( chart : FMChart = null, limit : int = 50 ) : void
		{
			assert(name != null, "To get the group weekly artist chart, you must supply the tag name" );
			assert(limit > 0, "you should request more than 0 artists");
			
			var variables : Object = {
				tag: name,
				limit: limit
			};
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
	}
}