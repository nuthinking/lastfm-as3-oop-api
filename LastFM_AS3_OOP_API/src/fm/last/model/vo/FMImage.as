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
	import fm.last.enum.FMImageSizeType;
	import flash.utils.Dictionary;
	/**
	 * ValueObject returned by the getImages methodd (ie: artist.getImages)
	 * 	 * @author christian	 */	public class FMImage 
	{
		public var title : String;
		public var url : String;
		public var dateAddedRaw : String;
		public var format : String;
		public var owner : FMOwner;
		public var thumbsUp : Number;
		public var thumbsDown : Number;
		
		private var sizes : Dictionary;
		
		public static function createFromXML ( xml : XML ) : FMImage
		{
			var r : FMImage = new FMImage();
			r.title = xml.title.text();
			r.url = xml.url.text();
			r.dateAddedRaw = xml.dateadded.text();
			r.format = xml.format.text();
			if(xml.owner[0] != null)
				r.owner = FMOwner.createFromXML(xml.owner[0]);
			// sizes
			r.sizes = new Dictionary();
			var children : XMLList = xml.sizes.size;
			for each(var child : XML in children){
				var s : FMImageSizeType = FMImageSizeType.getEnumByValue(child.@name);
				r.sizes[s] = FMImageSize.createFromXML(child);
			}
			r.thumbsUp = parseInt(xml.votes.thumbsup.text());
			r.thumbsDown = parseInt(xml.votes.thumbsdown.text());
			return r;
		}
		
		public function getImageBySize(size : FMImageSizeType) : FMImageSize
		{
			if(sizes == null)
				return null;
			var r : FMImageSize = sizes[size];
			return r;		}
	}}