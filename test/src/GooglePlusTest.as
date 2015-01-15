package {

	import com.davikingcode.nativeExtensions.googlePlus.GooglePlus;

	import flash.display.Sprite;

	/**
	 * @author Aymeric
	 */
	public class GooglePlusTest extends Sprite {
		
		private var _googlePlus:GooglePlus;

		public function GooglePlusTest() {
			
			_googlePlus = new GooglePlus();
			
			_googlePlus.init();
		}
	}
}
