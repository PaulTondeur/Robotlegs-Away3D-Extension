package com.paultondeur.away3d.robotlegs.examples.carexample.view {
	import away3d.lights.DirectionalLight;
	import away3d.containers.View3D;
	import away3d.lights.LightBase;
	import away3d.lights.PointLight;

	import com.paultondeur.away3d.robotlegs.examples.carexample.model.LightsModel;
	import com.paultondeur.away3d.robotlegs.examples.carexample.model.LightsModelEvent;

	import org.robotlegs.mvcs.Mediator;

	import flash.geom.Vector3D;

	/**
	 * @author Paul Tondeur
	 */
	public class LightsModifierMediator extends Mediator {
		[Inject]
		public var view : LightsModifierView;
		[Inject]
		public var lights : LightsModel;
		[Inject]
		public var view3D : View3D;
		private static const _MAX_POSITION : int = 3000;

		override public function onRegister() : void {
			view.positionUpdateCallback = onUpdatePosition;
			view.colorPickCallback = onPickColor;
			view.comboChangeCallback = onSelectLight;
			eventMap.mapListener(eventDispatcher, LightsModelEvent.UPDATED, onUpdateLights);
			onUpdateLights(null);
		}

		private function onUpdatePosition() : void {
			var sliderPosition : Vector3D = new Vector3D(view.positionX, view.positionY, view.positionZ);
			sliderPosition.scaleBy(_MAX_POSITION);

			var light : LightBase = lights.lights[view.lightIndex];
			light.position = sliderPosition;
		}

		private function onPickColor() : void {
			var light : LightBase = lights.lights[view.lightIndex];
			light.color = view.color;
		}

		private function onSelectLight() : void {
			var light : LightBase = lights.lights[view.lightIndex];
			view.color = light.color;

			var sliderPosition : Vector3D = light.position.clone();
			sliderPosition.scaleBy(1 / _MAX_POSITION);

			view.positionX = sliderPosition.x;
			view.positionY = sliderPosition.y;
			view.positionZ = sliderPosition.z;
		}

		private function onUpdateLights(event : LightsModelEvent) : void {
			var lightNames : Array = new Array();
			var counter : int = 0;
			for each (var light:LightBase in lights.lights) {
				lightNames.push((light is DirectionalLight ? "DirectionalLight " : "PointLight ") + counter);
				counter++;
			}
			view.lights = lightNames;
			
			//First time, auto select first element
			if(counter>0 && view.lightIndex==-1)
				view.lightIndex = 0;
		}
	}
}
