package com.paultondeur.away3d.robotlegs.examples.carexample.model {
	import flash.events.Event;

	/**
	 * @author Paul Tondeur
	 */
	public class LightsModelEvent extends Event {
		public static const UPDATED : String = "updated";

		public function LightsModelEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}
