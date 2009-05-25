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
{	import fm.last.utils.TraceUtils;

	/**
	 * ValueObject used by FMImage to describe a related file
	 * 
	 * @see FMImage
	 * 	 * @author christian	 */	public class FMImageFile 
	{
		/**
		 * The image title
		 */
		public var name : String;
		
		/**
		 * The image width
		 */
		public var width : Number;
		
		/**
		 * The image height
		 */
		public var height : Number;
		
		/**
		 * The image asset url
		 */
		public var url : String;
		
		/**
		 * Creates an instance of the model starting from the XML node returned by the web service
		 * 
		 * @param the xml node representing the model
		 * @return the new populated instance
		 */
		public static function createFromXML ( xml : XML ) : FMImageFile
		{
			var r : FMImageFile = new FMImageFile();
			r.populateFromXML(xml);
			return r;		}
		
		/**
		 * Populate the model from the different XML formats returned by the web service
		 * 
		 * @param the XML node representing the model
		 */
		protected function populateFromXML ( xml : XML ) : void
		{
			name = xml.@name;
			width = parseFloat(xml.@width);
			height = parseFloat(xml.@height);
			url = xml.text();
		}
		
		public function toString () : String
		{
			return TraceUtils.generateObjectDescription(this, ["name","width","height","url"]);
		}
	}}