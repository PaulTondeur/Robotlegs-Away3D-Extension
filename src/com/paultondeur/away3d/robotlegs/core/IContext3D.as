package com.paultondeur.away3d.robotlegs.core {
	import away3d.containers.View3D;

	/**
	 * @author Paul Tondeur
	 */
	public interface IContext3D {
		function get view3D() : View3D;

		function set view3D(value : View3D) : void

		function get threeDeeMap() : IMediator3DMap;

		function set threeDeeMap(value : IMediator3DMap) : void
	}
}
