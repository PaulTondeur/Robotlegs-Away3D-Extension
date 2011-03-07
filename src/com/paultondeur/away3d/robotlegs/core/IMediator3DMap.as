package com.paultondeur.away3d.robotlegs.core {
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.View3D;

	/**
	 * @author Paul Tondeur
	 */
	public interface IMediator3DMap {
		/**
		 * Map an <code>IThreeDeeMediator</code> to a object3D Class
		 *
		 * @param object3DClassOrName The concrete object3D Class or Fully Qualified Class Name
		 * @param mediatorClass The <code>IThreeDeeMediator</code> Class
		 * @param injectObject3DAs The explicit object3D Interface or Class that the mediator depends on OR an Array of such Interfaces/Classes.
		 * @param autoCreate Automatically construct and register an instance of Class <code>mediatorClass</code> when an instance of Class <code>object3DClass</code> is detected
		 * @param autoRemove Automatically remove an instance of Class <code>mediatorClass</code> when its <code>object3DClass</code> leaves the ancestory of the context object3D
		 */
		function mapObject3D(object3DClassOrName : *, mediatorClassOrArray : *, injectObject3DAs : * = null, autoCreate : Boolean = true, autoRemove : Boolean = true) : void;

		/**
		 * Unmap a object3D Class
		 *  
		 * @param object3DClassOrName The concrete object3D Class or Fully Qualified Class Name
		 */
		function unmapObject3D(object3DClassOrName : *) : void;

		/**
		 * Create an instance of a mapped <code>IThreeDeeMediator</code>
		 *
		 * <p>This will instantiate and register a Mediator for a given Object3D Component.
		 * Mediator dependencies will be automatically resolved.</p>
		 *
		 * @param object3D An instance of the object3D Class previously mapped to an <code>IThreeDeeMediator</code> Class
		 * @return The <code>IThreeDeeMediator</code>
		 */
		function createMediators(object3D : ObjectContainer3D) : Vector.<IMediator3D>;

		/**
		 * Manually register an <code>IThreeDeeMediator</code> instance
		 *
		 * <p>NOTE: Registering a Mediator will NOT inject its dependencies.
		 * It is assumed that dependencies are already satisfied.</p>
		 *
		 * @param object3D The object3D component for the <code>IThreeDeeMediator</code>
		 * @param mediator The <code>IThreeDeeMediator</code> to register
		 */
		function registerMediators(object3D : ObjectContainer3D, mediators : Vector.<IMediator3D>) : void;

		/**
		 * Remove a registered <code>IThreeDeeMediator</code> instance
		 *
		 * @param mediator The <code>IThreeDeeMediator</code> to remove
		 * @return The <code>IThreeDeeMediator</code> that was removed
		 */
		function removeMediator(mediator : IMediator3D) : IMediator3D;

		/**
		 * Remove a registered <code>IThreeDeeMediator</code> instance
		 *
		 * @param object3DComponent The object3D that the <code>IThreeDeeMediator</code> was registered with
		 * @return The <code>IThreeDeeMediator</code> that was removed
		 */
		function removeMediatorsByObject3D(object3D : ObjectContainer3D) : Vector.<IMediator3D>;

		/**
		 * Retrieve a registered <code>IThreeDeeMediator</code> instance
		 *
		 * @param object3DComponent The object3D that the <code>IThreeDeeMediator</code> was registered with
		 * @return The <code>IThreeDeeMediator</code>
		 */
		function retrieveMediatorList(object3D : ObjectContainer3D) : Vector.<IMediator3D>;

		/**
		 * Check if the object3D Class has been mapped or not
		 * 
		 * @param object3DClassOrName The concrete object3D Class or Fully Qualified Class Name
		 * 
		 * @return Whether this object3D class has been mapped
		 */
		function hasMapping(object3DClassOrName : *) : Boolean;

		/**
		 * Check if the <code>IThreeDeeMediator</code> has been registered
		 *
		 * @param mediator The <code>IThreeDeeMediator</code> instance
		 * @return Whether this <code>IThreeDeeMediator</code> has been registered
		 */
		function hasMediator(mediator : IMediator3D) : Boolean;

		/**
		 * Check if an <code>IThreeDeeMediator</code> has been registered for a object3D instance
		 *
		 * @param object3DComponent The object3D that the <code>IThreeDeeMediator</code> was registered with
		 * @return Whether an <code>IThreeDeeMediator</code> has been registered for this object3D instance
		 */
		function hasMediatorsForObject3D(object3D : ObjectContainer3D) : Boolean;

		function get view3D() : View3D;

		function set view3D(value : View3D) : void
	}
}
