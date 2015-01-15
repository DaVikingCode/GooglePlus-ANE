package com.davikingcode.nativeExtensions.googlePlus {

	import flash.events.Event;

	public class GooglePlusEvent extends Event {

		public function GooglePlusEvent( type : String, bubbles : Boolean = false, cancelable : Boolean = false )
		{
			super( type, bubbles, cancelable );
		}
	}
}
