package com.paultondeur.away3d.robotlegs.base {
	import com.paultondeur.away3d.robotlegs.core.IMediator3DMap;

	import org.robotlegs.base.EventMap;
	import org.robotlegs.core.IEventMap;

	import flash.events.Event;
	import flash.events.IEventDispatcher;

	/**
	 * @author Paul Tondeur
	 */
	public class Mediator3D extends Mediator3DBase {
		[Inject]
		public var mediatorMap : IMediator3DMap;
		protected var _eventDispatcher : IEventDispatcher;
		protected var _eventMap : IEventMap;

		public function Mediator3D() {
		}

		override public function preRemove() : void {
			if (_eventMap)
				_eventMap.unmapListeners();
			super.preRemove();
		}

		public function get eventDispatcher() : IEventDispatcher {
			return _eventDispatcher;
		}

		[Inject]
		public function set eventDispatcher(value : IEventDispatcher) : void {
			_eventDispatcher = value;
		}

		/**
		 * Local EventMap
		 *
		 * @return The EventMap for this Actor
		 */
		protected function get eventMap() : IEventMap {
			return _eventMap || (_eventMap = new EventMap(eventDispatcher));
		}

		/**
		 * Dispatch helper method
		 *
		 * @param event The Event to dispatch on the <code>IContext</code>'s <code>IEventDispatcher</code>
		 */
		protected function dispatch(event : Event) : Boolean {
			if (eventDispatcher.hasEventListener(event.type))
				return eventDispatcher.dispatchEvent(event);
			return false;
		}
	}
}
