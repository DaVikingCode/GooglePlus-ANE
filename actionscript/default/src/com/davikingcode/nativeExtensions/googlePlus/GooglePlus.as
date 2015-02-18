package com.davikingcode.nativeExtensions.googlePlus {

	import flash.display.BitmapData;
	import flash.events.EventDispatcher;
	import flash.external.ExtensionContext;

	public class GooglePlus extends EventDispatcher {

		private static var _instance:GooglePlus;

		public static function getInstance():GooglePlus {

			if (!_instance)
				_instance = new GooglePlus();

			return _instance;
		}

		public function GooglePlus() {

			if (_instance)
				throw new Error("GooglePlus is already initialized.");

			_instance = this;
		}

		/**
		* Login to the Google+ account via its app. If the user doesn't have the Google+ app, the login is done via the Google+ website.
		* The user is redirected to its app if the login process is cancelled or completed.
		* @param iOSKey The client ID of the app from the Google APIs console <b>(for iOS only)</b>. Not considered by Android.
		* @param extended If true we can read user's mail, user's ID and know who you are on Google+.
		*/
		public function login(iOSKey:String, extended:Boolean = false):void {
		}

		/**
		* Removes the OAuth 2.0 token from the keychain, dispatch <code>GooglePlusEvent.DISCONNECTED</code>.
		*/
		public function signOut():void {
		}

		/**
		* Disconnects the user from the app and revokes previous authentication. If the operation succeeds, the OAuth 2.0 token is also removed from keychain.
		* The token is needed to disconnect so do not call signOut if disconnect is to be called.
		* Dispatch <code>GooglePlusEvent.DISCONNECTED</code> on success.
		*/
		public function disconnect():void {
		}

		public function isAuthenticated():Boolean {
			return false;
		}

		/**
		* Share an URL. Will dispatch a GooglePlusEvent.POST_SHARED on success or GooglePlusEvent.POST_NOT_SHARED if user canceled.
		* @param url The URL to share.
		* @param text Sets the text to prefill user's comment in the share dialog.
		*/
		public function shareURL(url:String, text:String = "", bitmapData:BitmapData = null):void {
		}

		/**
		* Grab the user mail, only works if you set <i>shouldFetchGoogleUserEmail</i> to true when calling <code>login</code> method.
		*/
		public function getUserMail():String {
			return "";
		}

		public function getUserID():String {
			return "";
		}

		/**
		* <b>Android only!</b> Print into the <a href="http://developer.android.com/tools/debugging/ddms.html">DDMS</a> or <a href="http://developer.android.com/tools/help/monitor.html">Device Monitor</a> the <b>SHA1 key</b> and the 
		* <b>package</b> that must be set inside the <a href="https://console.developers.google.com/project">Google+ console</a>.
		*/
		public function debuggerHelper():void {
		}
	}
}