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
		
		public var name : String;
		public var artist : FMArtist;
		public var id : String;
		public var mbid : String;
		public var url : String;
		public var releaseDateRaw : String;
		public var listeners : Number;
		public var playCount : Number;
		public var streamable : Boolean;
		public var tagCount : Number;
		
		public var topTags : Array;
		public var bio : FMInfo;
		
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
			artist = FMArtist.createFromXML(xml.artist[0]);
			id = xml.id.text();
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
				bio = FMInfo.createFromXML(xml.wiki[0]);
			if(xml.tagcount[0] != null
				&& String(xml.tagcount.text()).length > 0)
					tagCount = parseInt(xml.tagcount.text());
		}
		
		public function FMAlbum(name : String = null)
		{
			this.name = name;
		}

		private function addTagsFromNodes(nodes : XMLList) : void
		{
			// TODO: check if tag is already present, maybe a dictionary based on name would be better
			topTags = [];
			for each(var child : XML in nodes){
				topTags.push(FMTag.createFromXML(child));
			}
		}
		
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