package com.davikingcode.nativeExtensions.googlePlus {

	import flash.events.EventDispatcher;
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

		}

		public function init():void {

			extensionContext.call("init");
		}

	}
}