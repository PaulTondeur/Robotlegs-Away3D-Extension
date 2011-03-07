package com.paultondeur.away3d.robotlegs.examples.carexample.view3d {
	import away3d.containers.View3D;

	import com.paultondeur.away3d.robotlegs.base.Mediator3D;
	import com.paultondeur.away3d.robotlegs.base.Render3DEvent;

	import flash.events.KeyboardEvent;
	import flash.geom.Vector3D;
	import flash.ui.Keyboard;

	/**
	 * @author Paul Tondeur
	 */
	public class SimpleSteerBehaviour extends Mediator3D {
		[Inject]
		public var view3D : View3D;
		private var _moveDirection : Vector3D = new Vector3D();

		override public function onRegister() : void {
			eventMap.mapListener(view3D.stage, KeyboardEvent.KEY_DOWN, onKeyDown);
			eventMap.mapListener(view3D.stage, KeyboardEvent.KEY_UP, onKeyUp);
			eventMap.mapListener(eventDispatcher, Render3DEvent.PRE_RENDER, onPreRender);
		}

		private function onPreRender(event : Render3DEvent) : void {
			if(_moveDirection.z==0 && _moveDirection.x!=0)
				object3D.moveForward(2.5);
			else
				object3D.moveForward( _moveDirection.z * 5);
			
			var rotateAxis : Vector3D = new Vector3D(0,_moveDirection.x, 0);
			object3D.rotate(rotateAxis, 1.5);
			
			//object3D.position = object3D.position.add(walkOffset);
		}

		private function onKeyDown(event : KeyboardEvent) : void {
			switch(event.keyCode) {
				case Keyboard.UP:
					_moveDirection.z = 1;
					break;
				case Keyboard.DOWN:
					_moveDirection.z = -1;
					break;
				case Keyboard.LEFT:
					_moveDirection.x = -1;
					break;
				case Keyboard.RIGHT:
					_moveDirection.x = 1;
					break;
			}
		}

		private function onKeyUp(event : KeyboardEvent) : void {
			switch(event.keyCode) {
				case Keyboard.UP:
					_moveDirection.z = 0;
					break;
				case Keyboard.DOWN:
					_moveDirection.z = 0;
					break;
				case Keyboard.LEFT:
					_moveDirection.x = 0;
					break;
				case Keyboard.RIGHT:
					_moveDirection.x = 0;
					break;
			}
		}
	}
}
