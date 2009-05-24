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
	import fm.last.utils.IFMModelFactory;

	/**
	 * @author christian
	 */
	public class FMModelFacory implements IFMModelFactory 
	{
		public function createAlbum(xml : XML) : FMAlbum
		{
			return FMAlbum.createFromXML(xml);
		}
		
		public function createArtist(xml : XML) : FMArtist
		{
			return FMArtist.createFromXML(xml);
		}
		
		public function createEvent(xml : XML) : FMEvent
		{
			return FMEvent.createFromXML(xml);
		}
		
		public function createGeo(xml : XML) : FMGeo
		{
			return FMGeo.createFromXML(xml);
		}
		
		public function createPlayList(xml : XML) : FMPlayList
		{
			return FMPlayList.createFromXML(xml);
		}
		
		public function createTag(xml : XML) : FMTag
		{
			return FMTag.createFromXML(xml);
		}
		
		public function createTrack(xml : XML, isXSPF : Boolean = false) : FMTrack
		{
			if(isXSPF){
				return FMTrack.createFromXSPF(xml);
			}else{
				return FMTrack.createFromXML(xml);
			}
			return null;
		}
		
		public function createUser(xml : XML) : FMUser
		{
			return FMUser.createFromXML(xml);
		}
		
		public function createVenue(xml : XML) : FMVenue
		{
			return FMVenue.createFromXML(xml);
		}
		
		public function createChart(xml : XML) : FMChart
		{
			return FMChart.createFromXML(xml);
		}
		
		public function createImage(xml : XML) : FMImage
		{
			return FMImage.createFromXML(xml);
		}
		
		public function createImageSize(xml : XML) : FMImageSize
		{
			return FMImageSize.createFromXML(xml);
		}
		
		public function createInfo(xml : XML) : FMInfo
		{
			return FMInfo.createFromXML(xml);
		}
		
		public function createLocation(xml : XML) : FMLocation
		{
			return FMLocation.createFromXML(xml);
		}
		
		public function createOwner(xml : XML) : FMOwner
		{
			return FMOwner.createFromXML(xml);
		}
		
		public function createShout(xml : XML) : FMShout
		{
			return FMShout.createFromXML(xml);
		}
	}
}
