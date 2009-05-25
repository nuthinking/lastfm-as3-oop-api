package fm.last.utils 
{
	import fm.last.model.FMAlbum;
	import fm.last.model.FMArtist;
	import fm.last.model.FMEvent;
	import fm.last.model.FMGeo;
	import fm.last.model.FMPlayList;
	import fm.last.model.FMTag;
	import fm.last.model.FMTrack;
	import fm.last.model.FMUser;
	import fm.last.model.FMVenue;
	import fm.last.model.vo.FMChart;
	import fm.last.model.vo.FMImage;
	import fm.last.model.vo.FMImageSize;
	import fm.last.model.vo.FMInfo;
	import fm.last.model.vo.FMLocation;
	import fm.last.model.vo.FMOwner;
	import fm.last.model.vo.FMShout;

	/**
	 * Interface which defines the factory for the models.
	 * If you want to override the models, you should assign a new model factory to LastFMPreferences
	 * implementing your class or extending FMModelFactory.
	 * 
	 * @see LastFMPreferences, FMModelFactory
	 * 
	 * @author christian
	 */
	public interface IFMModelFactory 
	{
		function createAlbum ( xml : XML ) : FMAlbum;
		function createArtist ( xml : XML ) : FMArtist;
		function createEvent ( xml : XML ) : FMEvent;
		function createGeo ( xml : XML ) : FMGeo;
		function createPlayList ( xml : XML ) : FMPlayList;
		function createTag ( xml : XML ) : FMTag;
		function createTrack ( xml : XML, isXSPF : Boolean = false) : FMTrack;
		function createUser ( xml : XML ) : FMUser;
		function createVenue ( xml : XML ) : FMVenue;
		// value objects
		function createChart ( xml : XML ) : FMChart;
		function createImage ( xml : XML ) : FMImage;
		function createImageSize ( xml : XML ) : FMImageSize;
		function createInfo ( xml : XML ) : FMInfo;
		function createLocation ( xml : XML ) : FMLocation;
		function createOwner ( xml : XML ) : FMOwner;
		function createShout ( xml : XML ) : FMShout;
	}
}
