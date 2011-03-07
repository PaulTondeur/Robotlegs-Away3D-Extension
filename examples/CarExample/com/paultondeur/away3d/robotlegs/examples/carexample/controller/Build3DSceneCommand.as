package com.paultondeur.away3d.robotlegs.examples.carexample.controller {
	import away3d.containers.View3D;
	import away3d.lights.DirectionalLight;
	import away3d.lights.PointLight;

	import com.paultondeur.away3d.robotlegs.examples.carexample.model.LightsModel;
	import com.paultondeur.away3d.robotlegs.examples.carexample.view3d.object3d.Car3D;
	import com.paultondeur.away3d.robotlegs.examples.carexample.view3d.object3d.Floor;
	import com.paultondeur.away3d.robotlegs.examples.carexample.view3d.object3d.MountainSkybox;

	import org.robotlegs.mvcs.Command;

	import flash.geom.Vector3D;

	/**
	 * @author Paul Tondeur
	 */
	public class Build3DSceneCommand extends Command {
		[Inject]
		public var view3D : View3D;
		[Inject]
		public var lights : LightsModel;

		override public function execute() : void {
			var car : Car3D = new Car3D();
			view3D.scene.addChild(car);

			var floor : Floor = new Floor();
			view3D.scene.addChild(floor);

			var skybox : MountainSkybox = new MountainSkybox();
			view3D.scene.addChild(skybox);

			var pointLight : PointLight = new PointLight();
			pointLight.position = new Vector3D(1000, 1000, 0);
			view3D.scene.addChild(pointLight);
			lights.addLight(pointLight);

			var directionalLight : DirectionalLight = new DirectionalLight();
			view3D.scene.addChild(directionalLight);
			lights.addLight(directionalLight);
		}
	}
}
