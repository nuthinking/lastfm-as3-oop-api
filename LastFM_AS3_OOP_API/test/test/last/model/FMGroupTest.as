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
{	import fm.last.enum.FMImageSizeType;
	import fm.last.model.FMAlbum;
	import fm.last.model.FMArtist;
	import fm.last.model.FMGroup;
	import fm.last.model.FMTrack;
	import fm.last.model.FMUser;
	import fm.last.model.vo.FMChart;

	import test.last.model.FMModelTest;

	import flash.events.Event;

	/**	 * @author christian	 */	public class FMGroupTest extends FMModelTest 
	{		public function FMGroupTest(methodName : String = null)
		{			super(methodName);		}
		
		public function testGetMembers () : void
		{
			var o : FMGroup = new FMGroup();
			try{
				o.getMembers();
				fail("Group shouldn't be able to get members if its name is not defined");
			}catch(e:Error){}
			try{
				o.getMembers(0);
				fail("Group shouldn't be able to get members if its max amount is 0");
			}catch(e:Error){
			}
			o.name = "mnml";
			o.addEventListener(FMGroup.GET_MEMBERS, onMembersLoaded);
			o.getMembers(75);
		}
		
		private function onMembersLoaded(event : Event) : void
		{
			var o : FMGroup = FMGroup(event.currentTarget);
			assertEquals("FMGroup.getMembers should return the correct amount of user", 75, o.members.length);
			var firstUser : FMUser = o.members[0];
			assertEquals("FMGroup.getMembers should set the first user name", "Indigo_Ice", firstUser.name);
			assertEquals("FMGroup.getMembers should set the first user realname", "The Disco And The What Not ♫", firstUser.realname);
			assertEquals("FMGroup.getMembers should set the first user image small", "http://userserve-ak.last.fm/serve/34/27926627.jpg", firstUser.getImageUrlBySize(FMImageSizeType.SMALL));
			var lastUser : FMUser = o.members.pop();
			assertEquals("FMGroup.getMembers should set the last user name", "rjk66", lastUser.name);
			assertEquals("FMGroup.getMembers should set the last user realname", "", lastUser.realname);
			assertEquals("FMGroup.getMembers should set the last user image small", "http://userserve-ak.last.fm/serve/34/1745258.jpg", lastUser.getImageUrlBySize(FMImageSizeType.SMALL));
		}
		
		public function testGetWeeklyChartList () : void
		{
			var o : FMGroup = new FMGroup();
			try{
				o.getWeeklyChartList();
				fail("Group shouldn't be able to get weekly chart list if its name is not defined");
			}catch(e:Error){}
			o.name = "mnml";
			o.addEventListener(FMGroup.GET_WEEKLY_CHART_LIST, onWeeklyChartListLoaded);
			o.getWeeklyChartList();
		}
		private function onWeeklyChartListLoaded ( event : Event ) : void
		{
			var o : FMGroup = FMGroup(event.currentTarget);
			assertEquals("FMGroup.getWeeklyChartList should return the correct amount of charts", 136, o.weeklyChartList.length);
			var firstChart : FMChart = o.weeklyChartList[0];
			assertEquals("FMGroup.getWeeklyChartList should set the first chart from int", 1159099200, firstChart.dateFromAsInt);
			assertEquals("FMGroup.getWeeklyChartList should set the first chart to int", 1159704000, firstChart.dateToAsInt);
			/*var fromDate : Date = new Date(2006, 8, 24, 12, 0, 0, 0); // TODO: sort the GMT issue
			assertEquals("FMGroup.getWeeklyChartList should set the first chart from date", fromDate.toString(), firstChart.dateFrom.toString());*/
			var lastChart : FMChart = o.weeklyChartList.pop();
			assertEquals("FMGroup.getWeeklyChartList should set the last chart from int", 1240747200, lastChart.dateFromAsInt);
			assertEquals("FMGroup.getWeeklyChartList should set the last chart to int", 1241352000, lastChart.dateToAsInt);
		}
		
		public function testGetWeeklyAlbumChart () : void
		{
			var o : FMGroup = new FMGroup();
			try{
				o.getWeeklyAlbumChart();
				fail("Group shouldn't be able to get weekly album chart if its name is not defined");
			}catch(e:Error){}
			o.name = "mnml";
			o.addEventListener(FMGroup.GET_WEEKLY_ALBUM_CHART, onWeeklyAlbumChartLoaded);
			o.getWeeklyAlbumChart();
		}
		private function onWeeklyAlbumChartLoaded ( event : Event ) : void
		{
			var o : FMGroup = FMGroup(event.currentTarget);
			assertEquals("FMGroup.getWeeklyAlbumChart should return the correct amount of albums", 250 /*max rank is 195*/, o.weeklyAlbumChart.length);
			var firstAlbum : FMAlbum = o.weeklyAlbumChart[0];
			assertEquals("FMGroup.getWeeklyAlbumChart should set the first album name", "Orchestra of Bubbles", firstAlbum.name);
			assertEquals("FMGroup.getWeeklyAlbumChart should set the first album playCount", 35, firstAlbum.playCount);
			assertEquals("FMGroup.getWeeklyAlbumChart should set the first album artist name", "Ellen Allien & Apparat", firstAlbum.artist.name);
			assertEquals("FMGroup.getWeeklyAlbumChart should set the first album artist mbid", "64b86e99-b6ec-4fb1-a5cd-f95482d3b57a", firstAlbum.artist.mbid);
			var lastAlbum : FMAlbum = o.weeklyAlbumChart.pop();
			assertEquals("FMGroup.getWeeklyAlbumChart should set the last album name", "Attention", lastAlbum.name);
			assertEquals("FMGroup.getWeeklyAlbumChart should set the last album playCount", 8, lastAlbum.playCount);
			assertEquals("FMGroup.getWeeklyAlbumChart should set the last album artist name", "Gus Gus", lastAlbum.artist.name);
			assertEquals("FMGroup.getWeeklyAlbumChart should set the last album artist mbid", "3c2dad7d-7f2f-4c34-83cd-5f50c53400af", lastAlbum.artist.mbid);
		}
		
		public function testGetWeeklyArtistChart () : void
		{
			var o : FMGroup = new FMGroup();
			try{
				o.getWeeklyArtistChart();
				fail("Group shouldn't be able to get weekly artist chart if its name is not defined");
			}catch(e:Error){}
			o.name = "mnml";
			o.addEventListener(FMGroup.GET_WEEKLY_ARTIST_CHART, onWeeklyArtistChartLoaded);
			o.getWeeklyArtistChart();
		}
		private function onWeeklyArtistChartLoaded ( event : Event ) : void
		{
			var o : FMGroup = FMGroup(event.currentTarget);
			assertEquals("FMGroup.getWeeklyArtistChart should return the correct amount of artists", 100, o.weeklyArtistChart.length);
			var firstArtist : FMArtist = o.weeklyArtistChart[0];
			assertEquals("FMGroup.getWeeklyArtistChart should set the first artist name", "Depeche Mode", firstArtist.name);
			assertEquals("FMGroup.getWeeklyArtistChart should set the first artist mbid", "8538e728-ca0b-4321-b7e5-cff6565dd4c0", firstArtist.mbid);
			assertEquals("FMGroup.getWeeklyArtistChart should set the first artist playCount", 84, firstArtist.playCount);
			assertEquals("FMGroup.getWeeklyArtistChart should set the first artist url", "http://www.last.fm/music/Depeche+Mode", firstArtist.url);
			var lastArtist : FMArtist = o.weeklyArtistChart.pop();
			assertEquals("FMGroup.getWeeklyArtistChart should set the last album name", "Flying Lotus", lastArtist.name);
			assertEquals("FMGroup.getWeeklyArtistChart should set the last album mbid", "fc7376fe-1a6f-4414-b4a7-83f50ed59c92", lastArtist.mbid);
			assertEquals("FMGroup.getWeeklyArtistChart should set the last album playCount", 23, lastArtist.playCount);
			assertEquals("FMGroup.getWeeklyArtistChart should set the last album url", "http://www.last.fm/music/Flying+Lotus", lastArtist.url);
		}
		
		public function testGetWeeklyTrackChart () : void
		{
			var o : FMGroup = new FMGroup();
			try{
				o.getWeeklyTrackChart();
				fail("Group shouldn't be able to get weekly track chart if its name is not defined");
			}catch(e:Error){}
			o.name = "mnml";
			o.addEventListener(FMGroup.GET_WEEKLY_TRACK_CHART, onWeeklyTrackChartLoaded);
			o.getWeeklyTrackChart();
		}
		private function onWeeklyTrackChartLoaded ( event : Event ) : void
		{
			var o : FMGroup = FMGroup(event.currentTarget);
			assertEquals("FMGroup.getWeeklyTrackChart should return the correct amount of artists", 100, o.weeklyTrackChart.length);
			var firstTrack : FMTrack = o.weeklyTrackChart[0];
			assertEquals("FMGroup.getWeeklyTrackChart should set the first track name", "A New Error", firstTrack.name);
			assertEquals("FMGroup.getWeeklyTrackChart should set the first track playCount", 27, firstTrack.playCount);
			assertEquals("FMGroup.getWeeklyTrackChart should set the first track image small", null, firstTrack.getImageUrlBySize(FMImageSizeType.SMALL));
			assertEquals("FMGroup.getWeeklyTrackChart should set the first track artist name", "Moderat", firstTrack.artist.name);
			assertEquals("FMGroup.getWeeklyTrackChart should set the first track artist mbid", "7754905b-8bf7-48e2-935a-03d566fec464", firstTrack.artist.mbid);
			var lastTrack : FMTrack = o.weeklyTrackChart.pop();
			assertEquals("FMGroup.getWeeklyTrackChart should set the last track name", "Holdon", lastTrack.name);
			assertEquals("FMGroup.getWeeklyTrackChart should set the last track playCount", 10, lastTrack.playCount);
			assertEquals("FMGroup.getWeeklyTrackChart should set the last track image small", null, lastTrack.getImageUrlBySize(FMImageSizeType.SMALL));
			assertEquals("FMGroup.getWeeklyTrackChart should set the last track artist name", "Apparat", lastTrack.artist.name);
			assertEquals("FMGroup.getWeeklyTrackChart should set the last track artist mbid", "dc3dbfc1-f1f1-49c6-9d7c-425fabf3ae12", lastTrack.artist.mbid);
		}
	}}