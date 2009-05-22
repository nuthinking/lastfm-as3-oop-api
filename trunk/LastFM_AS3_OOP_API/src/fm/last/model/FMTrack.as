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
	import flash.events.Event;
	import fm.last.model.vo.FMInfo;
	/**
	 * Incapsulates all the methods of the Last.fm track web service
     */
	public class FMTrack extends FMModelBase
	{
		public static const GET_INFO:String = "track.getInfo";
		public static const GET_SIMILAR:String = "track.getSimilar";
		public static const GET_TOP_FANS:String = "track.getTopFans";
		public static const GET_TOP_TAGS:String = "track.getTopTags";
		
		public var id : int;
		public var name : String;
		public var playCount : uint;
		public var mbid : String;
		public var url : String;
		public var streamable : Boolean;
		public var streamableAsFullTrack : Boolean;
		public var artist : FMArtist;
		// extra
		public var rank : Number;
		public var match : Number;
		public var tagCount : Number;
		public var listeners : Number;
		public var duration : int;
		public var album : FMAlbum;
		public var topTags : Array;
		public var bio : FMInfo;
		// responses
		public var similar : Array;
		public var topFans : Array;

		public function FMTrack(name : String = null) 
		{
			this.name = name;
			propertiesToTrace = ["name", "artist", "rank"];
		}
		
		/**
		 * Might need to add the date a track has been loved by the user
		 */
		
		private function populateFromXML ( xml : XML ) : void
		{
			if(xml.@rank != null)
				rank = parseInt(xml.@rank);
			if(xml.id[0] != null)
				id = parseInt(xml.id.text());
			name = xml.name.text();
			playCount = parseInt(xml.playcount.text());
			if(xml.mbid[0] != null)
				mbid = xml.mbid.text();
			if(xml.match[0] != null)
				match = parseFloat(xml.match[0].text());
			url = xml.url.text();
			if(xml.duration[0] != null)
				duration = parseInt(xml.duration[0]);
			streamable = xml.streamable.text() == "1";
			streamableAsFullTrack = xml.streamable.@fulltrack == "1";
			artist = FMArtist.createFromXML(xml.artist[0]); // maybe check if there is already and in case repopulate
			if(xml.album[0] != null)
				album = FMAlbum.createFromXML(xml.album[0]); // maybe check if there is already and in case repopulate
			if(xml.image[0] != null)
				addImages(xml.image);
			if(xml.tagcount[0] != null
				&& String(xml.tagcount.text()).length > 0)
					tagCount = parseInt(xml.tagcount.text());
			if(xml.listeners[0] != null)
				listeners = parseInt(xml.listeners.text());
			if(xml.toptags.tag[0] != null){
				topTags = [];
				for each(var tagXML : XML in xml.toptags.tag){
					topTags.push(FMTag.createFromXML(tagXML));
				}
			}
			if(xml.wiki[0] != null)
				bio = FMInfo.createFromXML(xml.wiki[0]);
		}

		public static function createFromXML (xml : XML) : FMTrack
		{
			var t : FMTrack = new FMTrack();
			t.populateFromXML(xml);
			return t;
		}
		
		private function get hasNameAndAristOrMbid () : Boolean
		{
			return ((artist != null && artist.name != null) && name != null) || mbid != null;
		}
		
		private function get variablesWithNameAndArtistorMbid () : Object
		{
			var variables : Object = {};
			
			if((artist != null && artist.name != null) && name != null){
				variables.artist = artist.name;
				variables.track = name;
			}else{
				variables.mbid = mbid;
			}
			return variables;
		}

		/**
		 * Get the metadata for this track.
		 * 
		 * Ref: http://www.last.fm/api/show?service=356
		 */
		public function getInfo():void
		{
			assert(hasNameAndAristOrMbid, "To get track info, track needs to have or artist name and track name or musicbrainz id");
			
			requestURL(GET_INFO, variablesWithNameAndArtistorMbid, onInfoLoaded);
		}
		
		private function onInfoLoaded ( response : XML ) : void
		{
			var node : XML = response.track[0];
			populateFromXML(node);
			dispatchEvent(new Event(GET_INFO));
		}
		
		/**
		 * Get similar tracks based on listening data.
		 * 
		 * Ref: http://www.last.fm/api/show?service=319
		 */
		public function getSimilar():void
		{
			assert(hasNameAndAristOrMbid, "To get similar, track needs to have or artist name and track name or musicbrainz id");
			
			requestURL(GET_SIMILAR, variablesWithNameAndArtistorMbid, onSimilarLoaded);
		}
		
		private function onSimilarLoaded ( response : XML) : void
		{
			similar = [];
			var children : XMLList = response.similartracks.track;
			for each(var child : XML in children) {
				similar.push(FMTrack.createFromXML(child));
			}
			dispatchEvent(new Event(GET_SIMILAR));	
		}
		
		/**
		 * Get the top fans for this track, based on listening data.
		 * 
		 * Ref: http://www.last.fm/api/show?service=312
		 */
		public function getTopFans() : void
		{
			assert(hasNameAndAristOrMbid, "To get top fans, track needs to have or artist name and track name or musicbrainz id");
			
			requestURL(GET_TOP_FANS, variablesWithNameAndArtistorMbid, onTopFansLoaded);
		}
		
		private function onTopFansLoaded ( response : XML ) : void
		{
			topFans = [];
			var children : XMLList = response.topfans.user;
			for each(var child : XML in children) {
				topFans.push(FMUser.createFromXML(child));
			}
			dispatchEvent(new Event(GET_TOP_FANS));
		}
		
		/**
		 * Get the top tags for this track, ordered by tag count.
		 * 
		 * Ref: http://www.last.fm/api/show?service=289
		 */
		public function getTopTags() : void
		{
			assert(hasNameAndAristOrMbid, "To get top tags, track needs to have or artist name and track name or musicbrainz id");
			
			requestURL(GET_TOP_TAGS, variablesWithNameAndArtistorMbid, onTopTagsLoaded);
		}
		
		private function onTopTagsLoaded ( response : XML ) : void
		{
			topTags = [];
			var children : XMLList = response.toptags.tag;
			for each(var child : XML in children) {
				topTags.push(FMTag.createFromXML(child));
			}
			dispatchEvent(new Event(GET_TOP_TAGS));
		}
	}
}