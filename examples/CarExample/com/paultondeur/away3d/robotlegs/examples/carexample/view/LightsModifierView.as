package com.paultondeur.away3d.robotlegs.examples.carexample.view {
	import com.bit101.components.ColorChooser;
	import com.bit101.components.ComboBox;
	import com.bit101.components.Label;
	import com.bit101.components.Panel;
	import com.bit101.components.Slider;

	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author Paul Tondeur
	 */
	public class LightsModifierView extends Sprite {
		private var _comboBox : ComboBox;
		private var _colorPicker : ColorChooser;
		private var _colorPickerLabel : Label;
		private var _sliderXLabel : Label;
		private var _sliderX : Slider;
		private var _sliderYLabel : Label;
		private var _sliderY : Slider;
		private var _sliderZLabel : Label;
		private var _sliderZ : Slider;
		private var _panel : Panel;
		private var _comboChangeCallback : Function;
		private var _colorPickCallback : Function;
		private var _positionUpdateCallback : Function;

		public function set comboChangeCallback(callBack : Function) : void {
			_comboChangeCallback = callBack;
		}

		public function set colorPickCallback(callBack : Function) : void {
			_colorPickCallback = callBack;
		}

		public function set positionUpdateCallback(callBack : Function) : void {
			_positionUpdateCallback = callBack;
		}

		public function set lights(lightNames : Array) : void {
			_comboBox.items = lightNames;
		}

		public function get lightIndex() : int {
			return _comboBox.selectedIndex;
		}

		public function set lightIndex(index : int) : void {
			_comboBox.selectedIndex = index;
		}

		public function get positionX() : Number {
			return _sliderX.value;
		}

		public function set positionX(position : Number) : void {
			_sliderX.value = position;
		}

		public function get positionY() : Number {
			return _sliderY.value;
		}

		public function set positionY(position : Number) : void {
			_sliderY.value = position;
		}

		public function get positionZ() : Number {
			return _sliderZ.value;
		}

		public function set positionZ(position : Number) : void {
			_sliderZ.value = position;
		}

		public function get color() : uint {
			return _colorPicker.value;
		}

		public function set color(color : uint) : void {
			_colorPicker.value = color;
		}

		public function LightsModifierView() {
			_panel = new Panel(this);
			_panel.width = 150;
			_panel.height = 160;

			_comboBox = new ComboBox(this, 10, 10);
			_comboBox.addEventListener(Event.SELECT, onComboChange);
			_comboBox.width = 130;

			_colorPickerLabel = new Label(this, 10, _comboBox.y + _comboBox.height + 10, "Color:");
			_colorPicker = new ColorChooser(this, _colorPickerLabel.width + 10, _colorPickerLabel.y, 0xFFFFFF, onColorPicked);
			_colorPicker.usePopup = true;

			_sliderXLabel = new Label(this, 10, _colorPickerLabel.y + _colorPickerLabel.height + 10, "X:");
			_sliderX = new Slider("horizontal", this, _colorPicker.x, _sliderXLabel.y, onPositionUpdate);

			_sliderYLabel = new Label(this, 10, _sliderXLabel.y + _sliderXLabel.height + 10, "Y:");
			_sliderY = new Slider("horizontal", this, _colorPicker.x, _sliderYLabel.y, onPositionUpdate);

			_sliderZLabel = new Label(this, 10, _sliderYLabel.y + _sliderYLabel.height + 10, "Z:");
			_sliderZ = new Slider("horizontal", this, _colorPicker.x, _sliderZLabel.y, onPositionUpdate);

			_sliderX.maximum = _sliderY.maximum = _sliderZ.maximum = 1;
			_sliderX.minimum = _sliderY.minimum = _sliderZ.minimum = -1;
		}

		private function onComboChange(event : Event) : void {
			if (_comboChangeCallback != null)
				_comboChangeCallback();
		}

		private function onColorPicked(event : Event) : void {
			if (_colorPickCallback != null)
				_colorPickCallback();
		}

		private function onPositionUpdate(event : Event) : void {
			if (_positionUpdateCallback != null)
				_positionUpdateCallback();
		}
	}
}
