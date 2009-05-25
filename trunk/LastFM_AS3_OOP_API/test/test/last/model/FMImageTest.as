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
package test.last.model 
{	import fm.last.enum.FMImageSizeType;
	import fm.last.model.vo.FMImage;
	import fm.last.model.vo.FMImageFile;

	import test.last.model.FMModelTest;

	/**	 * @author christian	 */	public class FMImageTest extends FMModelTest 
	{
		[Embed("../../../data/constructors/image.xml", mimeType="application/octet-stream")]
      	private static const CONSTRUCTOR_XML_CLASS:Class;
      			public function FMImageTest(methodName : String = null)
		{			super(methodName);		}
		
		public function testConstructor () : void
		{
			var o : FMImage = FMImage.createFromXML(getEmbeddedXML(CONSTRUCTOR_XML_CLASS));
			assertEquals("FMImage.createFromXML should set the image name", "CHER14", o.name);
			assertEquals("FMImage.createFromXML should set the image url", "http://www.last.fm/music/Cher/+images/13638451", o.url);
			assertEquals("FMImage.createFromXML should set the image dateAddedRaw", "Mon, 13 Oct 2008 22:06:36", o.dateAddedRaw);
			assertEquals("FMImage.createFromXML should set the image format", "jpg", o.format);
			assertEquals("FMImage.createFromXML should set the image owner type", "user", o.owner.type);
			assertEquals("FMImage.createFromXML should set the image owner name", "AngelPOA", o.owner.name);
			assertEquals("FMImage.createFromXML should set the image owner url", "http://www.last.fm/user/AngelPOA", o.owner.url);
			var originalSize : FMImageFile = o.getImageFileBySize(FMImageSizeType.ORIGINAL);
			assertNotNull("FMImage.createFromXML should set the image size original", originalSize);
			assertEquals("FMImage.createFromXML should set the image size original width", 402, originalSize.width);
			assertEquals("FMImage.createFromXML should set the image size original height", 343, originalSize.height);
			assertEquals("FMImage.createFromXML should set the image size original url", "http://userserve-ak.last.fm/serve/_/13638451/Cher+14.jpg", originalSize.url);
			var largeSquareSize : FMImageFile = o.getImageFileBySize(FMImageSizeType.LARGE_SQUARE);
			assertNotNull("FMImage.createFromXML should set the image size largesquare", largeSquareSize);
			assertEquals("FMImage.createFromXML should set the image size largesquare width", 126, largeSquareSize.width);
			assertEquals("FMImage.createFromXML should set the image size largesquare height", 126, largeSquareSize.height);
			assertEquals("FMImage.createFromXML should set the image size largesquare url", "http://userserve-ak.last.fm/serve/126s/13638451.jpg", largeSquareSize.url);
			assertEquals("FMImage.createFromXML should set the image thumbsUp", 34, o.thumbsUp);
			assertEquals("FMImage.createFromXML should set the image thumbsDown", 13, o.thumbsDown);
		}
	}}