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
{	import fm.last.enum.FMImageSizeType;
	import fm.last.model.LastFMPreferences;

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
			r.populateFromXML(xml);
			return r;
		}
		
		protected function populateFromXML ( xml : XML ) : void
		{
			title = xml.title.text();
			url = xml.url.text();
			dateAddedRaw = xml.dateadded.text();
			format = xml.format.text();
			if(xml.owner[0] != null)
				owner = LastFMPreferences.modelFactory.createOwner(xml.owner[0]);
			// sizes
			sizes = new Dictionary();
			var children : XMLList = xml.sizes.size;
			for each(var child : XML in children){
				var s : FMImageSizeType = FMImageSizeType.getEnumByValue(child.@name);
				sizes[s] = LastFMPreferences.modelFactory.createImageSize(child);
			}
			thumbsUp = parseInt(xml.votes.thumbsup.text());
			thumbsDown = parseInt(xml.votes.thumbsdown.text());
		}
		
		public function getImageBySize(size : FMImageSizeType) : FMImageSize
		{
			if(sizes == null)
				return null;
			var r : FMImageSize = sizes[size];
			return r;		}
	}}