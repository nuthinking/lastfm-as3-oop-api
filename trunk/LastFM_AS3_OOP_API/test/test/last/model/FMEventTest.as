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
	import fm.last.model.FMArtist;
	import fm.last.model.FMEvent;
	import fm.last.model.FMUser;
	import fm.last.model.vo.FMShout;

	import flash.events.Event;

	/**	 * @author christian	 */	public class FMEventTest extends FMModelTest 
	{
		[Embed("../../../data/constructors/event.xml", mimeType="application/octet-stream")]
      	private static const CONSTRUCTOR_XML_CLASS:Class;
      	
		public function FMEventTest(methodName : String = null)
		{			super(methodName);		}
		
		public function testCreateFromXML () : void
		{
			var e : FMEvent = FMEvent.createFromXML(getEmbeddedXML(CONSTRUCTOR_XML_CLASS));
			assertEquals("the xml should define correctly the event id", "941786", e.id);
			assertEquals("the xml should define correctly the event name", "Yeah Yeah Yeahs", e.name);
			//trace(e.artists.indexOf("No No Nos")); // not sure why this returns -1
			assertEquals("the xml should define correctly the artists number", 2, e.artists.length);
			assertEquals("the xml should define correctly the artists", FMArtist(e.artists[0]).name, "Yeah Yeah Yeahs");
			assertEquals("the xml should define correctly the artists", FMArtist(e.artists[1]).name, "No No Nos");
			assertEquals("the xml should define correctly the event headliner", e.headliner.name, "Yeah Yeah Yeahs");
			assertEquals("the xml should define correctly the event venue", e.venue.name, "Magazzini Generali");
			assertEquals("the xml should define correctly the event startDateRaw", "Mon, 04 May 2009", e.startDateRaw);
			assertEquals("the xml should define correctly the event startTimeRaw", "20:30", e.startTimeRaw);
			// TODO: public var startDate : Date;
			assertContained("the xml should define correctly the event startTimeRaw", "DA GIOVEDI’ 26 FEBBRAIO", e.description);
			assertEquals("the xml should define correctly the event image small", "http://userserve-ak.last.fm/serve/34/24916215.jpg", e.getImageUrlBySize(FMImageSizeType.SMALL));
			assertEquals("the xml should define correctly the event image medium", "http://userserve-ak.last.fm/serve/64/24916215.jpg", e.getImageUrlBySize(FMImageSizeType.MEDIUM));
			assertEquals("the xml should define correctly the event image large", "http://userserve-ak.last.fm/serve/126/24916215.jpg", e.getImageUrlBySize(FMImageSizeType.LARGE));
			assertEquals("the xml should define correctly the event attendance", 172, e.attendance);
			assertEquals("the xml should define correctly the event reviews", 0, e.reviews);
			assertEquals("the xml should define correctly the event tag", "lastfm:event=941786", e.tag);
			assertEquals("the xml should define correctly the event url", "http://www.last.fm/event/941786", e.url);
		}
		
		public function testGetAttendees () : void
		{
			var o : FMEvent = new FMEvent();
			try{
				o.getAttendees();
				fail("FMEvent shouldn't be able to get attendees if id is not defined");
			}catch(e : Error){};
			o.id = 444;
			o.addEventListener(FMEvent.GET_ATTENDEES, onAttendeesLoaded);
			o.getAttendees();
		}
		
		private function onAttendeesLoaded(event : Event) : void
		{
			var o : FMEvent = FMEvent(event.currentTarget);
			assertEquals("FMEvent.getAttendees should return the correct amount of users", Math.floor(291 / 7), o.attendees.length);
			var firstUser : FMUser = o.attendees[0];
			assertEquals("FMEvent.getAttendees should return the first attendee user name", "ikea", firstUser.name);
			assertEquals("FMEvent.getAttendees should return the first attendee real realname", "Jane", firstUser.realname);
			assertEquals("FMEvent.getAttendees should return the first attendee real image small", "http://userserve-ak.last.fm/serve/34/17805805.jpg", firstUser.getImageUrlBySize(FMImageSizeType.SMALL));
			var lastUser : FMUser = o.attendees.pop();
			assertEquals("FMEvent.getAttendees should return the last attendee user name", "diarmuidmallon", lastUser.name);
			assertEquals("FMEvent.getAttendees should return the last attendee real realname", "", lastUser.realname);
			assertEquals("FMEvent.getAttendees should return the last attendee real image small", "http://userserve-ak.last.fm/serve/34/23584953.jpg", lastUser.getImageUrlBySize(FMImageSizeType.SMALL));
		}
		
		public function testGetInfo () : void
		{
			var o : FMEvent = new FMEvent();
			try{
				o.getInfo();
				fail("FMEvent shouldn't be able to get info if id is not defined");
			}catch(e : Error){};
			o.id = 444;
			o.addEventListener(FMEvent.GET_INFO, onInfoLoaded);
			o.getInfo();
		}
		
		private function onInfoLoaded(event : Event) : void
		{
			var o : FMEvent = FMEvent(event.currentTarget);
			assertEquals("FMEvent.getInfo should return the event name", "Philip Glass", o.name);
			assertEquals("FMEvent.getInfo should return the event artists", 2, o.artists.length);
			assertEquals("FMEvent.getInfo should return the event first artist name", "Philip Glass", FMArtist(o.artists[0]).name);
			assertEquals("FMEvent.getInfo should return the event second artist name", "Orchestra and Chorus of Erfurt Theatre", FMArtist(o.artists[1]).name);
			assertEquals("FMEvent.getInfo should return the event headliner name", "Philip Glass", o.headliner.name);
			assertEquals("FMEvent.getInfo should return the event headliner as object reference to one of the artists", FMArtist(o.artists[0]), o.headliner);
			assertEquals("FMEvent.getInfo should return the event vanue name", "Barbican Centre", o.venue.name);
			assertEquals("FMEvent.getInfo should return the event attendance", 46, o.attendance);
			assertEquals("FMEvent.getInfo should return the event reviews", 0, o.reviews);
		}
		
		public function testGetShouts () : void
		{
			var o : FMEvent = new FMEvent();
			try{
				o.getShouts();
				fail("FMEvent shouldn't be able to get shouts if id is not defined");
			}catch(e : Error){};
			o.id = 444;
			o.addEventListener(FMEvent.GET_SHOUTS, onShoutsLoaded);
			o.getShouts();
		}
		
		private function onShoutsLoaded ( event : Event ) : void
		{
			var o : FMEvent = FMEvent(event.currentTarget);
			assertEquals("FMEvent.getShouts should return some shouts", 669, o.shouts.length); // the xml provided seems to be bugged
			var firstShout : FMShout = o.shouts[0];
			assertEquals("FMEvent.getShouts should return the first shout body", "∞", firstShout.body);
			assertEquals("FMEvent.getShouts should return the first shout author", "Generic_101", firstShout.author);
			assertEquals("FMEvent.getShouts should return the first shout dateRaw", "Wed, 6 May 2009 10:41:28", firstShout.dateRaw);
			var lastShout : FMShout = o.shouts.pop();
			assertEquals("FMEvent.getShouts should return the last shout body", "can't get enough of this", lastShout.body);
			assertEquals("FMEvent.getShouts should return the last shout author", "qadnoun3", lastShout.author);
			assertEquals("FMEvent.getShouts should return the last shout dateRaw", "Wed, 3 May 2006 11:28:22", lastShout.dateRaw);
		}
	}}