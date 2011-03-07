package com.paultondeur.away3d.robotlegs.base {
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.View3D;
	import away3d.events.Scene3DEvent;

	import com.paultondeur.away3d.robotlegs.core.IMediator3D;
	import com.paultondeur.away3d.robotlegs.core.IMediator3DMap;

	import org.robotlegs.base.ContextError;
	import org.robotlegs.core.IInjector;
	import org.robotlegs.core.IReflector;

	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Paul Tondeur
	 */
	public class Mediator3DMap implements IMediator3DMap {
		protected var _view3D : View3D;
		protected var _injector : IInjector;
		protected var _reflector : IReflector;
		protected var _mediatorsByObject3D : Dictionary;
		protected var _mappingConfigByObject3D : Dictionary;
		protected var _mappingConfigByObject3DClassName : Dictionary;

		public function get view3D() : View3D {
			return _view3D;
		}

		public function set view3D(value : View3D) : void {
			if (value != _view3D) {
				removeSceneListeners();
				_view3D = value;
				addSceneListeners();
			}
		}

		public function Mediator3DMap(view3D : View3D, injector : IInjector, reflector : IReflector) {
			_injector = injector;
			_reflector = reflector;
			this.view3D = view3D;

			_mediatorsByObject3D = new Dictionary(true);
			_mappingConfigByObject3D = new Dictionary(true);
			_mappingConfigByObject3DClassName = new Dictionary(false);
		}

		public function mapObject3D(object3DClassOrName : *, mediatorClassOrArray : *, injectObject3DAs : * = null, autoCreate : Boolean = true, autoRemove : Boolean = true) : void {
			var object3DClassName : String = _reflector.getFQCN(object3DClassOrName);

			var config : MappingConfig = new MappingConfig();
			if (mediatorClassOrArray is Array) {
				for each (var mediator:Class in mediatorClassOrArray) {
					checkMediatorClass(mediator, object3DClassName);
				}

				config.mediatorClasses = mediatorClassOrArray;
			} else {
				checkMediatorClass(mediatorClassOrArray, object3DClassName);
				config.mediatorClasses = [mediatorClassOrArray];
			}

			config.autoCreate = autoCreate;
			config.autoRemove = autoRemove;
			if (injectObject3DAs) {
				if (injectObject3DAs is Array) {
					config.typedObject3DClasses = (injectObject3DAs as Array).concat();
				} else if (injectObject3DAs is Class) {
					config.typedObject3DClasses = [injectObject3DAs];
				}
			} else if (object3DClassOrName is Class) {
				config.typedObject3DClasses = [object3DClassOrName];
			}

			_mappingConfigByObject3DClassName[object3DClassName] = config;
		}

		private function checkMediatorClass(mediator : Class, object3DClassName : String) : void {
			if (_mappingConfigByObject3DClassName[object3DClassName] != null)
				throw new ContextError(ContextError.E_MEDIATORMAP_OVR + ' - ' + mediator);

			if (_reflector.classExtendsOrImplements(mediator, IMediator3D) == false)
				throw new ContextError(ContextError.E_MEDIATORMAP_NOIMPL + ' - ' + mediator);
		}

		public function unmapObject3D(object3DClassOrName : *) : void {
			var object3DClassName : String = _reflector.getFQCN(object3DClassOrName);

			delete _mappingConfigByObject3DClassName[object3DClassName];
		}

		public function createMediators(object3D : ObjectContainer3D) : Vector.<IMediator3D> {
			return createMediatorsUsing(object3D);
		}

		public function registerMediators(object3D : ObjectContainer3D, mediators : Vector.<IMediator3D>) : void {
			_mappingConfigByObject3D[object3D] = _mappingConfigByObject3DClassName[getQualifiedClassName(object3D)];
			for each (var mediator:IMediator3D in mediators) {
				_injector.mapValue(_reflector.getClass(mediator), mediator);
				_mediatorsByObject3D[object3D] = mediator;
				mediator.object3D = object3D;
				mediator.preRegister();
			}
		}

		public function removeMediator(mediator : IMediator3D) : IMediator3D {
			if (mediator) {
				var objectMediators : Vector.<IMediator3D> = _mediatorsByObject3D[mediator.object3D];
				var mediatorIndex : int = objectMediators.indexOf(mediator);
				if (mediatorIndex > -1) {
					objectMediators.splice(mediatorIndex, 1);
				}

				if (objectMediators.length == 0) {
					delete _mediatorsByObject3D[objectMediators];
					delete _mappingConfigByObject3D[mediator.object3D];
				}
				mediator.preRemove();
				mediator.object3D = null;
				_injector.unmap(_reflector.getClass(mediator));
			}
			return mediator;
		}

		public function removeMediatorsByObject3D(object3D : ObjectContainer3D) : Vector.<IMediator3D> {
			var mediators : Vector.<IMediator3D> = retrieveMediatorList(object3D);
			for each (var mediator:IMediator3D in mediators) {
				removeMediator(mediator);
			}
			return mediators;
		}

		public function retrieveMediatorList(object3D : ObjectContainer3D) : Vector.<IMediator3D> {
			return _mediatorsByObject3D[object3D];
		}

		public function hasMapping(object3DClassOrName : *) : Boolean {
			var object3DClassName : String = _reflector.getFQCN(object3DClassOrName);
			return (_mappingConfigByObject3DClassName[object3DClassName] != null);
		}

		public function hasMediator(mediator : IMediator3D) : Boolean {
			for each (var objectMediators : Vector.<IMediator3D> in _mediatorsByObject3D) {
				for each (var med:IMediator3D in objectMediators) {
					if (med == mediator)
						return true;
				}
			}

			return false;
		}

		public function hasMediatorsForObject3D(object3D : ObjectContainer3D) : Boolean {
			return _mediatorsByObject3D[object3D] != null;
		}

		protected function removeSceneListeners() : void {
			if (view3D) {
				view3D.scene.removeEventListener(Scene3DEvent.ADDED_TO_SCENE, onViewAdded);
				view3D.scene.removeEventListener(Scene3DEvent.REMOVED_FROM_SCENE, onViewRemoved);
			}
		}

		protected function addSceneListeners() : void {
			if (view3D) {
				view3D.scene.addEventListener(Scene3DEvent.ADDED_TO_SCENE, onViewAdded);
				view3D.scene.addEventListener(Scene3DEvent.REMOVED_FROM_SCENE, onViewRemoved);
			}
		}

		protected function createMediatorsUsing(object3D : ObjectContainer3D, object3DClassName : String = '', config : MappingConfig = null) : Vector.<IMediator3D> {
			var mediators : Vector.<IMediator3D> = _mediatorsByObject3D[object3D];
			if (mediators == null) {
				mediators = new Vector.<IMediator3D>();
				object3DClassName ||= getQualifiedClassName(object3D);
				config ||= _mappingConfigByObject3DClassName[object3DClassName];
				if (config) {
					for each (var claxx:Class in config.typedObject3DClasses) {
						_injector.mapValue(claxx, object3D);
					}
					for each (var mediatorClass:Class in config.mediatorClasses) {
						mediators.push(_injector.instantiate(mediatorClass));
					}
					for each (var clazz:Class in config.typedObject3DClasses) {
						_injector.unmap(clazz);
					}
					registerMediators(object3D, mediators);
				}
			}
			return mediators;
		}

		protected function onViewAdded(event : Scene3DEvent) : void {
			var object3DClassName : String = getQualifiedClassName(event.objectContainer3D);
			var config : MappingConfig = _mappingConfigByObject3DClassName[object3DClassName];
			if (config && config.autoCreate)
				createMediatorsUsing(event.objectContainer3D, object3DClassName, config);
		}

		protected function onViewRemoved(event : Scene3DEvent) : void {
			var config : MappingConfig = _mappingConfigByObject3D[event.objectContainer3D];
			if (config && config.autoRemove) {
				removeMediatorsByObject3D(event.objectContainer3D);
			}
		}
	}
}
class MappingConfig {
	public var mediatorClasses : Array;
	public var typedObject3DClasses : Array;
	public var autoCreate : Boolean;
	public var autoRemove : Boolean;
}