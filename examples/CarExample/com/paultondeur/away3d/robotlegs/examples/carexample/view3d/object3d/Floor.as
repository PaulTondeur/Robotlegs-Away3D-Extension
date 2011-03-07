package com.paultondeur.away3d.robotlegs.examples.carexample.view3d.object3d {
	import away3d.materials.MaterialBase;
	import away3d.containers.ObjectContainer3D;
	import away3d.materials.BitmapMaterial;
	import away3d.primitives.Plane;

	/**
	 * @author Paul Tondeur
	 */
	public class Floor extends ObjectContainer3D implements IHasMaterial {
		[Embed (source="assets/floorTile.jpg")]
		private const floorTileClass : Class;
		private var _material : BitmapMaterial;
		private var _plane : Plane;

		public function get material() : MaterialBase {
			return _material;
		}
		
		public function Floor() {
			_material = new BitmapMaterial(new floorTileClass().bitmapData);
			_plane = new Plane(_material, 1000, 1000);

			_plane.rotationX = -90;
			addChild(_plane);
		}
	}
}
