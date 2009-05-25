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
package fm.last.utils 
{	import fm.last.events.FMLoadEvent;
	import fm.last.model.LastFMPreferences;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	/**
	 * Loader for web service calls, it handles errors and result status validation
	 * 	 * @author christian	 */	public class FMLoader extends URLLoader implements IFMLoader
	{		public function FMLoader()
		{
			super(null);		}

        private function configureListeners():void {
            addEventListener(Event.COMPLETE, completeHandler);
            addEventListener(Event.OPEN, openHandler);
            addEventListener(ProgressEvent.PROGRESS, progressHandler);
            addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
            addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
            addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
        }

        private function completeHandler(event:Event):void 
        {
			var responseXML : XML = new XML(event.target.data);
			// validation
			var status : String = responseXML.@status;
			if(status == "ok"){
				dispatchEvent(new FMLoadEvent(FMLoadEvent.LOAD_COMPLETE, responseXML));
			}else{
				trace("Error, respond status not ok: " + responseXML);
			}
        }

        private function openHandler(event:Event):void 
        {
            trace("openHandler: " + event);
        }

        private function progressHandler(event:ProgressEvent):void 
        {
            trace("progressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
        }

        private function securityErrorHandler(event:SecurityErrorEvent):void 
        {
            trace("securityErrorHandler: " + event);
        }

        private function httpStatusHandler(event:HTTPStatusEvent):void 
        {
            trace("httpStatusHandler: " + event);
        }

        private function ioErrorHandler(event:IOErrorEvent):void 
        {
            trace("ioErrorHandler: " + event);
		}		
		/**
		 * @inheritDoc
		 */		public function requestUrl(apiMethod : String, variables : Object, requestMethod : String = "GET") : void		{
			var v : URLVariables = new URLVariables();
			v.method = apiMethod;
			v.api_key = LastFMPreferences.API_KEY;

			var request:URLRequest = new URLRequest(LastFMPreferences.API_URL);
			
			for (var i:String in variables)
			{
				v[i] = variables[i];
			}
			request.data = v;
            configureListeners();
            request.method = requestMethod;
            trace(requestMethod + " Request : \"" + request.url + "\"\n" + "Variables : " + v);
            load(request);
		}
	}}