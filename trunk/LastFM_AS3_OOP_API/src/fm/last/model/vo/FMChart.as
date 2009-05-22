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
package fm.last.model.vo 
{
	/**
	 * ValueObject returned by the getWeeklyChartList methods
	 * 	 * @author christian	 */	public class FMChart 
	{
		public var dateFrom : Date;
		public var dateTo : Date;
		
		public function get dateFromAsInt () : Number
		{
			if(dateFrom == null)
				return NaN;
			return Math.round(dateFrom.time / 1000);
		}
		
		public function get dateToAsInt () : Number
		{
			if(dateTo == null)
				return NaN;
			return Math.round(dateTo.time / 1000);
		}
		
		public function FMChart(dateFrom : Date = null, dateTo : Date = null)
		{
			this.dateFrom = dateFrom;
			this.dateTo = dateTo;	
		}
		
		public static function createFromInt (dateFrom : uint, dateTo : uint) : FMChart
		{
			var df : Date = new Date(dateFrom * 1000);
			var dt : Date = new Date(dateTo * 1000);
			return new FMChart(df, dt);
		}
		
		public static function createFromXML ( xml : XML ) : FMChart
		{
			var from : int = parseInt(xml.@from);
			var to : int = parseInt(xml.@to);
			return createFromInt(from, to);
		}
	}}