package com.paultondeur.away3d.robotlegs.examples.carexample.view3d.object3d {
	import away3d.containers.ObjectContainer3D;
	import away3d.entities.Mesh;
	import away3d.events.ResourceEvent;
	import away3d.loading.ResourceManager;
	import away3d.loading.parsers.AC3DParser;
	import away3d.materials.BitmapMaterial;
	import away3d.materials.MaterialBase;

	/**
	 * @author Paul Tondeur
	 */
	public class Car3D extends ObjectContainer3D implements IHasMaterial {
		[Embed (source="assets/car.ac", mimeType="application/octet-stream")]
		private const carClass : Class;
		[Embed (source="assets/truck_color-red.jpg")]
		private const carMaterialClass : Class;
		private var _model : ObjectContainer3D;
		private var _material : BitmapMaterial;

		public function get material() : MaterialBase {
			return _material;
		}

		public function Car3D() {
			ResourceManager.instance.addEventListener(ResourceEvent.RESOURCE_RETRIEVED, onResourceRetrieved);
			_material = new BitmapMaterial(new carMaterialClass().bitmapData);
			_model = ObjectContainer3D(ResourceManager.instance.parseData(new carClass(), "car", true, AC3DParser));
			//_model.scale(2);
			_model.rotationY = 180;
			recursivelySetMaterial(_model, _material);
		}

		private function onResourceRetrieved(event : ResourceEvent) : void {
			if (event.uri == "car") {
				ResourceManager.instance.removeEventListener(ResourceEvent.RESOURCE_RETRIEVED, onResourceRetrieved);
				recursivelySetMaterial(_model, _material);
				addChild(_model);
			}
		}

		private function recursivelySetMaterial(object3D : ObjectContainer3D, material : MaterialBase) : void {
			var mesh : Mesh;
			var untypedMesh : *;
			for (var i : int = 0; i < object3D.numChildren; ++i) {
				untypedMesh = object3D.getChildAt(i);
				if (untypedMesh is Mesh) {
					mesh = Mesh(object3D.getChildAt(i));
					mesh.material = material;
				} else if (untypedMesh is ObjectContainer3D) {
					recursivelySetMaterial(untypedMesh, material);
				}
			}
		}
	}
}
