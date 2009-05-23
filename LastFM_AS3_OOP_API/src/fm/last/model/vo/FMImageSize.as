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
	 * ValueObject used by FMImage to identify the visual representation of an image
	 * 
	 * (I'm not particularly sure about the name of this class)
	 * 
	 * @see FMImage
	 * 	 * @author christian	 */	public class FMImageSize 
	{
		public var name : String;
		public var width : Number;
		public var height : Number;
		public var url : String;
		
		public static function createFromXML ( xml : XML ) : FMImageSize
		{
			var r : FMImageSize = new FMImageSize();
			r.name = xml.@name;
			r.width = parseFloat(xml.@width);			r.height = parseFloat(xml.@height);
			r.url = xml.text();
			return r;		}
		
		public function toString () : String
		{
			return TraceUtils.generateObjectDescription(this, ["name","width","height","url"]);
		}
	}}