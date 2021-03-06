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
	import fm.last.enum.FMSortType;
	import fm.last.model.vo.FMInfo;
	import fm.last.utils.PageResults;

	import flash.events.Event;

	/**
	 * Incapsulates all the methods of the Last.fm artist web service
     */
	public class FMArtist extends FMModelBase
	{
		/**
		 * Defines the related web service method and has been used also as event type id when to dispatch outside the status complete of the method
		 */
		public static const GET_EVENTS:String = "artist.getEvents";
		
		/**
		 * Defines the related web service method and has been used also as event type id when to dispatch outside the status complete of the method
		 */
		public static const GET_IMAGES:String = "artist.getImages";
		
		/**
		 * Defines the related web service method and has been used also as event type id when to dispatch outside the status complete of the method
		 */
		public static const GET_INFO:String = "artist.getInfo";
		
		/**
		 * Defines the related web service method and has been used also as event type id when to dispatch outside the status complete of the method
		 */
		public static const GET_SHOUTS:String = "artist.getShouts";
		
		/**
		 * Defines the related web service method and has been used also as event type id when to dispatch outside the status complete of the method
		 */
		public static const GET_SIMILAR:String = "artist.getSimilar";
		
		/**
		 * Defines the related web service method and has been used also as event type id when to dispatch outside the status complete of the method
		 */
		public static const GET_TOP_ALBUMS:String = "artist.getTopAlbums";
		
		/**
		 * Defines the related web service method and has been used also as event type id when to dispatch outside the status complete of the method
		 */
		public static const GET_TOP_FANS:String = "artist.getTopFans";
		
		/**
		 * Defines the related web service method and has been used also as event type id when to dispatch outside the status complete of the method
		 */
		public static const GET_TOP_TAGS:String = "artist.getTopTags";
		
		/**
		 * Defines the related web service method and has been used also as event type id when to dispatch outside the status complete of the method
		 */
		public static const GET_TOP_TRACKS:String = "artist.getTopTracks";
		
		/**
		 * The name of the artist
		 */
		public var name : String;
		
		/**
		 * The Musicbrainz id
		 */
		public var mbid : String;
		
		/**
		 * The url in LastFM
		 */
		public var url : String;
		
		/**
		 * If it is streamable
		 */
		public var streamable : Boolean;
		//stats
		/**
		 * The amount of listeners
		 */
		public var listeners : Number;
		
		/**
		 * The amount of times the artist has been played
		 */
		public var playCount : Number;
		
		/**
		 * The list of similar artists
		 */
		public var similar : /*FMArtist*/ Array;
		
		/**
		 * Editorial information
		 */
		public var info : FMInfo;
		// extra
		
		/**
		 * The rank position
		 */
		public var rank : Number;
		
		/**
		 * The events the artist performed or will perform
		 */
		public var events : Array;
		private var imagesOrder : FMSortType;
		private var imagesResults : PageResults;
		
		/**
		 * The shouts related to artist
		 */
		public var shouts : Array;
		
		/**
		 * The match factor
		 */
		public var match : Number;
		
		/**
		 * The amount of tags related to the artist
		 */
		public var tagCount : Number;
		
		/**
		 * The most popular albums
		 */
		public var topAlbums : Array;
		
		/**
		 * The biggest fans
		 */
		public var topFans : Array;
		
		/**
		 * The most popular tags related to the artist
		 */
		public var topTags : Array;
		
		/**
		 * The most popular tracks
		 */
		public var topTracks : Array;
		
		/**
		 * The loaded images related to the artist
		 */
		public function get images () : Array
		{
			if(imagesResults == null)
				return null;
			return imagesResults.items;
		}
		
		/**
		 * Constructor
		 * 
		 * @param the artist name
		 */
		public function FMArtist(name : String = null) 
		{
			this.name = name;
			propertiesToTrace = ["name", "rank", "playCount"];
		}
		
		/**
		 * Populate the model from the different XML formats returned by the web service
		 * 
		 * @param the XML node representing the model
		 */
		protected function populateFromXML ( xml : XML) : void
		{
			// compact version
			if(xml.name[0] == null){
				name = xml.text();
				if(xml.@mbid != null)
					mbid = xml.@mbid;
				return;
			}
			// full version
			if(xml.@rank != null)
				rank = parseInt(xml.@rank);
			name = xml.name.text();
			if(xml.mbid[0] != null)
				mbid = xml.mbid.text();
			url = xml.url.text();
			if(xml.image[0] != null)
				addImages(xml.image);
			if(xml.streamable[0] != null)
				streamable = xml.streamable.text() == "1";
			if(xml.stats[0] != null){
				listeners = parseInt(xml.stats.listeners.text());
				playCount = parseInt(xml.stats.playcount.text());
			}else if(xml.playcount[0] != null) {
				playCount = parseInt(xml.playcount.text());
			}
			if(xml.similar[0] != null){
				similar = [];
				for each(var child : XML in xml.similar.artist){
					similar.push(mf.createArtist(child));
				}
			}
			if(xml.bio[0] != null)
				info = mf.createInfo(xml.bio[0]);
			if(xml.match[0] != null)
				match = parseFloat(xml.match.text());
			if(xml.tagcount[0] != null
				&& String(xml.tagcount.text()).length > 0)
					tagCount = parseInt(xml.tagcount.text());
		}
		
		/**
		 * Creates an instance of the model starting from the XML node returned by the web service
		 * 
		 * @param the xml node representing the model
		 * @return the new populated instance
		 */
		public static function createFromXML ( xml : XML ) : FMArtist
		{
			var a : FMArtist = new FMArtist();
			a.populateFromXML(xml);
			return a;
		}
		
		/**
		 * Load the list of upcoming events for this artist.
		 * 
		 * Ref: http://www.last.fm/api/show?service=117
		 * 
		 * On succesfully complete, it will dispatch the event type GET_EVENTS
		 */
		
		public function getEvents() : void
		{
			assert(name != null, "The artist name should be defined to get related events");
			
			requestURL(GET_EVENTS, {artist: name}, onEventsLoaded);
		}
		
		private function onEventsLoaded(response : XML) : void
		{
			events = [];
			var children : XMLList = response.events.event;
			for each(var child : XML in children){
				events.push(mf.createEvent(child));
			}
			dispatchEvent(new Event(GET_EVENTS));
		}
		
		/**
		 * Load Images for this artist in a variety of sizes.
		 * 
		 * Ref: http://www.last.fm/api/show?service=407
		 * 
		 * On succesfully complete, it will dispatch the event type GET_IMAGES
		 * 
		 * @param maximum amount of images to load
		 * @param sort type
		 */
		
		public function getImages(limit : int = 50, order : FMSortType = null) : void
		{
			assert(name != null, "The artist name should be defined to get related images");
			assert(limit > 0, "you should request more than 0 images");
			
			if(order == null)
				order = FMSortType.POPULARITY;
			
			imagesResults = new PageResults(limit);
			imagesOrder = order;
			getNextImages();
		}				private function getNextImages() : void		{
			var variables : Object = {
				artist: name,
				page: imagesResults.currentPage + 1,
				limit: Math.min(imagesResults.remainingToLoad, 50),
				order: imagesOrder.value
			};
			requestURL(GET_IMAGES, variables, onImagesLoaded);
		}
		
		private function onImagesLoaded(response : XML) : void
		{
			var images : Array = [];
			var children : XMLList = response.images.image;
			for each(var child : XML in children){
				images.push(mf.createImage(child));
			}
			imagesResults.addPage(images);
			var page : uint = parseInt(response.images.@page);
			var totalpages : uint = parseInt(response.images.@totalpages);
			if(!imagesResults.isFilled && page < totalpages){
				getNextImages();
			}else{
				dispatchEvent(new Event(GET_IMAGES));
			}
		}
		
		/**
		 * Load the metadata for this artist. Includes biography.
		 * 
		 * Ref: http://www.last.fm/api/show?service=267
		 * 
		 * On succesfully complete, it will dispatch the event type GET_INFO
		 * 
		 * @param the language the editorial information should be loaded in
		 */
		
		public function getInfo(lang:String = "en"):void
		{
			assert(name != null || mbid != null, "To get an artist info, you must supply either the artist name or a musicbrainz id");
			
			var variables : Object = {lang: lang};
			if(name != null)
				variables.artist = name;
			if(mbid != null)
				variables.mbid = mbid;
			requestURL(GET_INFO, variables, onInfoLoaded);
		}
		
		private function onInfoLoaded(response : XML) : void
		{
			var xml : XML = response.artist[0];
			populateFromXML(xml);
			dispatchEvent(new Event(GET_INFO));
		}
		
		/**
		 * Load shouts for this artist.
		 * 
		 * Ref: http://www.last.fm/api/show?service=397
		 * 
		 * On succesfully complete, it will dispatch the event type GET_SHOUTS
		 */
		
		public function getShouts() : void
		{
			assert(name != null, "To get the artist shouts, you must supply the artist name" );
			
			requestURL(GET_SHOUTS, {artist: name}, onShoutsLoaded);
		}
		
		private function onShoutsLoaded(response : XML) : void
		{
			shouts = [];
			var children : XMLList = response.shouts.shout;
			for each(var child : XML in children){
				shouts.push(mf.createShout(child));
			}
			dispatchEvent(new Event(GET_SHOUTS));
		}
		
		/**
		 * Load all the artists similar to this artist 
		 * 
		 * Ref: http://www.last.fm/api/show?service=119
		 * 
		 * On succesfully complete, it will dispatch the event type GET_SIMILAR
		 * 
		 * @param max amount of similar artists to load, if 0 the max amount of artists will be loaded
		 */
		
		public function getSimilar(limit:int = 0):void
		{
			assert(name != null, "To get artist similar, you must supply the artist name");
			assert(limit >= 0, "The limit can't be minor than 0");
			
			var variables : Object = {artist: name};
			if(limit>0)
				variables.limit = limit;
			requestURL(GET_SIMILAR, variables, onSimilarLoaded);
		}
		
		private function onSimilarLoaded(response : XML) : void
		{
			similar = [];
			var children : XMLList = response.similarartists.artist;
			for each(var child : XML in children){
				similar.push(mf.createArtist(child));
			}
			dispatchEvent(new Event(GET_SIMILAR));
		}
		
		/**
		 * Load the top albums for this artist, ordered by popularity.
		 * 
		 * Ref: http://www.last.fm/api/show?service=287
		 * 
		 * On succesfully complete, it will dispatch the event type GET_TOP_ALBUMS
		 */
		public function getTopAlbums():void
		{
			assert(name != null, "To get artist top albums, you must supply the artist name");
			
			requestURL(GET_TOP_ALBUMS, { artist: name }, onTopAlbumsLoaded);
		}
		
		private function onTopAlbumsLoaded(response : XML) : void
		{
			topAlbums = [];
			var children : XMLList = response.topalbums.album;
			for each(var child : XML in children){
				topAlbums.push(mf.createAlbum(child));
			}
			dispatchEvent(new Event(GET_TOP_ALBUMS));
		}
		
		/**
		 * Load the top fans for this artist, based on listening data. 
		 * 
		 * Ref: http://www.last.fm/api/show?service=310
		 * 
		 * On succesfully complete, it will dispatch the event type GET_TOP_FANS
		 */
		public function getTopFans():void
		{
			assert(name != null, "To get artist top fans, you must supply the artist name");
			
			requestURL(GET_TOP_FANS, { artist: name }, onTopFansLoaded);
		}
		
		private function onTopFansLoaded ( response : XML ) : void
		{
			topFans = [];
			var children : XMLList = response.topfans.user;
			for each(var child : XML in children){
				topFans.push(mf.createUser(child));
			}
			dispatchEvent(new Event(GET_TOP_FANS));
		}
		
		/**
		 * Load the top tags for this artist, ordered by popularity.
		 * 
		 * Ref: http://www.last.fm/api/show/?service=288
		 * 
		 * On succesfully complete, it will dispatch the event type GET_TOP_TAGS
		 */
		 
		public function getTopTags():void
		{
			assert(name != null, "To get artist top tags, you must supply the artist name");
			
			requestURL(GET_TOP_TAGS, { artist: name }, onTopTagsLoaded);
		}
		
		private function onTopTagsLoaded ( response : XML ) : void
		{
			topTags = [];
			var children : XMLList = response.toptags.tag;
			for each(var child : XML in children){
				topTags.push(mf.createTag(child));
			}
			dispatchEvent(new Event(GET_TOP_TAGS));
		}
		
		/**
		 *  Get the top tracks by this artist, ordered by popularity 
		 * 
		 * Ref: http://www.last.fm/api/show/?service=277
		 * 
		 * On succesfully complete, it will dispatch the event type GET_TOP_TRACKS
		 */
		public function getTopTracks():void
		{
			assert(name != null, "To get artist top tracks, you must supply the artist name");
			
			requestURL(GET_TOP_TRACKS, { artist: name }, onTopTracksLoaded);
		}
		
		private function onTopTracksLoaded ( response : XML ) : void
		{
			topTracks = [];
			var children : XMLList = response.toptracks.track;
			for each(var child : XML in children){
				topTracks.push(mf.createTrack(child));
			}
			dispatchEvent(new Event(GET_TOP_TRACKS));
		}
	}
}