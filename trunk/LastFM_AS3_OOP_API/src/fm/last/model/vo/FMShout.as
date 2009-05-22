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
package fm.last.model.vo 
{
	/**
	 * ValueObject returned by getShouts methods
	 * 	 * @author christian	 */	public class FMShout 
	{
	
		public var body : String;
		public var author : String;
		public var dateRaw : String;
		
		public static function createFromXML ( xml : XML ) : FMShout
		{
			var r : FMShout = new FMShout();
			r.body = xml.body.text();
			r.author = xml.author.text();
			r.dateRaw = xml.date.text();
			return r;
		}	}
}