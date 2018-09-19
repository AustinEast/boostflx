package boost.system;

import flixel.addons.display.FlxNestedSprite;

/**
 * TODO:
 * - Move Z stuff in here so we can get off flixel fork
 * - Move things that "Children" sprites need here, leaving parent stuff in Entity
 */
class BaseSprite extends FlxNestedSprite {
	/**
	 * Whether the Entity billboard's its angle based on the camera
	 */
	// public var billboard:Bool;
	override public function update(elapsed:Float):Void {
		// TODO: add in a "relative angle" so billboarded sprites can still rotate. Maybe use rotation?
		if (billboard)
			angle = -camera.angle;

		super.update(elapsed);
	}
}
