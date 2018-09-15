package boost;

import flixel.FlxG;
import flixel.FlxState;

class State extends FlxState {
	var angle:Float;
	var zoom:Float;

	public function double_camera_size() {
		FlxG.camera.setSize(FlxG.width * 2, FlxG.height * 2);
		FlxG.camera.setPosition(-FlxG.width * 0.5, -FlxG.height * 0.5);
	}
}
