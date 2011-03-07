package com.paultondeur.away3d.robotlegs.examples.carexample.model {
	import away3d.lights.LightBase;
	import org.robotlegs.mvcs.Actor;

	/**
	 * @author Paul Tondeur
	 */
	public class LightsModel extends Actor {
		private var _lights : Array = new Array();

		public function get lights() : Array {
			return _lights;
		}
		
		public function addLight(light:LightBase):void {
			_lights.push(light);
			dispatch(new LightsModelEvent(LightsModelEvent.UPDATED));
		}
	}
}
