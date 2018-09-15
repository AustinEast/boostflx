package boost;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.system.FlxAssets;
import flash.display.BitmapData;
import boost.managers.ControlsManager;
import boost.system.BaseSprite;
import boost.util.RandomUtil;

class Entity extends BaseSprite {
	/**
	 * The Entity's current controller
	 */
	public var controller:Controller;

	/**
	 * The Entity's data
	 */
	public var data:EntityData;

	/**
	 * A callback to apply custom EntityData.
	 * Called during the EntityLoader's `load_from_data()` function
	 */
	public var set_custom:Dynamic->Void = null;

	/**
	 * TODO
	 */
	public var freeze_timer:Float;

	/**
	 * TODO
	 */
	public var jiggle_timer:Float;

	/**
	 * Useful for storing an Entity's main movement acceleration/velocity
	 */
	public var speed:Vector3;
	public var attack:Float;
	public var defense:Float;

	var offset_ref:FlxPoint;

	public function new(X:Float = 0, Y:Float = 0, ?flash_colors:Array<FlxColor>) {
		super(X, Y);

		// Init Vars
		freeze_timer = 0;
		jiggle_timer = 0;
		controller = Controller.NONE;
		offset_ref = offset;
		speed = Vector3.get();
	}

	public function freeze(duration:Float = 0.1, force_restart:Bool = true) {
		force_restart ? freeze_timer = duration : freeze_timer += duration;
	}

	public function jiggle(duration:Float = 0.1, force_restart:Bool = true) {
		offset_ref = offset;
		force_restart ? jiggle_timer = duration : jiggle_timer += duration;
	}

	public function get_anchor():FlxPoint {
		return FlxPoint.get(x + width * 0.5, y + height);
	}

	public function anchor_origin():Void {
		origin.set(frameWidth * 0.5, frameHeight);
	}

	/*function stop_jitter(side:Int = FlxObject.Floor, velocityThreshold:Float = 10) {
		if (this.isTouching(side)) {
			if (side == FlxObject.FLOOR || side == FlxObject.CEILING)
				if(Math.abs(this.velocity.y) < velocityThreshold) this.velocity.y = 0;
			else if (side == FlxObject.WALL)
				if(Math.abs(this.velocity.x) < velocityThreshold) this.velocity.x = 0;
		}
	}*/
	public function move_x_toward(target:Float, speed:Float = 5, threshold:Float = 0):Void {
		if (x >= target + threshold)
			velocity.x -= speed;
		else if (x < target - threshold)
			velocity.x += speed;
	}

	public function move_y_toward(target:Float, speed:Float = 5, threshold:Float = 0):Void {
		if (y >= target + threshold)
			velocity.y -= speed;
		else if (y < target - threshold)
			velocity.y += speed;
	}

	public function accel_x_toward(target:Float, speed:Float = 5, threshold:Float = 0):Void {
		if (x >= target + threshold)
			acceleration.x -= speed;
		else if (x < target - threshold)
			acceleration.x += speed;
	}

	public function accel_y_toward(target:Float, speed:Float = 5, threshold:Float = 0):Void {
		if (y >= target + threshold)
			acceleration.y -= speed;
		else if (y < target - threshold)
			acceleration.y += speed;
	}

	override public function update(elapsed:Float):Void {
		if (freeze_timer > 0)
			freeze_timer -= elapsed;
		else {
			super.update(elapsed);
			if (jiggle_timer > 0) {
				jiggle_timer -= elapsed;
				offset.set(offset_ref.x + RandomUtil.range(-1, 1), offset_ref.y);
			} else {
				offset.set(offset_ref.x, offset_ref.y);
			}
		}
	}

	//--------------------//
	// 3D Slice Functions //
	//--------------------//
	public function loadSlices(img:FlxGraphicAsset, slices:Int, width:Int, height:Int, offset:Float = 1, overwrite:Bool = true, starting_z:Int = 1) {
		if (graphic == null || overwrite)
			loadGraphic(img, true, width, height);
		for (i in starting_z...slices + starting_z)
			loadSlice(img, i, width, height, offset, i, overwrite);
	}

	public function makeSlices(color:FlxColor, slices:Int, width:Int, height:Int, offset:Float = 1, overwrite:Bool = true, starting_z:Int = 1) {
		if (graphic == null)
			makeGraphic(width, height, color);
		for (i in starting_z...slices + starting_z)
			makeSlice(color, i, width, height, offset, overwrite);
	}

	public function loadSlice(img:FlxGraphicAsset, z:Int, width:Int, height:Int, offset:Float = 1, frame:Int = 0, overwrite:Bool = true) {
		var s = getSlice(z, offset, overwrite);
		s.loadGraphic(img, true, width, height);
		s.animation.frameIndex = frame;
		add(s);
	}

	public function makeSlice(color:FlxColor = FlxColor.WHITE, z:Int, width:Int, height:Int, offset:Float = 1, overwrite:Bool = true) {
		var s = getSlice(z, offset, overwrite);
		s.makeGraphic(width, height, color);
		add(s);
	}

	function getSlice(z:Int, offset:Float, overwrite:Bool = true):BaseSprite {
		var s:BaseSprite;
		if (overwrite && children[z - 1] != null) {
			// TODO: Remove cast once BaseSprite has all "z" stuff
			s = cast children[z - 1];
			s.reset(x, y);
		} else
			s = new BaseSprite(x, y);
		s.relativeZ = -z * offset;
		s.z = this.z + s.relativeZ;
		s.solid = false;
		s.camera = camera;
		s.ignoreDrawDebug = true;
		return s;
	}
}
