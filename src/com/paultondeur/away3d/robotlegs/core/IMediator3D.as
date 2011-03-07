package com.paultondeur.away3d.robotlegs.core {
	import away3d.containers.ObjectContainer3D;

	/**
	 * @author Paul Tondeur
	 */
	public interface IMediator3D {
		/**
		 * Should be invoked by the <code>IMediatorMap</code> during <code>IMediator</code> registration
		 */
		function preRegister() : void;

		/**
		 * Should be invoked by the <code>IMediator</code> itself when it is ready to be interacted with
		 *
		 * <p>Override and place your initialization code here</p>
		 */
		function onRegister() : void;

		/**
		 * Invoked when the <code>IMediator</code> has been removed by the <code>IMediatorMap</code>
		 */
		function preRemove() : void;

		/**
		 * Should be invoked by the <code>IMediator</code> itself when it is ready to for cleanup
		 *
		 * <p>Override and place your cleanup code here</p>
		 */
		function onRemove() : void;

		/**
		 * The <code>IMediator</code>'s view component
		 *
		 * @return The view component
		 */
		function get object3D() : ObjectContainer3D;

		/**
		 * The <code>IMediator</code>'s view component
		 *
		 * @param The view component
		 */
		function set object3D(object3D : ObjectContainer3D) : void;
	}
}
