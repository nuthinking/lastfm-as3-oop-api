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
package fm.last.model
{
	import fm.last.model.vo.FMInfo;

	import flash.events.Event;

	/**
	 * Incapsulates all the methods of the Last.fm album web service
     */
	public class FMAlbum extends FMModelBase
	{
		public static const GET_INFO:String = "album.getInfo";
		
		/**
		 * The title of the album
		 */
		public var name : String;
		
		/**
		 * The artist who recorded the album
		 */
		public var artist : FMArtist;
		
		/**
		 * The LastFM id of the album
		 */
		public var id : int;
		
		/**
		 * The muzicbrainz id of the album
		 */
		public var mbid : String;
		
		/**
		 * The url on LastFM of the album
		 */
		public var url : String;
		
		/**
		 * The release date of the album as returned by the XML
		 */
		public var releaseDateRaw : String;
		
		/**
		 * The amount of listeners
		 */
		public var listeners : Number;
		
		/**
		 * The amount of times the album as been played
		 */
		public var playCount : Number;
		
		/**
		 * If the album can be streamed
		 */
		public var streamable : Boolean;
		
		/**
		 * The amount of tags assigned to the album
		 */
		public var tagCount : Number;
		
		/**
		 * The most relevant tags assigned to the album
		 */
		public var topTags : Array;
		
		/**
		 * Editorial information about the album
		 */
		public var bio : FMInfo;
		
		/**
		 * Populate the model from the different XML formats returned by the web service
		 */
		protected function populateFromXML ( xml : XML) : void
		{
			if(xml.name[0] == null && xml.title[0] == null){
				mbid = xml.@mbid;
				name = xml.text();
				return;
			}
			if(xml.title[0] == null){
				name = xml.name.text();
			}else{
				name = xml.title.text();				
			}
			artist = mf.createArtist(xml.artist[0]);
			id = parseInt(xml.id.text());
			if(xml.mbid[0] != null)
				mbid = xml.mbid.text();
			url = xml.url.text();
			if(xml.releasedate[0] != null)
				releaseDateRaw = xml.releasedate.text();
			addImages(xml.image);
			if(xml.listeners[0] != null)
				listeners = parseInt(xml.listeners.text());
			if(xml.playcount[0] != null)
				playCount = parseInt(xml.playcount.text());
			streamable = xml.streamable.text() == "1";
			if(xml.toptags[0] != null)
				addTagsFromNodes(xml.toptags.tag);
			if(xml.wiki[0] != null)
				bio = mf.createInfo(xml.wiki[0]);
			if(xml.tagcount[0] != null
				&& String(xml.tagcount.text()).length > 0)
					tagCount = parseInt(xml.tagcount.text());
		}
		
		/**
		 * Constructor
		 * 
		 * @param the title of the album
		 */
		
		public function FMAlbum(name : String = null)
		{
			this.name = name;
		}

		private function addTagsFromNodes(nodes : XMLList) : void
		{
			// TODO: check if tag is already present, maybe a dictionary based on name would be better
			topTags = [];
			for each(var child : XML in nodes){
				topTags.push(mf.createTag(child));
			}
		}
		
		/**
		 * Creates an instance of the model starting from the XML node returned by the web service
		 * 
		 * @param the xml node
		 * @return the new populated instance
		 */
		
		public static function createFromXML ( xml : XML ) : FMAlbum
		{
			var a : FMAlbum = new FMAlbum();
			a.populateFromXML(xml);
			return a;
		}
		
		/**
		 * Get the metadata of the album.
		 * See playlist.fetch on how to get the album playlist.
		 * 
		 * Ref: http://www.last.fm/api/show?service=290
		 */

		public function getInfo(lang:String = "en"):void
		{
			assert((name != null && artist != null && artist.name != null) || mbid != null, "To get an album info, you must supply either an artist and album name or a musicbrainz id");
			
			var variables : Object = { lang: lang };
			if(name != null)
				variables.album = name;
			if(artist != null)
				variables.artist = artist.name;
			if(mbid != null)
				variables.mdib = mbid;
			requestURL(GET_INFO, variables, onInfoLoaded);
		}

		private function onInfoLoaded(response : XML) : void
		{
			var xml : XML = response.album[0];
			populateFromXML(xml);
			dispatchEvent(new Event(GET_INFO));
		}
	}
}