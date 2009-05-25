/** *  This file is part of LastMF AS3 OOP API. *   *  http://code.google.com/p/lastfm-as3-oop-api/ * *  LastMF AS3 OOP API is free software: you can redistribute it and/or modify *  it under the terms of the GNU General Public License as published by *  the Free Software Foundation, either version 3 of the License, or *  (at your option) any later version. * *  LastMF AS3 OOP API is distributed in the hope that it will be useful, *  but WITHOUT ANY WARRANTY; without even the implied warranty of *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the *  GNU General Public License for more details. * *  You should have received a copy of the GNU General Public License *  along with LastMF AS3 OOP API.  If not, see <http://www.gnu.org/licenses/>. *   *  @author Christian Giordano for Tonic.co.uk * */package fm.last.model {	import fm.last.utils.PageResults;	import flash.events.Event;	import fm.last.model.FMModelBase;	import fm.last.model.vo.FMLocation;	/**	 * Incapsulates all the methods of the Last.fm venue web service     */	public class FMVenue extends FMModelBase 	{		public static const GET_EVENTS : String = "venue.getEvents";		public static const GET_PAST_EVENTS : String = "venue.getPastEvents";				public var name : String;		public var id : Number;		public var location : FMLocation;		public var url : String;		public var events : Array;				private var pastEventsResults : PageResults;				public function get pastEvents () : Array		{			if(pastEventsResults == null)				return null;			return pastEventsResults.items;		}		public function FMVenue(id : Number = NaN) 
		{			if(!isNaN(id))				this.id = id;			propertiesToTrace = ["name","location"];		}				/**		 * Creates an instance of the model starting from the XML node returned by the web service		 * 		 * @param the xml node representing the model		 * @return the new populated instance		 */
		public static function createFromXML (xml : XML) : FMVenue		{			var v : FMVenue = new FMVenue();			v.populateFromXML(xml);			return v;		}				/**		 * Populate the model from the different XML formats returned by the web service		 * 		 * @param the XML node representing the model		 */		protected function populateFromXML ( xml : XML ) : void		{			if(xml.id[0] != null)				id = parseInt(xml.id.text());			name = xml.name.text();			location = mf.createLocation(xml.location[0]);			url = xml.url.text();		}				/**		 * Get a list of upcoming events at this venue. 		 * 		 * Ref: http://www.last.fm/api/show?service=394 		 */				public function getEvents () : void		{			assert(!isNaN(id), "to get venue events, venue should have the id set");						requestURL(GET_EVENTS, {venue: id}, onEventsLoaded);		}				private function onEventsLoaded ( response : XML ) : void		{			events = [];			var children : XMLList = response.events.event;			for each(var child : XML in children){				events.push(mf.createEvent(child));			}			dispatchEvent(new Event(FMVenue.GET_EVENTS));		}		/**		 * Get a list of all the events held at this venue in the past. 		 * 		 * Ref: http://www.last.fm/api/show?service=395		 */				public function getPastEvents (limit : int = 50) : void		{			assert(!isNaN(id), "to get venue past events, venue should have the id set");			assert(limit > -1, "to get venue past events, the limit asked should be higher than -1, was: " + limit);						pastEventsResults = new PageResults(limit);			loadNextPastEvents();		}		private function loadNextPastEvents () : void		{			var variables : Object = {				venue: id,				page: pastEventsResults.currentPage + 1			};			requestURL(GET_PAST_EVENTS, variables, onPastEventsLoaded);		}				private function onPastEventsLoaded ( response : XML ) : void		{			var items : Array = [];			var children : XMLList = response.events.event;			for each(var child : XML in children){				items.push(mf.createEvent(child));			}			pastEventsResults.addPage(items);			var page : uint = parseInt(response.events.@page);			var totalPages : uint = parseInt(response.events.@totalPages);			if(!pastEventsResults.isFilled && page < totalPages){				loadNextPastEvents();			}else{				dispatchEvent(new Event(GET_PAST_EVENTS));			}		}	}}