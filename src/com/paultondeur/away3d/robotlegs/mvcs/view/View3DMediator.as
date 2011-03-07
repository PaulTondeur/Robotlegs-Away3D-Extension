package com.paultondeur.away3d.robotlegs.mvcs.view {
	import away3d.containers.View3D;

	import com.paultondeur.away3d.robotlegs.base.Render3DEvent;

	import org.robotlegs.mvcs.Mediator;

	import flash.events.Event;

	/**
	 * @author Paul Tondeur
	 */
	public class View3DMediator extends Mediator {
		[Inject]
		public var view3D : View3D;
		protected var preRender : Render3DEvent = new Render3DEvent(Render3DEvent.PRE_RENDER);
		protected var postRender : Render3DEvent = new Render3DEvent(Render3DEvent.POST_RENDER);

		override public function onRegister() : void {
			eventMap.mapListener(eventDispatcher, Render3DEvent.REQUEST_START_RENDERING, onStart);
			eventMap.mapListener(eventDispatcher, Render3DEvent.REQUEST_STOP_RENDERING, onStop);
		}

		private function onStart(event : Render3DEvent) : void {
			eventMap.mapListener(view3D, Event.ENTER_FRAME, onRender);
		}

		private function onStop(event : Render3DEvent) : void {
			eventMap.mapListener(view3D, Event.ENTER_FRAME, onRender);
		}

		protected function onRender(event : Event) : void {
			dispatch(preRender);
			view3D.render();
			dispatch(postRender);
		}
	}
}
