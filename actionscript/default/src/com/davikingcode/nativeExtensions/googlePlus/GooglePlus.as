package com.davikingcode.nativeExtensions.googlePlus {

	import flash.events.EventDispatcher;
	import flash.external.ExtensionContext;

	public class GooglePlus extends EventDispatcher {

		private static var _instance:GooglePlus;

		public static function getInstance():GooglePlus {
			return _instance;
		}

		public function GooglePlus() {

			_instance = this;
		}

		public function init():void {

		}

	}
}