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
	import fm.last.utils.TraceUtils;
	/**
	 * ValueObject used by FMImage
	 * 
	 * NOTE: might have sense to consider the replacement with FMUser
	 * 
	 * @see FMImage
	 * 	 * @author christian	 */	public class FMOwner 
	{
		/**
		 * Defines the owen type (ie. "user")
		 */
		public var type : String;
		
		/**
		 * The name of the owner
		 */
		public var name : String;
		
		/**
		 * The url on LastFM
		 */
		public var url : String;
		
		/**
		 * Creates an instance of the model starting from the XML node returned by the web service
		 * 
		 * @param the xml node representing the model
		 * @return the new populated instance
		 */
		public static function createFromXML (xml : XML) : FMOwner
		{
			var o : FMOwner = new FMOwner();
			o.populateFromXML(xml);
			return o;		}
		
		/**
		 * Populate the model from the different XML formats returned by the web service
		 * 
		 * @param the XML node representing the model
		 */
		protected function populateFromXML ( xml : XML ) : void
		{
			type = xml.@type;
			name = xml.name.text();
			url = xml.url.text();
		}
		
		public function toString () : String
		{
			return TraceUtils.generateObjectDescription(this, ["type","name","url"]);
		}
	}}