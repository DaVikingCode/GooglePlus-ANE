package com.davikingcode.nativeExtensions.googlePlus {

	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;

	public class GooglePlus extends EventDispatcher {

		private static var _instance:GooglePlus;

		public var extensionContext:ExtensionContext;

		public static function getInstance():GooglePlus {
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

		public function login(key:String):void {

			extensionContext.call("login", key);
		}

	}
}