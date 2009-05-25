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
{	import flash.utils.getQualifiedClassName;

	/**
	 * Contains utilities for simple logging
	 * 	 * @author christian	 */	public class TraceUtils 
	{
		/**
		 * Generates a human readable string version of a typed model structure
		 */
		public static function generateObjectDescription(obj : Object, properties : Array) : String
		{
			var className : String = getQualifiedClassName(obj).split("::")[1];
			var res : String = className + "{";
			var len : uint = properties.length;
			var hasOne : Boolean = false;
			for (var i: uint; i<len; i++){
				var propertyName : String = properties[i];
				if(obj.hasOwnProperty(propertyName)){
					if(hasOne > 0)
						res += ", ";
					res += propertyName + ":" + obj[propertyName];
					hasOne = true;
				}
				
			}
			res += "}";
			return res;		}
	}}