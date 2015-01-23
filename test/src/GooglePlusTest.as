package {

	import com.davikingcode.nativeExtensions.googlePlus.GooglePlus;
	import com.davikingcode.nativeExtensions.googlePlus.GooglePlusEvent;

	import flash.display.Sprite;

	/**
	 * @author Aymeric
	 */
	public class GooglePlusTest extends Sprite {
		
		private var _googlePlus:GooglePlus;

		public function GooglePlusTest() {
			
			_googlePlus = new GooglePlus();
			
			_googlePlus.addEventListener(GooglePlusEvent.LOGIN_FAILED, _loginFailed);
			_googlePlus.addEventListener(GooglePlusEvent.LOGIN_SUCCESSED, _loginSuccessed);
			_googlePlus.addEventListener(GooglePlusEvent.POST_NOT_SHARED, _postNotShared);
			_googlePlus.addEventListener(GooglePlusEvent.POST_SHARED, _postShared);
			_googlePlus.addEventListener(GooglePlusEvent.DISCONNECTED, _disconnected);

			_googlePlus.login("103213343972-viosupja0di6kact26le0mvf720ab726.apps.googleusercontent.com");
		}

		private function _loginSuccessed(gpEvt:GooglePlusEvent):void {
			
			trace("login successed");
		}

		private function _loginFailed(gpEvt:GooglePlusEvent):void {
			
			trace("login failed");
		}
		
		private function _postShared(gpEvt:GooglePlusEvent):void {
			
			trace("post shared");
		}

		private function _postNotShared(gpEvt:GooglePlusEvent):void {
			
			trace("post not shared");
		}
		
		private function _disconnected(gpEvt:GooglePlusEvent):void {
			
			trace("disconnected");
		}
	}
}
