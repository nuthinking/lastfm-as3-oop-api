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
	 * ValueObject used by different model as bio
	 * 	 * @author christian	 */	public class FMInfo 
	{
		public var publishedDateRaw : String;
		public var summary : String;
		public var content : String;
		
		public static function createFromXML ( xml : XML) : FMInfo
		{
			var b : FMInfo = new FMInfo();
			b.publishedDateRaw = xml.published.text();
			b.summary = xml.summary.text();
			b.content = xml.content.text();
			return b;		}
	}}