package {
	import com.paultondeur.away3d.robotlegs.examples.carexample.CarContext;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	/**
	 * @author Paul Tondeur
	 */
	 [SWF(backgroundColor="#010101", frameRate="60", width="1024", height="768")]
	public class CarApplication extends Sprite {
		private var _context : CarContext;

		public function CarApplication() {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;

			_context = new CarContext(this);
		}
	}
}
