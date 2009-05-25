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
	import fm.last.utils.PageResults;

	import flash.events.Event;
	
	/**
	 * Incapsulates all the methods of the Last.fm geo web service
     */
	public class FMGeo extends FMModelBase
	{
		/**
		 * Defines the related web service method and has been used also as event type id when to dispatch outside the status complete of the method
		 */
		public static const GET_EVENTS:String = "geo.getEvents";
		
		/**
		 * Defines the related web service method and has been used also as event type id when to dispatch outside the status complete of the method
		 */
		public static const GET_TOP_ARTISTS:String = "geo.getTopArtists";
		
		/**
		 * Defines the related web service method and has been used also as event type id when to dispatch outside the status complete of the method
		 */
		public static const GET_TOP_TRACKS:String = "geo.getTopTracks";
		
		/**
		 * The geo location as String
		 */
		public var location : String;
		
		/**
		 * The latitude value
		 */
		public var latitude : Number;
		
		/**
		 * The longitude value
		 */
		public var longitude : Number;
		
		private var eventsMaxDistance : Number;
		private var eventsResults : PageResults;
		
		/**
		 * The most popular artists assigned to this location
		 */
		public var topArtists : /*FMArtist*/ Array;
		
		/**
		 * The most popular tracks assigned to this location
		 */
		public var topTracks : /*FMTrack*/ Array;
		
		/**
		 * the name of the country as defined by the ISO 3166-1 country names standard
		 */
		public var country : String;
		
		/**
		 * Creates an instance of the model starting from the XML node returned by the web service
		 * 
		 * @param the xml node representing the model
		 * @return the new populated instance
		 */
		public static function createFromXML (xml : XML) : FMGeo
		{
			var g : FMGeo = new FMGeo();
			g.populateFromXML(xml);
			return g;
		}
		
		/**
		 * Constructor
		 */
		public function FMGeo()
		{
			propertiesToTrace = ["country","location","latitude","longitude"];
		}
		
		/**
		 * Populate the model from the different XML formats returned by the web service
		 * 
		 * @param the XML node representing the model
		 */
		protected function populateFromXML ( xml : XML ) : void
		{
			var geo : Namespace = xml.namespace('geo');
			latitude = xml.geo::lat.text();
			longitude = xml.geo::long.text();
		}
		
		/**
		 * The loaded events nearby this location
		 */		public function get events () : Array
		{
			if(eventsResults == null)
				return null;
			return eventsResults.items;
		}
		
		/**
		 * Load events nearby this location.
		 * 
		 * Ref: http://www.last.fm/api/show?service=270
		 * 
		 * On succesfully complete, it will dispatch the event type GET_EVENTS
		 * 
		 * @param the max amount of events to load
		 * @param the max distance for an event to be loaded
		 */
		public function getEvents(limit : int = 10, distance:Number = 20):void
		{
			assert(location != null || (!isNaN(latitude) && !isNaN(longitude)),
				"To load event, FMGeo should have at least specified the location or the latitude and longitude, location:\"" + location + "\", latitude:" + latitude + " longitude:" + longitude);
			assert(limit > 0, "You should request more than 0 events");
			
			eventsMaxDistance = distance;
			eventsResults = new PageResults(limit);
			getNextEvents();
		}
		
		private function getNextEvents() : void
		{
			var variables : Object = {
				distance: eventsMaxDistance,
				page: eventsResults.currentPage + 1
			};
			if(location != null){
				variables.location = location;
			}else{
				if(country != null)
					variables.location = country;
			}
			if(!isNaN(latitude))
				variables.latitude = latitude;
			if(!isNaN(longitude))
				variables.longitude = longitude;
			requestURL(GET_EVENTS, variables, onEventsLoaded);
		}
		
		private function onEventsLoaded(response : XML) : void
		{
			var items : Array = [];
			var children : XMLList = response.events.event;
			for each(var child : XML in children){
				items.push(mf.createEvent(child));
			}
			eventsResults.addPage(items);
			//var total : uint = parseInt(response.events.@total);
			var page : uint = parseInt(response.events.@page);
			var totalpages : uint = parseInt(response.events.@totalpages);
			if(!eventsResults.isFilled && page < totalpages){
				getNextEvents();
			}else{
				dispatchEvent(new Event(GET_EVENTS));
			}
		}
		
		/**
		 * Load the most popular artists by country 
		 * 
		 * Ref: http://www.last.fm/api/show?service=297
		 * 
		 * On succesfully complete, it will dispatch the event type GET_TOP_ARTISTS
		 */
		
 		public function getTopArtists():void
		{
			assert(country != null, "The country needs to be specified in geo when loading top artists");
			
			var variables : Object = {
				country: country
			};
			requestURL(GET_TOP_ARTISTS, variables, onTopArtistsLoaded);
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
		 * Load the most popular tracks by country 
		 * 
		 * Ref: http://www.last.fm/api/show/?service=298
		 * 
		 * On succesfully complete, it will dispatch the event type GET_TOP_TRACKS
		 */
		
 		public function getTopTracks():void
		{
			assert(country != null, "To get the top tracks, geo should specify the country");

			requestURL(GET_TOP_TRACKS, {country: country}, onTopTracksLoaded);
		}

		private function onTopTracksLoaded (response : XML) : void
		{
			topTracks = [];
			var children : XMLList = response.toptracks.track;
			for each(var child : XML in children) {
				topTracks.push(mf.createTrack(child));
			}
			dispatchEvent(new Event(GET_TOP_TRACKS));
		}
	}
}