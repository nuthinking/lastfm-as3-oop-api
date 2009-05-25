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
	import fm.last.utils.PageResults;

	import flash.events.Event;

	/**
	 * Incapsulates all the methods of the Last.fm library web service
     */
	public class FMLibrary extends FMModelBase
	{
		/**
		 * Defines the related web service method and has been used also as event type id when to dispatch outside the status complete of the method
		 */
		public static const GET_ALBUMS:String = "library.getAlbums";
		
		/**
		 * Defines the related web service method and has been used also as event type id when to dispatch outside the status complete of the method
		 */
		public static const GET_ARTISTS:String = "library.getArtists";
		
		/**
		 * Defines the related web service method and has been used also as event type id when to dispatch outside the status complete of the method
		 */
		public static const GET_TRACKS:String = "library.getTracks";
		
		/**
		 * The user who owns the library
		 */
		public var user : FMUser;
		
		private var albumsResults : PageResults;
		private var artistsResults : PageResults;
		private var tracksResults : PageResults;
		
		/**
		 * The list of albums loaded who are in the library
		 */
		public function get albums () : Array
		{
			if(albumsResults == null)
				return null;
			return albumsResults.items;
		}
		
		/**
		 * The list of artists loaded who are in the library
		 */
		public function get artists () : Array
		{
			if(artistsResults == null)
				return null;
			return artistsResults.items;
		}
		
		/**
		 * The list of tracks loaded who are in the library
		 */
		public function get tracks () : Array
		{
			if(tracksResults == null)
				return null;
			return tracksResults.items;
		}
		
		/**
		 * Constructor
		 * 
		 * @param the owner of the library
		 */
		public function FMLibrary(user : FMUser = null) {
			this.user = user;
		}
		
		/**
		 * Load the list of all the albums in this library, with play counts and tag counts.
		 * 
		 * Ref: http://www.last.fm/api/show?service=321
		 * 
		 * On succesfully complete, it will dispatch the event type GET_ALBUMS
		 * 
		 * @param the max amount of albums to load
		 */
		public function getAlbums(limit : int = 50) : void
		{
			assert(user != null && user.name != null, "To get albums, you need to provide a user with a name");
			assert(limit > 0, "You should request more than 0 albums");
			
			albumsResults = new PageResults(limit);
			getNextAlbums();
		}
		
		private function getNextAlbums() : void
		{
			var variables : Object = {
				user: user.name,
				page: albumsResults.currentPage + 1
			};
			requestURL(GET_ALBUMS, variables, onAlbumsLoaded);
		}
		
		private function onAlbumsLoaded ( response : XML ) : void
		{
			var items : Array = [];
			var children : XMLList = response.albums.album;
			for each(var child : XML in children){
				items.push(mf.createAlbum(child));
			}
			albumsResults.addPage(items);
			var page : uint = parseInt(response.albums.@page);
			var totalpages : uint = parseInt(response.albums.@totalPages);
			if(!albumsResults.isFilled && page < totalpages){
				getNextAlbums();
			}else{
				dispatchEvent(new Event(GET_ALBUMS));
			}
		}

		/**
		 * Load the list of artists in this library, with play counts and tag counts. 
		 * 
		 * Ref: http://www.last.fm/api/show?service=322
		 * 
		 * On succesfully complete, it will dispatch the event type GET_ARTISTS
		 * 
		 * @param the max amount of artists to load
		 */
		public function getArtists(limit : int = 50) : void
		{
			assert(user != null && user.name != null, "To get artists, you need to provide a user with a name");
			assert(limit > 0, "You should request more than 0 artists");
			
			artistsResults = new PageResults(limit);
			getNextArtists();
		}
		
		private function getNextArtists() : void
		{
			var variables : Object = {
				user: user.name,
				page: artistsResults.currentPage + 1
			};
			requestURL(GET_ARTISTS, variables, onArtistsLoaded);
		}
		
		private function onArtistsLoaded ( response : XML ) : void
		{
			var items : Array = [];
			var children : XMLList = response.artists.artist;
			for each(var child : XML in children){
				items.push(mf.createArtist(child));
			}
			artistsResults.addPage(items);
			var page : uint = parseInt(response.artists.@page);
			var totalpages : uint = parseInt(response.artists.@totalPages);
			if(!artistsResults.isFilled && page < totalpages){
				getNextArtists();
			}else{
				dispatchEvent(new Event(GET_ARTISTS));
			}
		}
		
		/**
		 * Load the list of tracks in this library, with play counts and tag counts. 
		 * 
		 * Ref: http://www.last.fm/api/show?service=298
		 * 
		 * On succesfully complete, it will dispatch the event type GET_TRACKS
		 * 
		 * @param the max amount of tracks to load
		 */
		public function getTracks( limit : int = 50 ):void
		{
			assert(user != null && user.name != null, "To get tracks, you need to provide a user with a name");
			assert(limit > 0, "You should request more than 0 tracks");
			
			tracksResults = new PageResults(limit);
			getNextTracks();
		}
		
		private function getNextTracks() : void
		{
			var variables : Object = {
				user: user.name,
				page: tracksResults.currentPage + 1
			};
			requestURL(GET_TRACKS, variables, onTracksLoaded);
		}
		
		private function onTracksLoaded ( response : XML ) : void
		{
			var items : Array = [];
			var children : XMLList = response.tracks.track;
			for each(var child : XML in children){
				items.push(mf.createTrack(child));
			}
			tracksResults.addPage(items);
			var page : uint = parseInt(response.tracks.@page);
			var totalpages : uint = parseInt(response.tracks.@totalPages);
			if(!tracksResults.isFilled && page < totalpages){
				getNextTracks();
			}else{
				dispatchEvent(new Event(GET_TRACKS));
			}
		}
	}
}