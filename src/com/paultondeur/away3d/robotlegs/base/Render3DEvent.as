package com.paultondeur.away3d.robotlegs.base {
	import flash.events.Event;

	/**
	 * @author Paul Tondeur
	 */
	public class Render3DEvent extends Event {
		public static const PRE_RENDER : String = "preRender";
		public static const POST_RENDER : String = "postRender";
		public static const REQUEST_START_RENDERING : String = "requestStartRendering";
		public static const REQUEST_STOP_RENDERING : String = "requestStopRendering";
		
		public function Render3DEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
		}
		
        public override function clone() : Event
		{
			return new Render3DEvent(type, bubbles, cancelable);
		}
	}
}
