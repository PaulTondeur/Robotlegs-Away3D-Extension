package com.paultondeur.away3d.robotlegs.examples.carexample {
	import com.paultondeur.away3d.robotlegs.examples.carexample.view3d.object3d.IHasMaterial;
	import com.paultondeur.away3d.robotlegs.examples.carexample.controller.Build2DCommand;
	import com.paultondeur.away3d.robotlegs.examples.carexample.controller.Build3DSceneCommand;
	import com.paultondeur.away3d.robotlegs.examples.carexample.controller.Initialize3DCommand;
	import com.paultondeur.away3d.robotlegs.examples.carexample.model.LightsModel;
	import com.paultondeur.away3d.robotlegs.examples.carexample.view.LightsModifierMediator;
	import com.paultondeur.away3d.robotlegs.examples.carexample.view.LightsModifierView;
	import com.paultondeur.away3d.robotlegs.examples.carexample.view3d.BoxCollider;
	import com.paultondeur.away3d.robotlegs.examples.carexample.view3d.LightResponsiveBehaviour;
	import com.paultondeur.away3d.robotlegs.examples.carexample.view3d.SimpleSteerBehaviour;
	import com.paultondeur.away3d.robotlegs.examples.carexample.view3d.object3d.Car3D;
	import com.paultondeur.away3d.robotlegs.examples.carexample.view3d.object3d.Floor;
	import com.paultondeur.away3d.robotlegs.mvcs.Context3D;

	import org.robotlegs.base.ContextEvent;

	import flash.display.DisplayObjectContainer;

	/**
	 * @author Paul Tondeur
	 */
	public class CarContext extends Context3D {
		public function CarContext(contextView : DisplayObjectContainer = null, autoStartup : Boolean = true) {
			super(contextView, autoStartup);
		}

		override protected function mapInjections() : void {
			injector.mapSingleton(LightsModel);

			super.mapInjections();
		}

		override public function startup() : void {
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, Build2DCommand, ContextEvent, true);
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, Build3DSceneCommand, ContextEvent, true);
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, Initialize3DCommand, ContextEvent, true);

			mediatorMap.mapView(LightsModifierView, LightsModifierMediator);

			threeDeeMap.mapObject3D(Car3D, [BoxCollider, SimpleSteerBehaviour, LightResponsiveBehaviour], [Car3D, IHasMaterial]);
			threeDeeMap.mapObject3D(Floor, LightResponsiveBehaviour, [Floor, IHasMaterial]);

			super.startup();
		}
	}
}
