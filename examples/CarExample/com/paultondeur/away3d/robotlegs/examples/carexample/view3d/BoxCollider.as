package com.paultondeur.away3d.robotlegs.examples.carexample.view3d {
	import com.paultondeur.away3d.robotlegs.base.Mediator3D;
	import com.paultondeur.away3d.robotlegs.base.Render3DEvent;

	/**
	 * @author Paul Tondeur
	 */
	public class BoxCollider extends Mediator3D {
		override public function onRegister() : void {
			eventMap.mapListener(eventDispatcher, Render3DEvent.POST_RENDER, onCheckCollision);
		}

		private function onCheckCollision(event:Render3DEvent) : void {
			//TODO: Implement collision detection :-)
		}
	}
}
