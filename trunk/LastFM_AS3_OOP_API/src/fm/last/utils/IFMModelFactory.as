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
	import fm.last.model.vo.FMChartDateRange;
	import fm.last.model.vo.FMImage;
	import fm.last.model.vo.FMImageFile;
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
		/**
		 * Creates an album model by its XML representation.
		 * 
		 * @param the XML node representing the model
		 * @return the newly created album
		 */
		function createAlbum ( xml : XML ) : FMAlbum;
		
		/**
		 * Creates an artist model by its XML representation.
		 * 
		 * @param the XML node representing the model
		 * @return the newly created artist
		 */
		function createArtist ( xml : XML ) : FMArtist;
		
		/**
		 * Creates an event model by its XML representation.
		 * 
		 * @param the XML node representing the model
		 * @return the newly created event
		 */
		function createEvent ( xml : XML ) : FMEvent;
		
		/**
		 * Creates a geo model by its XML representation.
		 * 
		 * @param the XML node representing the model
		 * @return the newly created geo
		 */
		function createGeo ( xml : XML ) : FMGeo;
		
		/**
		 * Creates a playlist model by its XML representation.
		 * 
		 * @param the XML node representing the model
		 * @return the newly created playlist
		 */
		function createPlayList ( xml : XML ) : FMPlayList;
		
		/**
		 * Creates a tag model by its XML representation.
		 * 
		 * @param the XML node representing the model
		 * @return the newly created tag
		 */
		function createTag ( xml : XML ) : FMTag;
		
		/**
		 * Creates a track model by its XML representation.
		 * 
		 * @param the XML node representing the model
		 * @param if the XML is in XSPF format (returned for instance from the playlist)
		 * @return the newly created track
		 */
		function createTrack ( xml : XML, isXSPF : Boolean = false) : FMTrack;
		
		/**
		 * Creates a user model by its XML representation.
		 * 
		 * @param the XML node representing the model
		 * @return the newly created user
		 */
		function createUser ( xml : XML ) : FMUser;
		
		/**
		 * Creates a venue model by its XML representation.
		 * 
		 * @param the XML node representing the model
		 * @return the newly created venue
		 */
		function createVenue ( xml : XML ) : FMVenue;
		
		// value objects
		/**
		 * Creates a chart date range model by its XML representation.
		 * 
		 * @param the XML node representing the model
		 * @return the newly created chart
		 */
		function createChartDateRange ( xml : XML ) : FMChartDateRange;
		
		/**
		 * Creates an image model by its XML representation.
		 * 
		 * @param the XML node representing the model
		 * @return the newly created image
		 */
		function createImage ( xml : XML ) : FMImage;
		
		/**
		 * Creates an image file model by its XML representation.
		 * 
		 * @param the XML node representing the model
		 * @return the newly created image size
		 */
		function createImageFile ( xml : XML ) : FMImageFile;
		
		/**
		 * Creates an info model by its XML representation.
		 * 
		 * @param the XML node representing the model
		 * @return the newly created info
		 */
		function createInfo ( xml : XML ) : FMInfo;
		
		/**
		 * Creates a location model by its XML representation.
		 * 
		 * @param the XML node representing the model
		 * @return the newly created location
		 */
		function createLocation ( xml : XML ) : FMLocation;
		
		/**
		 * Creates an owner model by its XML representation.
		 * 
		 * @param the XML node representing the model
		 * @return the newly created owner
		 */
		function createOwner ( xml : XML ) : FMOwner;
		
		/**
		 * Creates a shout model by its XML representation.
		 * 
		 * @param the XML node representing the model
		 * @return the newly created shout
		 */
		function createShout ( xml : XML ) : FMShout;
	}
}
