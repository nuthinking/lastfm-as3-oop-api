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
package test.last.utils 
{	import test.last.utils.TestResponse;
	
	/**	 * @author christian	 */	public class TestMultiPageResponse extends TestResponse 
	{		private var xmls : Array;				public function TestMultiPageResponse(xmlClasses : Array)
		{			super(null);
			
			xmls = [];
			for each(var xmlClass : Class in xmlClasses){
				xmls.push(getEmbeddedXML(xmlClass));			}
		}
		
		override public function getResponse(variables : Object) : XML
		{
			return xmls[variables.page-1];
		}
	}}