/** *  This file is part of LastMF AS3 OOP API. *   *  http://code.google.com/p/lastfm-as3-oop-api/ * *  LastMF AS3 OOP API is free software: you can redistribute it and/or modify *  it under the terms of the GNU General Public License as published by *  the Free Software Foundation, either version 3 of the License, or *  (at your option) any later version. * *  LastMF AS3 OOP API is distributed in the hope that it will be useful, *  but WITHOUT ANY WARRANTY; without even the implied warranty of *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the *  GNU General Public License for more details. * *  You should have received a copy of the GNU General Public License *  along with LastMF AS3 OOP API.  If not, see <http://www.gnu.org/licenses/>. *   *  @author Christian Giordano for Tonic.co.uk * */package test.last.model {	import fm.last.enum.FMImageSizeType;	import fm.last.model.FMEvent;	import fm.last.model.FMVenue;	import flash.events.Event;	/**	 * @author christian	 */	public class FMVenueTest extends FMModelTest 	{		[Embed("../../../data/constructors/venue.xml", mimeType="application/octet-stream")]      	private static const CONSTRUCTOR_XML_CLASS:Class;      			public function FMVenueTest(methodName : String = null)		{			super(methodName);		}				public function testCreateFromXML () : void		{			var v : FMVenue = FMVenue.createFromXML(getEmbeddedXML(CONSTRUCTOR_XML_CLASS));			assertEquals("createFromXML should set venue name", "Magazzini Generali", v.name);			assertEquals("createFromXML should set venue location", "Milano", v.location.city);			assertEquals("createFromXML should set venue url", "http://www.last.fm/venue/8780562", v.url);		}				public function testGetEvents () : void		{			var o : FMVenue = new FMVenue();			try{				o.getEvents();				fail("FMVenue.getEvents shouldn't be able to get events if the its id is not set");			}catch(e : Error){			}			o.id = 2;			o.addEventListener(FMVenue.GET_EVENTS, onEventsLoaded);			o.getEvents();		}				private function onEventsLoaded(event : Event) : void		{			var o : FMVenue = FMVenue(event.currentTarget);			assertTrue("FMVenue.getEvents should return some events", o.events != null && o.events.length > 0);			var firstEvent : FMEvent = o.events[0];			assertEquals("FMVenue.getEvents should return the first event name", "Damnably Presents David Grubbs on Paino and Guitar", firstEvent.name);			assertEquals("FMVenue.getEvents should return the first event headliner name", "David Grubbs", firstEvent.headliner.name);			assertEquals("FMVenue.getEvents should return the first event startDateRaw", "Fri, 22 May 2009 20:00:00", firstEvent.startDateRaw);			assertContained("FMVenue.getEvents should return the first event description", "Tickets £8.00 Advance from", firstEvent.description);			assertEquals("FMVenue.getEvents should return the first event image small", "http://userserve-ak.last.fm/serve/34/13403.jpg", firstEvent.getImageUrlBySize(FMImageSizeType.SMALL));			var lastEvent : FMEvent = o.events.pop();			assertEquals("FMVenue.getEvents should return the last event name", "ccc", lastEvent.name);			assertEquals("FMVenue.getEvents should return the last event headliner name", "ccc", lastEvent.headliner.name);			assertEquals("FMVenue.getEvents should return the last event startDateRaw", "Tue, 06 Apr 2010 16:30:00", lastEvent.startDateRaw);			assertEquals("FMVenue.getEvents should return the last event description", "", lastEvent.description);			assertEquals("FMVenue.getEvents should return the last event image small", "http://userserve-ak.last.fm/serve/34/14247.jpg", lastEvent.getImageUrlBySize(FMImageSizeType.SMALL));		}				public function testGetPastEvents() : void		{			var o : FMVenue = new FMVenue();			try{				o.getPastEvents();				fail("FMVenue.getPastEvents shouldn't be able to get events if the its id is not set");			}catch(e : Error){			}			o.id = 2;			o.addEventListener(FMVenue.GET_PAST_EVENTS, onPastEventsLoaded);			o.getPastEvents();		}				private function onPastEventsLoaded ( event : Event ) : void		{			var o : FMVenue = FMVenue(event.currentTarget);			assertTrue("FMVenue.getPastEvents should return some events", o.pastEvents != null && o.pastEvents.length > 0);			var firstEvent : FMEvent = o.pastEvents[0];			assertEquals("FMVenue.getPastEvents should return the first event name", "Adjacent Cafe # 1", firstEvent.name);			assertEquals("FMVenue.getPastEvents should return the first event headliner name", "Benedict Drew", firstEvent.headliner.name);			assertEquals("FMVenue.getPastEvents should return the first event startDateRaw", "Sun, 17 May 2009 20:00:00", firstEvent.startDateRaw);			assertContained("FMVenue.getPastEvents should return the first event description", "The first event features the brand new trio of Benedict Drew", firstEvent.description);			assertEquals("FMVenue.getPastEvents should return the first event image small", "http://userserve-ak.last.fm/serve/34/12335441.jpg", firstEvent.getImageUrlBySize(FMImageSizeType.SMALL));			var lastEvent : FMEvent = o.pastEvents.pop();			assertEquals("FMVenue.getPastEvents should return the last event name", "Attack!!!! magazine live", lastEvent.name);			assertEquals("FMVenue.getPastEvents should return the last event headliner name", "Cottonmouth Rocks", lastEvent.headliner.name);			assertEquals("FMVenue.getPastEvents should return the last event startDateRaw", "Wed, 28 Jan 2009 19:30:00", lastEvent.startDateRaw);			assertContained("FMVenue.getPastEvents should return the last event description", "Wellcome's Magic Ink", lastEvent.description);			assertEquals("FMVenue.getPastEvents should return the last event image small", "http://userserve-ak.last.fm/serve/34/22840703.jpg", lastEvent.getImageUrlBySize(FMImageSizeType.SMALL));		}	}}