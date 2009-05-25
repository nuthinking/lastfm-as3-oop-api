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
package fm.last.events 
{	import flash.events.Event;
	
	/**
	 * Event internally dispatched when the XML has been loaded from the web service
	 * 	 * @author christian	 */	public class FMLoadEvent extends Event 
	{
		/**
		 * Id for the load complete event
		 */
		public static const LOAD_COMPLETE : String = "loadComplete";
		
		/**
		 * The entire XML returned by the web service call
		 */
		public var response : XML;
		
		/**
		 * Constructor
		 * 
		 * @param the event type
		 * @param the entire XML returned by the web service call
		 */
		public function FMLoadEvent(type : String, response : XML)
		{			super(type);
			
			this.response = response;			}
	}}