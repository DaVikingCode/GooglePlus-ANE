package {

	import com.davikingcode.nativeExtensions.googlePlus.GooglePlus;
	import com.davikingcode.nativeExtensions.googlePlus.GooglePlusEvent;

	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;

	/**
	 * @author Aymeric
	 */
	public class GooglePlusTest extends Sprite {
		
		private var _googlePlus:GooglePlus;
		private const _KEY:String = "103213343972-viosupja0di6kact26le0mvf720ab726.apps.googleusercontent.com";
		
		private var _txtGoogleLogin:TextField;
		private var _btnGoogleLogin:Sprite;
		private var _txtPostShared:TextField;

		public function GooglePlusTest() {
			
			_googlePlus = new GooglePlus();
			
			_googlePlus.addEventListener(GooglePlusEvent.LOGIN_FAILED, _loginFailed);
			_googlePlus.addEventListener(GooglePlusEvent.LOGIN_SUCCESSED, _loginSuccessed);
			_googlePlus.addEventListener(GooglePlusEvent.POST_NOT_SHARED, _postNotShared);
			_googlePlus.addEventListener(GooglePlusEvent.POST_SHARED, _postShared);
			_googlePlus.addEventListener(GooglePlusEvent.DISCONNECTED, _disconnected);
			
			_txtGoogleLogin = new TextField();
			_txtGoogleLogin.defaultTextFormat = new TextFormat("Arial", 20);
			_txtGoogleLogin.width = stage.stageWidth;
			_txtGoogleLogin.text = "Logged in Google+ ? False.";
			_txtGoogleLogin.mouseEnabled = false;
			addChild(_txtGoogleLogin);
			
			_txtPostShared = new TextField();
			_txtPostShared.defaultTextFormat = new TextFormat("Arial", 20);
			_txtPostShared.width = stage.stageWidth;
			_txtPostShared.text = "";
			_txtPostShared.y = 100;
			_txtPostShared.mouseEnabled = false;
			addChild(_txtPostShared);

			_googlePlus.login(_KEY);
		}

		private function _loginSuccessed(gpEvt:GooglePlusEvent):void {
			
			trace("login successed");
			
			_txtGoogleLogin.text = "Logged in Google+ ? True.";
		}

		private function _loginFailed(gpEvt:GooglePlusEvent):void {
			
			trace("login failed");
			
			_txtGoogleLogin.text = "Logged in Google+ ? Failed.";
		}
		
		private function _postShared(gpEvt:GooglePlusEvent):void {
			
			trace("post shared");
			
			_txtPostShared.text = "Post Shared";
		}

		private function _postNotShared(gpEvt:GooglePlusEvent):void {
			
			trace("post not shared");
			
			_txtPostShared.text = "Post NOT Shared";
		}
		
		private function _disconnected(gpEvt:GooglePlusEvent):void {
			
			trace("disconnected");
			
			_txtGoogleLogin.text = "Logged in Google+ ? False.";
		}
	}
}
