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
	import fm.last.utils.IFMModelFactory;

	/**
	 * Default implementation of IFMModelFactory, you should replace this or override it if you want to extend the models
	 * 
	 * @author christian
	 */
	public class FMModelFacory implements IFMModelFactory 
	{
		/**
		 * @inheritDoc
		 */
		public function createAlbum(xml : XML) : FMAlbum
		{
			return FMAlbum.createFromXML(xml);
		}
		
		/**
		 * @inheritDoc
		 */
		public function createArtist(xml : XML) : FMArtist
		{
			return FMArtist.createFromXML(xml);
		}
		
		/**
		 * @inheritDoc
		 */
		public function createEvent(xml : XML) : FMEvent
		{
			return FMEvent.createFromXML(xml);
		}
		
		/**
		 * @inheritDoc
		 */
		public function createGeo(xml : XML) : FMGeo
		{
			return FMGeo.createFromXML(xml);
		}
		
		/**
		 * @inheritDoc
		 */
		public function createPlayList(xml : XML) : FMPlayList
		{
			return FMPlayList.createFromXML(xml);
		}
		
		/**
		 * @inheritDoc
		 */
		public function createTag(xml : XML) : FMTag
		{
			return FMTag.createFromXML(xml);
		}
		
		/**
		 * @inheritDoc
		 */
		public function createTrack(xml : XML, isXSPF : Boolean = false) : FMTrack
		{
			if(isXSPF){
				return FMTrack.createFromXSPF(xml);
			}else{
				return FMTrack.createFromXML(xml);
			}
			return null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function createUser(xml : XML) : FMUser
		{
			return FMUser.createFromXML(xml);
		}
		
		/**
		 * @inheritDoc
		 */
		public function createVenue(xml : XML) : FMVenue
		{
			return FMVenue.createFromXML(xml);
		}
		
		/**
		 * @inheritDoc
		 */
		public function createChartDateRange(xml : XML) : FMChartDateRange
		{
			return FMChartDateRange.createFromXML(xml);
		}
		
		/**
		 * @inheritDoc
		 */
		public function createImage(xml : XML) : FMImage
		{
			return FMImage.createFromXML(xml);
		}
		
		/**
		 * @inheritDoc
		 */
		public function createImageFile(xml : XML) : FMImageFile
		{
			return FMImageFile.createFromXML(xml);
		}
		
		/**
		 * @inheritDoc
		 */
		public function createInfo(xml : XML) : FMInfo
		{
			return FMInfo.createFromXML(xml);
		}
		
		/**
		 * @inheritDoc
		 */
		public function createLocation(xml : XML) : FMLocation
		{
			return FMLocation.createFromXML(xml);
		}
		
		/**
		 * @inheritDoc
		 */
		public function createOwner(xml : XML) : FMOwner
		{
			return FMOwner.createFromXML(xml);
		}
		
		/**
		 * @inheritDoc
		 */
		public function createShout(xml : XML) : FMShout
		{
			return FMShout.createFromXML(xml);
		}
	}
}
