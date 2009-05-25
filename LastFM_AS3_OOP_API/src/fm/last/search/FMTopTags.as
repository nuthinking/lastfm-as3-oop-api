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
package fm.last.search 
{
	import fm.last.model.FMModelBase;

	import flash.events.Event;

	/**
	 * Model which processed the loading of the top tags
	 * 
	 * @author christian
	 */
	public class FMTopTags extends FMModelBase 
	{
		/**
		 * Defines the related web service method and has been used also as event type id when to dispatch outside the status complete of the method
		 */
		public static const GET_TOP_TAGS : String = "tag.getTopTags";
		
		/**
		 * The tags loaded from the web service
		 */
		public var tags : Array;
		
		/**
		 * Constructor
		 */
		public function FMTopTags()
		{
		}
		
		/**
		 * Load the top tags and on success it will dispatch the event type GET_TOP_TAGS
		 */
		public function getTopTags () : void
		{
			requestURL(GET_TOP_TAGS, {}, onTagsLoaded);
		}
		
		private function onTagsLoaded ( response : XML ) : void
		{
			tags = [];
			var children : XMLList = response.toptags.tag;
			for each(var child : XML in children){
				tags.push(mf.createTag(child));
			}
			dispatchEvent(new Event(FMTopTags.GET_TOP_TAGS));
		}
	}
}
