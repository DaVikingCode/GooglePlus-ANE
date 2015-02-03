package com.davikingcode.nativeExtensions.googlePlus {

	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;

	public class GooglePlus extends EventDispatcher {

		private static var _instance:GooglePlus;

		public var extensionContext:ExtensionContext;

		public static function getInstance():GooglePlus {

			if (!_instance)
				_instance = new GooglePlus();

			return _instance;
		}

		public function GooglePlus() {

			_instance = this;

			extensionContext = ExtensionContext.createExtensionContext("com.davikingcode.nativeExtensions.GooglePlus", null);

			if (!extensionContext)
				throw new Error( "GooglePlus native extension is not supported on this platform." );

			extensionContext.addEventListener(StatusEvent.STATUS, _onStatus);
		}

		private function _onStatus(sEvt:StatusEvent):void {

			switch (sEvt.code) {

				case GooglePlusEvent.LOGIN_FAILED:
					dispatchEvent(new GooglePlusEvent(GooglePlusEvent.LOGIN_FAILED));
					break;

				case GooglePlusEvent.LOGIN_SUCCESSED:
					dispatchEvent(new GooglePlusEvent(GooglePlusEvent.LOGIN_SUCCESSED));
					break;

				case GooglePlusEvent.POST_SHARED:
					dispatchEvent(new GooglePlusEvent(GooglePlusEvent.POST_SHARED));
					break;

				case GooglePlusEvent.POST_NOT_SHARED:
					dispatchEvent(new GooglePlusEvent(GooglePlusEvent.POST_NOT_SHARED));
					break;

				case GooglePlusEvent.DISCONNECTED:
					dispatchEvent(new GooglePlusEvent(GooglePlusEvent.DISCONNECTED));
					break;
			}
		}

		/**
		* Login to the Google+ account via its app. If the user doesn't have the Google+ app, the login is done via the Google+ website.
		* The user is redirected to its app if the login process is cancelled or completed.
		* @param key The client ID of the app from the Google APIs console.
		* @param fetchGoogleUserEmail If true we can read user's mail.
		* @param fetchGoogleUserEmail If true know who you are on Google.
		* @param fetchGoogleUserID If true we can read user's ID.
		*/
		public function login(key:String, fetchGoogleUserEmail:Boolean = false, fetchGooglePlusUser:Boolean = false, fetchGoogleUserID:Boolean = false):void {

			extensionContext.call("login", key, fetchGoogleUserEmail, fetchGooglePlusUser, fetchGoogleUserID);
		}

		/**
		* Removes the OAuth 2.0 token from the keychain, it doesn't dispatch a <code>GooglePlusEvent.DISCONNECTED</code>.
		*/
		public function signOut():void {

			extensionContext.call("signOut");
		}

		/**
		* Disconnects the user from the app and revokes previous authentication. If the operation succeeds, the OAuth 2.0 token is also removed from keychain.
		* The token is needed to disconnect so do not call signOut if disconnect is to be called.
		* Dispatch <code>GooglePlusEvent.DISCONNECTED</code> on success.
		*/
		public function disconnect():void {

			extensionContext.call("disconnect");
		}

		public function isAuthenticated():Boolean {

			return extensionContext.call("isAuthenticated") as Boolean;
		}

		/**
		* Share an URL. Will dispatch a GooglePlusEvent.POST_SHARED on success or GooglePlusEvent.POST_NOT_SHARED if user canceled.
		* @param url The URL to share.
		* @param text Sets the text to prefill user's comment in the share dialog.
		* @param useNativeShareDialog Use the iOS native share dialog without leaving the app, set it to false to share via the browser.
		*/
		public function shareURL(url:String, text:String = "", useNativeShareDialog:Boolean = true):void {

			extensionContext.call("shareURL", url, text, useNativeShareDialog);
		}

		/*public function sharePost(title:String, description:String = "", thumbnailURL:String = "", useNativeShareDialog:Boolean = true):void {

			extensionContext.call("sharePost", title, description, thumbnailURL, useNativeShareDialog);
		}*/

		/**
		* Grab the user mail, only works if you set <i>shouldFetchGoogleUserEmail</i> to true when calling <code>login</code> method.
		*/
		public function getUserMail():String {

			return extensionContext.call("getUserMail") as String;
		}

		public function getUserID():String {
			
			return extensionContext.call("getUserID") as String;
		}

		public function debuggerHelper():void {
		}

	}
}