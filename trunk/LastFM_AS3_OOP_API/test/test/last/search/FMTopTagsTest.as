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
package test.last.search 
{
	import fm.last.model.FMTag;
	import fm.last.search.FMTopTags;

	import test.last.model.FMModelTest;

	import flash.events.Event;

	/**
	 * @author christian
	 */
	public class FMTopTagsTest extends FMModelTest 
	{
		public function FMTopTagsTest(methodName : String = null)
		{
			super(methodName);
		}
		
		public function testMain () : void
		{
			var o : FMTopTags = new FMTopTags();
			o.addEventListener(FMTopTags.GET_TOP_TAGS, onComplete);
			o.getTopTags();
		}
		
		private function onComplete(event : Event) : void
		{
			var o : FMTopTags = FMTopTags(event.currentTarget);
			assertEquals("FMTopTags should return the correct amount of tags", 250, o.tags.length);
			var firstTag : FMTag = o.tags[0];
			assertEquals("FMTopTag should set the first tag name", "rock", firstTag.name);
			assertEquals("FMTopTag should set the first tag count", 2206883, firstTag.count);
			assertEquals("FMTopTag should set the first tag url", "www.last.fm/tag/rock", firstTag.url);
			var lastTag : FMTag = o.tags.pop();
			assertEquals("FMTopTag should set the last tag name", "symphonic black metal", lastTag.name);
			assertEquals("FMTopTag should set the last tag count", 27592, lastTag.count);
			assertEquals("FMTopTag should set the last tag url", "www.last.fm/tag/symphonic%20black%20metal", lastTag.url);
		}
	}
}
