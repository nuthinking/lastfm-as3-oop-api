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
	import fm.last.enum.FMImageSizeType;

	import flash.events.Event;
	import fm.last.model.vo.FMInfo;
	/**
	 * Incapsulates all the methods of the Last.fm track web service. It represents a song on LastFM.
     */
	public class FMTrack extends FMModelBase
	{
		/**
		 * Defines the related web service method and has been used also as event type id when to dispatch outside the status complete of the method
		 */
		public static const GET_INFO:String = "track.getInfo";
		
		/**
		 * Defines the related web service method and has been used also as event type id when to dispatch outside the status complete of the method
		 */
		public static const GET_SIMILAR:String = "track.getSimilar";
		
		/**
		 * Defines the related web service method and has been used also as event type id when to dispatch outside the status complete of the method
		 */
		public static const GET_TOP_FANS:String = "track.getTopFans";
		
		/**
		 * Defines the related web service method and has been used also as event type id when to dispatch outside the status complete of the method
		 */
		public static const GET_TOP_TAGS:String = "track.getTopTags";
		
		/**
		 * LastFM id
		 */
		public var id : int;
		
		/**
		 * The title of the song
		 */
		public var name : String;
		
		/**
		 * The amount of times the track has been played
		 */
		public var playCount : uint;
		
		/**
		 * The Musicbrainz id
		 */
		public var mbid : String;
		
		/**
		 * The url on LastFM
		 */
		public var url : String;
		
		/**
		 * If it is streamable
		 */
		public var streamable : Boolean;
		
		/**
		 * If it is entirely streamable
		 */
		public var streamableAsFullTrack : Boolean;
		
		/**
		 * The artist who recorded this track
		 */
		public var artist : FMArtist;
		// extra
		/**
		 * The rank of the rank, presumably in a chart
		 */
		public var rank : Number;
		
		/**
		 * The match factor
		 */
		public var match : Number;
		
		/**
		 * The amount of related tags
		 */
		public var tagCount : Number;
		
		/**
		 * The amount of people are listening to the track
		 */
		public var listeners : Number;
		
		/**
		 * The duration in milliseconds
		 */
		public var duration : int;
		
		/**
		 * The album which contains this track
		 */
		public var album : FMAlbum;
		
		/**
		 * The list of the most popular tags related
		 */
		public var topTags : Array;
		
		/**
		 * Editorial information
		 */
		public var info : FMInfo;
		
		/**
		 * The list of similar tracks
		 */		
		public var similar : Array;
		
		/**
		 * The list of the biggests fans
		 */
		public var topFans : Array;
		
		/**
		 * Namespace for the XSPF format
		 */
		protected var xspfNamespace:Namespace = new Namespace("http://xspf.org/ns/0/");
		
		/**
		 * Constructor
		 * 
		 * @param the tile of the track
		 */
		public function FMTrack(name : String = null) 
		{
			this.name = name;
			propertiesToTrace = ["name", "artist", "rank"];
		}
		
		/*
		 * Might need to add the date a track has been loved by the user
		 */
		/**
		 * Populate the model from the different XML formats returned by the web service
		 * 
		 * @param the XML node representing the model
		 */
		protected function populateFromXML ( xml : XML ) : void
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
			artist = mf.createArtist(xml.artist[0]); // maybe check if there is already and in case repopulate
			if(xml.album[0] != null)
				album = mf.createAlbum(xml.album[0]); // maybe check if there is already and in case repopulate
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
					topTags.push(mf.createTag(tagXML));
				}
			}
			if(xml.wiki[0] != null)
				info = mf.createInfo(xml.wiki[0]);
		}
		
		/**
		 * Creates an instance of the model starting from the XML node returned by the web service
		 * 
		 * @param the xml node representing the model
		 * @return the new populated instance
		 */
		public static function createFromXML (xml : XML) : FMTrack
		{
			var t : FMTrack = new FMTrack();
			t.populateFromXML(xml);
			return t;
		}
		
		/**
		 * Populate the model from an XSPF formatted XML
		 * 
		 * @param the XML node representing the model
		 */
		protected function populateFromXSPF ( xml : XML ) : void
		{
			name = xml.xspfNamespace::title.text();
			url = xml.xspfNamespace::identifier.text();
			artist = new FMArtist(xml.xspfNamespace::creator.text());
			album = new FMAlbum(xml.xspfNamespace::album.text());
			duration = parseInt(xml.xspfNamespace::duration.text());
			addImage(FMImageSizeType.LARGE, xml.xspfNamespace::image.text());
		}
		
		/**
		 * Creates an instance of the model starting from an XSPF formatted XML
		 * 
		 * @param the xml node representing the model
		 * @return the new populated instance
		 */
		public static function createFromXSPF ( xml : XML ) : FMTrack
		{
			var t : FMTrack = new FMTrack();
			t.populateFromXSPF(xml);
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
		 * Load the metadata for this track.
		 * 
		 * Ref: http://www.last.fm/api/show?service=356
		 * 
		 * On succesfully complete, it will dispatch the event type GET_INFO
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
		 * Load similar tracks based on listening data.
		 * 
		 * Ref: http://www.last.fm/api/show?service=319
		 * 
		 * On succesfully complete, it will dispatch the event type GET_SIMILAR
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
				similar.push(mf.createTrack(child));
			}
			dispatchEvent(new Event(GET_SIMILAR));	
		}
		
		/**
		 * Load the top fans for this track, based on listening data.
		 * 
		 * Ref: http://www.last.fm/api/show?service=312
		 * 
		 * On succesfully complete, it will dispatch the event type GET_TOP_FANS
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
				topFans.push(mf.createUser(child));
			}
			dispatchEvent(new Event(GET_TOP_FANS));
		}
		
		/**
		 * Load the top tags for this track, ordered by tag count.
		 * 
		 * Ref: http://www.last.fm/api/show?service=289
		 * 
		 * On succesfully complete, it will dispatch the event type GET_TOP_TAGS
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
				topTags.push(mf.createTag(child));
			}
			dispatchEvent(new Event(GET_TOP_TAGS));
		}
	}
}