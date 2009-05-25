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
package fm.last.enum 
{

	/**
	 * Enumerator which defines the date range for methods like FMUser.getTopTracks and FMUser.getTopArtists
	 * 
	 * @author christian
	 */
	public class FMPeriodType 
	{
		/**
		 * Enumerator for "overall"
		 */
		public static const OVERALL : FMPeriodType = new FMPeriodType("overall");
		
		/**
		 * Enumerator for "3month"
		 */
		public static const THREE_MONTHS : FMPeriodType = new FMPeriodType("3month");
		
		/**
		 * Enumerator for "6month"
		 */
		public static const SIX_MONTHS : FMPeriodType = new FMPeriodType("6month");
		
		/**
		 * Enumerator for "12month"
		 */
		public static const TWELVE_MONTHS : FMPeriodType = new FMPeriodType("12month");
		
		/**
		 * The string representation of the enumerator
		 */
		public var value : String;
		
		/**
		 * Constructor
		 * @param the string representation of the enumerator
		 */
		public function FMPeriodType ( value : String )
		{
			this.value = value;
		}
	}
}
