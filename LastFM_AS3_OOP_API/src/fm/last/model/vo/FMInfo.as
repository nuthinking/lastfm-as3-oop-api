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
		/**
		 * The date the information has been published as returned by the web service
		 */
		public var publishedDateRaw : String;
		
		/**
		 * Abstract of the content
		 */
		public var summary : String;
		
		/**
		 * The full length content, which can contain HTML
		 */
		public var content : String;
		
		/**
		 * Creates an instance of the model starting from the XML node returned by the web service
		 * 
		 * @param the xml node representing the model
		 * @return the new populated instance
		 */
		public static function createFromXML ( xml : XML) : FMInfo
		{
			var b : FMInfo = new FMInfo();
			b.populateFromXML(xml);
			return b;		}
		
		/**
		 * Populate the model from the different XML formats returned by the web service
		 * 
		 * @param the XML node representing the model
		 */
		protected function populateFromXML ( xml : XML ) : void
		{
			publishedDateRaw = xml.published.text();
			summary = xml.summary.text();
			content = xml.content.text();
		}
	}}