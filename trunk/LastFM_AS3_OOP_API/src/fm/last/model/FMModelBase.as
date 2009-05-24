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
	import fm.last.utils.IFMModelFactory;
	import fm.last.utils.IFMLoader;
	import fm.last.enum.FMImageSizeType;
	import fm.last.events.FMLoadEvent;
	import fm.last.utils.FMLoader;
	import fm.last.utils.TraceUtils;
	import flash.events.*;
	import flash.net.*;
	import flash.utils.Dictionary;
	/**
	* The LastFMBase class is the base class for all classes in this API.
	* LastFMBase holds all the repetative methods and constanants used throughout the API.
	*/
	
	public class FMModelBase extends EventDispatcher
	{
		private var images : Dictionary;
		
		protected var propertiesToTrace : Array = ["id", "name", "title"];
		
		public static var LOADER_CLASS : Class = FMLoader;
		
		override public function toString () : String
		{
			return TraceUtils.generateObjectDescription(this, propertiesToTrace);
		}
		
		protected function get mf () : IFMModelFactory
		{
			return LastFMPreferences.modelFactory;
		}

		protected function assert (cond : Boolean, message : String) : void
		{
			if(!cond)
				throw new Error(message);
		}
		
		protected function addImages(imageNodes : XMLList) : void
		{
			for each(var child : XML in imageNodes){
				var enum : FMImageSizeType = FMImageSizeType.getEnumByValue(child.@size);
				
				if(String(child.text()).length > 0)
					addImage(enum, child.text());
			}
		}
		
		public function addImage(sizeType : FMImageSizeType, url : String) : void
		{
			if(images == null)
				images = new Dictionary();
			images[sizeType] = url;
		}
		
		public function getImageUrlBySize(sizeType : FMImageSizeType) : String
		{
			if(images == null || images[sizeType] == null){
				trace("Error: cannot find image for type: " + sizeType);
				return null;
			}
			return images[sizeType];
		}

		/**
		* Typical format of a simple multiline comment.
		* This text describes the requestURL() method, which is declared below.
		*
		* @return void.
		*
		*/
		public function requestURL(apiMethod:String, variables:Object, populateCallback : Function, requestMethod:String = URLRequestMethod.GET):void
		{
			var loader : IFMLoader = new LOADER_CLASS();
			loader.addEventListener(FMLoadEvent.LOAD_COMPLETE, function (event : FMLoadEvent) : void {
				populateCallback.apply(this, [event.response]);
			});
			loader.requestUrl(apiMethod, variables, requestMethod);
		}
	}
}