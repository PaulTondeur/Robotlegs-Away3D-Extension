package com.paultondeur.away3d.robotlegs.examples.carexample.controller {
	import com.paultondeur.away3d.robotlegs.examples.carexample.view.LightsModifierView;
	import away3d.containers.View3D;
	import away3d.debug.AwayStats;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author paul
	 */
	public class Build2DCommand extends Command {
		[Inject]
		public var view3D : View3D;

		override public function execute() : void {
			var stats : AwayStats = new AwayStats(view3D);
			contextView.addChild(stats);
			
			var lightsModifier : LightsModifierView =  new LightsModifierView();
			lightsModifier.x = 10;
			lightsModifier.y = 85;
			contextView.addChild(lightsModifier);
		}
	}
}
