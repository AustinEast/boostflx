package boost.util.flx;

import flixel.FlxCamera;

class FlxCameraUtil {
	public static function double_size(c:FlxCamera) {
		var w = c.width;
		var h = c.height;
		c.setSize(w * 2, h * 2);
		c.setPosition(-w * 0.5, -h * 0.5);
	}
}
