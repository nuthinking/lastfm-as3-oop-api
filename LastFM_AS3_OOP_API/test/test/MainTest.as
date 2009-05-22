/** *  This file is part of LastMF AS3 OOP API. *   *  http://code.google.com/p/lastfm-as3-oop-api/ * *  LastMF AS3 OOP API is free software: you can redistribute it and/or modify *  it under the terms of the GNU General Public License as published by *  the Free Software Foundation, either version 3 of the License, or *  (at your option) any later version. * *  LastMF AS3 OOP API is distributed in the hope that it will be useful, *  but WITHOUT ANY WARRANTY; without even the implied warranty of *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the *  GNU General Public License for more details. * *  You should have received a copy of the GNU General Public License *  along with LastMF AS3 OOP API.  If not, see <http://www.gnu.org/licenses/>. *   *  @author Christian Giordano for Tonic.co.uk * */package test {
	import flexunit.framework.TestCase;	import flexunit.framework.TestSuite;	import fm.last.model.FMModelBase;	import fm.last.search.FMSearchBase;	import test.last.model.FMAlbumTest;	import test.last.model.FMArtistTest;	import test.last.model.FMEventTest;	import test.last.model.FMGeoTest;	import test.last.model.FMGroupTest;	import test.last.model.FMImageTest;	import test.last.model.FMLibraryTest;	import test.last.model.FMPlayListTest;	import test.last.model.FMTagTest;	import test.last.model.FMTrackTest;	import test.last.model.FMUserTest;	import test.last.model.FMVenueTest;	import test.last.model.vo.FMLocationTest;	import test.last.model.vo.FMShoutTest;	import test.last.search.FMAlbumSearchTest;	import test.last.search.FMArtistSearchTest;	import test.last.search.FMTagSearchTest;	import test.last.search.FMTopTagsTest;	import test.last.search.FMTrackSearchTest;	import test.last.search.FMVenueSearchTest;	import test.last.utils.TestLoader;	/**
	 * @author christian
	 */
	public class MainTest extends TestCase {
		public function MainTest(methodName : String = null) {
			super(methodName);
		}
		
		public static function suite() : TestSuite
		{			FMModelBase.LOADER_CLASS = TestLoader;			FMSearchBase.LOADER_CLASS = TestLoader;			
			var ts : TestSuite = new TestSuite();			ts.addTestSuite(FMAlbumTest);
			ts.addTestSuite(FMAlbumSearchTest);
			ts.addTestSuite(FMArtistTest);
			ts.addTestSuite(FMArtistSearchTest);
			ts.addTestSuite(FMEventTest);
			ts.addTestSuite(FMGeoTest);
			ts.addTestSuite(FMGroupTest);
			ts.addTestSuite(FMImageTest);
			ts.addTestSuite(FMLibraryTest);
			ts.addTestSuite(FMLocationTest);
			ts.addTestSuite(FMPlayListTest);
			ts.addTestSuite(FMShoutTest);
			ts.addTestSuite(FMTagTest);
			ts.addTestSuite(FMTopTagsTest);
			ts.addTestSuite(FMTagSearchTest);
			ts.addTestSuite(FMTrackTest);
			ts.addTestSuite(FMTrackSearchTest);
			ts.addTestSuite(FMUserTest);
			ts.addTestSuite(FMVenueTest);
			ts.addTestSuite(FMVenueSearchTest);
			return ts;
		}
	}
}
