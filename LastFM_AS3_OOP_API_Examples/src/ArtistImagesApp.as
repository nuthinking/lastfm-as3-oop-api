package  
{
	import fm.last.enum.FMSortType;
	import fm.last.model.FMArtist;
	import fm.last.model.LastFMPreferences;
	import fm.last.model.vo.FMImage;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;

	/**
	 * @author christian
	 */
	public class ArtistImagesApp extends Sprite 
	{
		public function ArtistImagesApp()
		{
			setupStage();
			
			// You might want to use your API key instead of the test one
			LastFMPreferences.API_KEY = "b25b959554ed76058ac220b7b2e0a026";
			
			var a : FMArtist = new FMArtist("Michael Jackson");
			a.addEventListener(FMArtist.GET_IMAGES, onImagesLoaded);
			// The model incapsulated the multipage loading
			a.getImages(100, FMSortType.POPULARITY);
		}
		
		private function setupStage() : void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			stage.addEventListener(Event.RESIZE, onStageResize);
		}
		
		private function onStageResize(event : Event) : void
		{
			if(numChildren==0)
				return;
			resizeImages();
		}

		private function onImagesLoaded(event : Event) : void
		{
			// You can get to an image url for instance with
			// artist.images[0].getImageBySize(FMImageSizeType.MEDIUM)
			// which will return an FMImageSize which contains: name, width, height and url
			var a : FMArtist = FMArtist(event.currentTarget);
			for each(var img : FMImage in a.images){
				addImage(img);
			}
			resizeImages();
		}
		
		private function resizeImages() : void
		{
			var w : Number = stage.stageWidth / 10;
			var h : Number = stage.stageHeight / 10;
			
			var x : Number = 0;
			var y : Number = 0;
			for(var i:uint; i<numChildren; i++){
				var iv : ImageView = ImageView(getChildAt(i));
				iv.width = w;
				iv.height = h;
				iv.x = x;
				iv.y = y;
				x += w;
				if(Math.round(x) == stage.stageWidth){
					x = 0;
					y += h;
				}
			}
		}

		private function addImage(img : FMImage) : void
		{
			var iv : ImageView = new ImageView(img);
			addChild(iv);
		}
	}
}

import fm.last.enum.FMImageSizeType;
import fm.last.model.vo.FMImage;
import fm.last.model.vo.FMImageFile;

import flash.display.Loader;
import flash.display.Sprite;
import flash.net.URLRequest;

class ImageView extends Sprite
{
	private var bg : Sprite;
	private static const BG_COLOR : uint = 0xCCCCCC;

	public function ImageView(model : FMImage)
	{
		var img : FMImageFile = model.getImageFileBySize(FMImageSizeType.SMALL);
		
		createBg(img.width, img.height);
		
		var loader : Loader = new Loader();
		loader.load(new URLRequest(img.url));
		addChild(loader);
	}

	private function createBg(width : Number, height : Number) : void
	{
		bg = new Sprite();
		bg.graphics.beginFill(BG_COLOR);
		bg.graphics.drawRect(0, 0, width, height);
		addChild(bg);
	}
}
