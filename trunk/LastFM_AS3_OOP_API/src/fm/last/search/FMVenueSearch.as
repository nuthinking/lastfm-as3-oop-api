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
package fm.last.search 
{
	import fm.last.search.FMSearchBase;

	/**
	 * Model which processed the search for venues
	 * 
	 * @author christian
	 */
	public class FMVenueSearch extends FMSearchBase 
	{
		public var countryName : String;
		
		public function FMVenueSearch(term : String = null, countryName : String = null)
		{
			super(term);
			
			this.countryName = countryName;
			itemName = "venue";
			methodName = "venue.search";
		}
		
		public function get venues () : Array
		{
			if(searchResults == null)
				return null;
			return searchResults.items;
		}
		
		override protected function createVariables () : Object
		{
			var variables : Object = {};
			if(countryName != null)
				variables.country = countryName;
			return variables;
		}
		
		override protected function generateItems ( responseXML : XML) : Array
		{
			var children : XMLList = responseXML.results.venuematches.venue;
			var res : Array = [];
			for each(var child : XML in children){
				res.push(mf.createVenue(child));
			}
			return res;
		}
	}
}
