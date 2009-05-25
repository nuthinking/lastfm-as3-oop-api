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
	import flash.events.Event;

	/**
	 * Incapsulates all the methods of the Last.fm event web service
     */
	public class FMEvent extends FMModelBase
	{
		/**
		 * Defines the related web service method and has been used also as event type id when to dispatch outside the status complete of the method
		 */
		public static const GET_ATTENDEES:String = "event.getAttendees";
		
		/**
		 * Defines the related web service method and has been used also as event type id when to dispatch outside the status complete of the method
		 */
		public static const GET_INFO:String = "event.getInfo";
		
		/**
		 * Defines the related web service method and has been used also as event type id when to dispatch outside the status complete of the method
		 */
		public static const GET_SHOUTS : String = "event.getshouts";
		
		/**
		 * The event id in LastFM
		 */
		public var id : Number;
		
		/**
		 * The name
		 */
		public var name : String;
		
		/**
		 * The list of artist which performed or will performe on the event
		 */
		public var artists : /*FMArtist*/ Array;
		
		/**
		 * The main artist for the event, it should appear in the artists list too
		 */
		public var headliner : FMArtist;
		
		/**
		 * The venue the event has happened or will happen
		 */
		public var venue : FMVenue;
		
		/**
		 * The start date as returned by the web service
		 */
		public var startDateRaw : String;
		
		/**
		 * The start time as returned by the web service
		 */
		public var startTimeRaw : String;
		
		/**
		 * The start date as object (not implemented yet)
		 */
		public var startDate : Date;
		
		/**
		 * The end date as returned by the web service
		 */
		public var endDateRaw : String;
		
		/**
		 * The description of the event
		 */
		public var description : String;
		
		/**
		 * The amount of users in LastFM which has attended or will attend the event
		 */
		public var attendance : uint;
		
		/**
		 * The amount of reviews on LastFM
		 */
		public var reviews : uint;
		
		/**
		 * The tag related to the event
		 */
		public var tag : String;
		
		/**
		 * The url of the event on LastFM
		 */
		public var url : String;
		
		/**
		 * The list of attendees to the event
		 */
		public var attendees : Array;
		
		/**
		 * The list of shouts related to the event
		 */
		public var shouts : Array;
		
		/**
		 * Constructor
		 * 
		 * @param the id on LastFM
		 */
		public function FMEvent(id : Number = NaN)
		{
			this.id = id;	
			propertiesToTrace = ["id","title","venue"];
		}
		
		/**
		 * Populate the model from the different XML formats returned by the web service
		 * 
		 * @param the XML node representing the model
		 */
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
		
		/**
		 * Creates an instance of the model starting from the XML node returned by the web service
		 * 
		 * @param the xml node representing the model
		 * @return the new populated instance
		 */
		public static function createFromXML(xml : XML) : FMEvent
		{
			var e : FMEvent = new FMEvent();
			e.populateFromXML(xml);
			return e;
		}
		
		/**
		 * Load the list of attendees for this event. 
		 * 
		 * Ref: http://www.last.fm/api/show/?service=391
		 * 
		 * On succesfully complete, it will dispatch the event type GET_ATTENDEES
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
		 * Load the metadata for this event.
		 * Includes attendance and lineup information. 
		 * 
		 * Ref: http://www.last.fm/api/show?service=292
		 * 
		 * On succesfully complete, it will dispatch the event type GET_INFO
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
		 * Load shouts for this event.
		 * 
		 * Ref: http://www.last.fm/api/show/?service=399
		 * 
		 * On succesfully complete, it will dispatch the event type GET_SHOUTS
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