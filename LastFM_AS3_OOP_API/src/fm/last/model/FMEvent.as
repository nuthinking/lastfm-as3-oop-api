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
	import fm.last.model.vo.FMShout;

	import flash.events.Event;

	/**
	 * Incapsulates all the methods of the Last.fm event web service
     */
	public class FMEvent extends FMModelBase
	{
		public static const GET_ATTENDEES:String = "event.getAttendees";
		public static const GET_INFO:String = "event.getInfo";
		public static const GET_SHOUTS : String = "event.getshouts";
		
		public var id : Number;
		public var name : String;
		public var artists : /*FMArtist*/ Array;
		public var headliner : FMArtist;
		public var venue : FMVenue;
		public var startDateRaw : String;
		public var startTimeRaw : String;
		public var startDate : Date;
		public var endDateRaw : String;
		public var description : String;
		public var attendance : uint;
		public var reviews : uint;
		public var tag : String;
		public var url : String;
		public var attendees : Array;
		public var shouts : Array;

		public function FMEvent(id : Number = NaN)
		{
			this.id = id;	
			propertiesToTrace = ["id","title","venue"];
		}
		
		protected function populateFromXML ( xml : XML) : void
		{
			id = parseInt(xml.id.text());
			name = xml.title.text();
			// artists
			artists = [];
			var child : XML;
			for each(child in xml.artists.artist){
				artists.push(mf.createArtist(child));
			}
			var headlinerName : String = xml.artists.headliner.text();
			for each(var a : FMArtist in artists){
				if(a.name == headlinerName){
					headliner = a;
					break;
				}
			}
			venue = mf.createVenue(xml.venue[0]);
			startDateRaw = xml.startDate.text();
			if(xml.startTime[0] != null)
				startTimeRaw = xml.startTime.text();
			// startDate
			if(xml.endDate[0] != null)
				endDateRaw = xml.endDate.text();
			description = xml.description.text();
			addImages(xml.image);
			attendance = parseInt(xml.attendance.text());
			reviews = parseInt(xml.reviews.text());
			tag = xml.tag.text();
			url = xml.url.text();
		}
		
		public static function createFromXML(xml : XML) : FMEvent
		{
			var e : FMEvent = new FMEvent();
			e.populateFromXML(xml);
			return e;
		}
		
		/**
		 * Get a list of attendees for this event. 
		 * 
		 * Ref: http://www.last.fm/api/show/?service=391
		 */
		
		public function getAttendees () : void
		{
			assert(!isNaN(id), "To get the event attendees, the event should have an id");
			
			requestURL(GET_ATTENDEES, {event: id}, onAttendeesLoaded);
		}
		
		private function onAttendeesLoaded ( response : XML ) : void
		{
			attendees = [];
			var children : XMLList = response.attendees.user;
			for each(var child : XML in children){
				attendees.push(mf.createUser(child));
			}
			dispatchEvent(new Event(GET_ATTENDEES));
		}

		/**
		 * Get the metadata for this event.
		 * Includes attendance and lineup information. 
		 * 
		 * Ref: http://www.last.fm/api/show?service=292
		 */
		public function getInfo():void
		{
			assert(!isNaN(id), "To get the event info, the event should have an id");
			
			requestURL(GET_INFO, {event: id}, onEventInfoLoaded);
		}
		
		private function onEventInfoLoaded ( response : XML ) : void
		{
			var xml : XML = response.event[0];
			populateFromXML(xml);
			dispatchEvent(new Event(GET_INFO));
		}
		
		/**
		 * Get shouts for this event.
		 * 
		 * Ref: http://www.last.fm/api/show/?service=399
		 */
		
		public function getShouts () : void
		{
			assert(!isNaN(id), "To get the event shouts, the event should have an id");
			
			requestURL(GET_SHOUTS, {event: id}, onShoutsLoaded);
		}
		
		private function onShoutsLoaded ( response : XML ) : void
		{
			shouts = [];
			var children : XMLList = response.shouts.shout;
			for each(var child : XML in children){
				shouts.push(mf.createShout(child));
			}
			dispatchEvent(new Event(GET_SHOUTS));
		}
	}
}