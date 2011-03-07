package com.paultondeur.away3d.robotlegs.base {
	import away3d.containers.ObjectContainer3D;

	import com.paultondeur.away3d.robotlegs.core.IMediator3D;

	/**
	 * @author Paul Tondeur
	 */
	public class Mediator3DBase implements IMediator3D {
		/**
		 * Internal
		 *
		 * <p>In the case of deffered instantiation, onRemove might get called before
		 * onCreationComplete has fired. This here Bool helps us track that scenario.</p>
		 */
		protected var removed : Boolean;
		protected var _object3D : ObjectContainer3D;

		public function Mediator3DBase() {
			super();
		}

		// ---------------------------------------------------------------------
		// API
		// ---------------------------------------------------------------------
		public function preRegister() : void {
			removed = false;
			onRegister();
		}

		public function onRegister() : void {
		}

		public function preRemove() : void {
			removed = true;
			onRemove();
		}

		public function onRemove() : void {
		}

		public function get object3D() : ObjectContainer3D {
			return _object3D;
		}

		public function set object3D(object3D : ObjectContainer3D) : void {
			_object3D = object3D;
		}
	}
}
