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
	 * ValueObject returned by the getWeeklyChartList methods, it defines mainly the date range for a chart
	 * 
	 * Note: This might come back as FMChart an incapsulate the chart loading
	 * 	 * @author christian	 */	public class FMChartDateRange 
	{
		/**
		 * The starting date of the chart
		 */
		public var dateFrom : Date;
		
		/**
		 * The ending date of the chart
		 */
		public var dateTo : Date;
		
		/**
		 * The starting date of the chart as unix date
		 */
		public function get dateFromAsInt () : Number
		{
			if(dateFrom == null)
				return NaN;
			return Math.round(dateFrom.time / 1000);
		}
		
		/**
		 * The ending date of the chart as unix date
		 */
		public function get dateToAsInt () : Number
		{
			if(dateTo == null)
				return NaN;
			return Math.round(dateTo.time / 1000);
		}
		
		/**
		 * Constructor
		 * 
		 * @param the starting date of the chart
		 * @param the ending date of the chart
		 */
		public function FMChartDateRange(dateFrom : Date = null, dateTo : Date = null)
		{
			this.dateFrom = dateFrom;
			this.dateTo = dateTo;	
		}
		
		/**
		 * Creates an instance from the unix dates
		 * 
		 * @param starting date as unix date
		 * @param ending date as unix date
		 * @return the new instance
		 */
		public static function createFromInt (dateFrom : uint, dateTo : uint) : FMChartDateRange
		{
			var df : Date = new Date(dateFrom * 1000);
			var dt : Date = new Date(dateTo * 1000);
			return new FMChartDateRange(df, dt);
		}
		
		/**
		 * Creates an instance of the model starting from the XML node returned by the web service
		 * 
		 * @param the xml node representing the model
		 * @return the new populated instance
		 */
		public static function createFromXML ( xml : XML ) : FMChartDateRange
		{
			var from : int = parseInt(xml.@from);
			var to : int = parseInt(xml.@to);
			return createFromInt(from, to);
		}
	}}