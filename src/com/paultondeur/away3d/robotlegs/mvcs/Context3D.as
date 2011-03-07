package com.paultondeur.away3d.robotlegs.mvcs {
	import com.paultondeur.away3d.robotlegs.mvcs.view.View3DMediator;
	import away3d.containers.View3D;

	import com.paultondeur.away3d.robotlegs.base.Mediator3DMap;
	import com.paultondeur.away3d.robotlegs.core.IContext3D;
	import com.paultondeur.away3d.robotlegs.core.IMediator3DMap;

	import org.robotlegs.mvcs.Context;

	import flash.display.DisplayObjectContainer;

	/**
	 * @author Paul Tondeur
	 */
	public class Context3D extends Context implements IContext3D {
		private var _view3D : View3D;
		private var _threeDeeMap : IMediator3DMap;

		public function Context3D(contextView : DisplayObjectContainer = null, autoStartup : Boolean = true) {
			super(contextView, autoStartup);
		}

		public function get view3D() : View3D {
			return _view3D || (_view3D = new View3D());
		}

		public function set view3D(value : View3D) : void {
			_view3D = value;
		}

		public function get threeDeeMap() : IMediator3DMap {
			return _threeDeeMap ||= new Mediator3DMap(view3D, createChildInjector(), reflector);
		}

		public function set threeDeeMap(value : IMediator3DMap) : void {
			_threeDeeMap = value;
		}

		override protected function mapInjections() : void {
			super.mapInjections();
			injector.mapValue(View3D, view3D);
			injector.mapValue(IMediator3DMap, threeDeeMap);
		}

		override public function startup() : void {
			mediatorMap.mapView(View3D, View3DMediator);
			contextView.addChild(view3D);

			super.startup();
		}
	}
}
