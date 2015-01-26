package com.davikingcode.nativeExtensions.googlePlus {

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

			_instance = this;
		}
		
		public function login(key:String):void {
		}

		public function signOut():void {
		}

		public function disconnect():void {
		}

		public function isAuthenticated():Boolean {
			return false;
		}

		public function shareURL(url:String, text:String = "", useNativeShareDialog:Boolean = true):void {
		}

		/*public function sharePost(title:String, description:String = "", thumbnailURL:String = "", useNativeShareDialog:Boolean = true):void {
		}*/

	}
}