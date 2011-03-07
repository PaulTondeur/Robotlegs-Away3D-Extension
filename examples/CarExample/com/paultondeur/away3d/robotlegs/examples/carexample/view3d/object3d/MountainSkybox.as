package com.paultondeur.away3d.robotlegs.examples.carexample.view3d.object3d {
	import away3d.materials.utils.CubeMap;
	import away3d.primitives.SkyBox;

	/**
	 * @author Paul Tondeur
	 */
	public class MountainSkybox extends SkyBox {
		[Embed(source="assets/skymaps/mountain/snow_positive_x.jpg")]
		private var EnvPosX : Class;
		[Embed(source="assets/skymaps/mountain/snow_positive_y.jpg")]
		private var EnvPosY : Class;
		[Embed(source="assets/skymaps/mountain/snow_positive_z.jpg")]
		private var EnvPosZ : Class;
		[Embed(source="assets/skymaps/mountain/snow_negative_x.jpg")]
		private var EnvNegX : Class;
		[Embed(source="assets/skymaps/mountain/snow_negative_y.jpg")]
		private var EnvNegY : Class;
		[Embed(source="assets/skymaps/mountain/snow_negative_z.jpg")]
		private var EnvNegZ : Class;
		private var _envMap : CubeMap;

		public function MountainSkybox() {
			_envMap = new CubeMap(new EnvPosX().bitmapData, new EnvNegX().bitmapData, new EnvPosY().bitmapData, new EnvNegY().bitmapData, new EnvPosZ().bitmapData, new EnvNegZ().bitmapData);
			super(_envMap);
		}
	}
}
