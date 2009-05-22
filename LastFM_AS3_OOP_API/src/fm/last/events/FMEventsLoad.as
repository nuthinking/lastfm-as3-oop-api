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
	
	/**	 * @author christian	 */	public class FMEventsLoad extends Event 
	{
		public static const EVENTS_LOADED : String = "eventsLoaded";
		
		public var events : Array;
		public var total : uint;
		public var page : uint;
		public var totalPages : uint;
		public function FMEventsLoad(type : String, events : /*FMEvent*/ Array, total : uint = 0, page : uint = 0, totalPages : uint = 0)
		{			super(type);
			
			this.events = events;
			this.total = total;
			this.page = page;
			this.totalPages = totalPages;		}
	}}