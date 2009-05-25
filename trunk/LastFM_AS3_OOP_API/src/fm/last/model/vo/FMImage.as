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
		/**
		 * The title
		 */
		public var name : String;
		
		/**
		 * The url in LastFM
		 */
		public var url : String;
		
		/**
		 * The date the image has been added as returned by the web service
		 */
		public var dateAddedRaw : String;
		
		/**
		 * The format of the image (ie. "jpg")
		 */
		public var format : String;
		
		/**
		 * The owner of the image
		 */
		public var owner : FMOwner;
		
		/**
		 * Amount of thumbs up received
		 */
		public var thumbsUp : Number;
		
		/**
		 * Amount of thumbs down received
		 */
		public var thumbsDown : Number;
		
		private var files : Dictionary;
		
		/**
		 * Creates an instance of the model starting from the XML node returned by the web service
		 * 
		 * @param the xml node representing the model
		 * @return the new populated instance
		 */
		public static function createFromXML ( xml : XML ) : FMImage
		{
			var r : FMImage = new FMImage();
			r.populateFromXML(xml);
			return r;
		}
		
		/**
		 * Populate the model from the different XML formats returned by the web service
		 * 
		 * @param the XML node representing the model
		 */
		protected function populateFromXML ( xml : XML ) : void
		{
			name = xml.title.text();
			url = xml.url.text();
			dateAddedRaw = xml.dateadded.text();
			format = xml.format.text();
			if(xml.owner[0] != null)
				owner = LastFMPreferences.modelFactory.createOwner(xml.owner[0]);
			// sizes
			files = new Dictionary();
			var children : XMLList = xml.sizes.size;
			for each(var child : XML in children){
				var s : FMImageSizeType = FMImageSizeType.getEnumByValue(child.@name);
				files[s] = LastFMPreferences.modelFactory.createImageFile(child);
			}
			thumbsUp = parseInt(xml.votes.thumbsup.text());
			thumbsDown = parseInt(xml.votes.thumbsdown.text());
		}
		
		/**
		 * Returns an image file assigned to a particular type of size
		 * 
		 * @param the type of size
		 * @return the image file
		 */
		public function getImageFileBySize(size : FMImageSizeType) : FMImageFile
		{
			if(files == null)
				return null;
			var r : FMImageFile = files[size];
			return r;		}
	}}