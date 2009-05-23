/**
	import flexunit.framework.TestCase;
	 * @author christian
	 */
	public class MainTest extends TestCase {
		public function MainTest(methodName : String = null) {
			super(methodName);
		}
		
		public static function suite() : TestSuite
		{
			var ts : TestSuite = new TestSuite();
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