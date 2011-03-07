package com.paultondeur.away3d.robotlegs.examples.carexample.view3d {
	import com.paultondeur.away3d.robotlegs.base.Mediator3D;
	import com.paultondeur.away3d.robotlegs.examples.carexample.model.LightsModel;
	import com.paultondeur.away3d.robotlegs.examples.carexample.model.LightsModelEvent;
	import com.paultondeur.away3d.robotlegs.examples.carexample.view3d.object3d.IHasMaterial;

	/**
	 * @author Paul Tondeur
	 */
	public class LightResponsiveBehaviour extends Mediator3D {
		[Inject]
		public var lights : LightsModel;
		[Inject]
		public var object : IHasMaterial;

		override public function onRegister() : void {
			eventMap.mapListener(eventDispatcher, LightsModelEvent.UPDATED, onUpdateLights);
		}

		private function onUpdateLights(event : LightsModelEvent) : void {
			object.material.lights = lights.lights;
		}
	}
}
