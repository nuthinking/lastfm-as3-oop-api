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
		public static const GET_ALBUMS:String = "library.getAlbums";
		public static const GET_ARTISTS:String = "library.getArtists";
		public static const GET_TRACKS:String = "library.getTracks";
		public var user : FMUser;
		
		private var albumsResults : PageResults;
		private var artistsResults : PageResults;
		private var tracksResults : PageResults;
		
		public function get albums () : Array
		{
			if(albumsResults == null)
				return null;
			return albumsResults.items;
		}
		public function get artists () : Array
		{
			if(artistsResults == null)
				return null;
			return artistsResults.items;
		}
		public function get tracks () : Array
		{
			if(tracksResults == null)
				return null;
			return tracksResults.items;
		}
		

		public function FMLibrary(user : FMUser = null) {
			this.user = user;
		}
		
		/**
		 * Get a list of all the albums in this library, with play counts and tag counts.
		 * 
		 * Ref: http://www.last.fm/api/show?service=321
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
				items.push(FMAlbum.createFromXML(child));
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
		 * Get the list of artists in this library, with play counts and tag counts. 
		 * 
		 * Ref: http://www.last.fm/api/show?service=322
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
				items.push(FMArtist.createFromXML(child));
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
		 * Get a list of tracks in this library, with play counts and tag counts. 
		 * 
		 * Ref: http://www.last.fm/api/show?service=298
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
				items.push(FMTrack.createFromXML(child));
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